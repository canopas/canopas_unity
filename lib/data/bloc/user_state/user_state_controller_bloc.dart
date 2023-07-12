import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/Repo/employee_repo.dart';
import 'package:projectunity/data/Repo/leave_repo.dart';
import 'package:projectunity/data/bloc/user_state/user_state_controller_event.dart';
import 'package:projectunity/data/bloc/user_state/user_controller_state.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/model/space/space.dart';
import '../../model/employee/employee.dart';
import '../../pref/user_preference.dart';
import '../../provider/space_manager.dart';
import '../../provider/user_state.dart';
import '../../services/employee_service.dart';
import '../../services/space_service.dart';

@Injectable()
class UserStateControllerBloc
    extends Bloc<UserStateControllerEvent, UserControllerState> {
  final EmployeeService _employeeService;
  final UserStateNotifier _userStateNotifier;
  final SpaceService _spaceService;
  EmployeeRepo _employeeRepo;
  LeaveRepo leaveRepo;
  final UserPreference _userPreference;
  final SpaceManager _spaceManager;

  UserStateControllerBloc(this._employeeRepo,this.leaveRepo,
      this._employeeService, this._userStateNotifier, this._spaceService,this._userPreference,this._spaceManager)
      : super(UserControllerInitialState()) {
    on<CheckUserStatus>(_checkUserStatus);
    on<UpdateUserDataEvent>(_updateUserData);
    on<DeactivateUserEvent>(_deactivateUser);
    _spaceManager.addListener(() {
      _updateUser();
    });
  }

  void _updateUser(){
    //if(_userStateNotifier.state==UserState.update)
    print('update user is called');
    add(CheckUserStatus());
  }

  Future<void> _checkUserStatus(CheckUserStatus status, Emitter<UserControllerState> emit)async{
    if(_userStateNotifier.state== UserState.spaceJoined){
      final Space? space = await _spaceService.getSpace(_spaceManager.currentSpaceId);
      if(space==null){
        return;
      }
      _userStateNotifier.updateSpace(space);
      add(UpdateUserDataEvent());
    }
  }

  Future<void> _updateUserData(UpdateUserDataEvent event, Emitter<UserControllerState> emit)async{
    try{
      await _userStateNotifier.resetStreamSubscription();
      await emit.onEach(_employeeRepo.memberDetails(_userStateNotifier.userUID!),
      onData: (Employee? user) async {
        print('======================================== ${user!.toJson()}');
        if(user==null){
          emit(UserControllerErrorState(error: firestoreFetchDataError));
        }else{
          if(user.status== EmployeeStatus.inactive){
           emit(RevokeAccessState());
          }else{
            _userStateNotifier.updateCurrentUser(user);
          }}
      },onError: (error, stackTrace){
        emit(UserControllerErrorState(error: firestoreFetchDataError));
        FirebaseCrashlytics.instance.recordError(error, stackTrace,reason: 'ERROR WHILE LISTENING THE CURRENT USER STRAEM');
      }
      );
    }on Exception catch(error,stacktrace){
      emit(UserControllerErrorState(error: firestoreFetchDataError));
      FirebaseCrashlytics.instance.recordError(error,stacktrace,reason: 'EXCEPTION ===== GET CURRENT USER INFO WHEN THE USER STATUS IS ${_userStateNotifier.state}');
    }
  }

  Future<void> _deactivateUser(DeactivateUserEvent event, Emitter<UserControllerState> emit)async{
    await _userStateNotifier.removeEmployeeWithSpace();
  }



// Future<void> _updateEmployee(
//     CheckUserStatus event, Emitter<UserControllerState> emit) async {
//   try {
//     final Employee? employee =
//         await _employeeService.getEmployee(_userStateNotifier.userUID!);
//     final Space? space =
//         await _spaceService.getSpace(_userStateNotifier.currentSpaceId!);
//     if (employee == null ||
//         space == null ||
//         employee.status == EmployeeStatus.inactive) {
//       emit(const UserControllerState(userState: UserState.unauthenticated));
//     } else {
//       if (_userStateNotifier.currentSpace != space ||
//           _userStateNotifier.employee != employee) {
//         await _userStateNotifier.setEmployeeWithSpace(
//             space: space, spaceUser: employee, redirect: false);
//       }
//       emit(const UserControllerState(userState: UserState.authenticated));
//     }
//   } on Exception {
//     emit(const UserControllerState(userState: UserState.unauthenticated));
//   }
// }

// Future<void> _clearData(
//     ClearDataForDisableUser event, Emitter<UserControllerState> emit) async {
//   await _userStateNotifier.removeEmployeeWithSpace();
// }

}
