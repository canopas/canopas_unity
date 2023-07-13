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
  final UserStateNotifier _userStateNotifier;
  final SpaceService _spaceService;
  final EmployeeRepo _employeeRepo;
  final LeaveRepo _leaveRepo;
  final SpaceManager _spaceManager;
  StreamSubscription<Employee?>? streamSubscription;

  UserStateControllerBloc(this._employeeRepo, this._leaveRepo,
      this._userStateNotifier, this._spaceService, this._spaceManager)
      : super(UserControllerInitialState()) {
    on<CheckUserStatus>(_checkUserStatus);
    on<UpdateUserDataEvent>(_updateUserData);
    on<DeactivateUserEvent>(_deactivateUser);
    if (_userStateNotifier.state == UserState.spaceJoined) {
      add(CheckUserStatus());
    }
    _spaceManager.addListener(() {
      add(CheckUserStatus());
    });
  }

  Future<void> _checkUserStatus(
      CheckUserStatus status, Emitter<UserControllerState> emit) async {
    if (_spaceManager.currentSpaceId == '') {
      if (_userStateNotifier.employee != null ||
          _userStateNotifier.currentSpace != null) {
        _userStateNotifier.removeEmployeeWithSpace();
        await _cancelStreamSubscription();
      }
    } else {
      final Space? space =
          await _spaceService.getSpace(_spaceManager.currentSpaceId);
      if (space == null) {
        return;
      }
      _userStateNotifier.updateSpace(space);
      add(UpdateUserDataEvent());
    }
  }

  Future<void> _updateUserData(
      UpdateUserDataEvent event, Emitter<UserControllerState> emit) async {
    try {
      await _resetStreamSubscription();
      await emit.onEach(
          _employeeRepo.getCurrentUser(uid: _userStateNotifier.userUID!),
          onData: (Employee? user) async {
        if (user == null) {
          emit(UserControllerErrorState(error: firestoreFetchDataError));
        } else {
          if (user.status == EmployeeStatus.inactive) {
            emit(RevokeAccessState());
          } else {
            _userStateNotifier.updateCurrentUser(user);
          }
        }
      }, onError: (error, stackTrace) {
        emit(UserControllerErrorState(error: firestoreFetchDataError));
        FirebaseCrashlytics.instance.recordError(error, stackTrace,
            reason: 'ERROR WHILE LISTENING THE CURRENT USER STRAEM');
      });
    } on Exception catch (error, stacktrace) {
      emit(UserControllerErrorState(error: firestoreFetchDataError));
      FirebaseCrashlytics.instance.recordError(error, stacktrace,
          reason:
              'EXCEPTION == GET CURRENT USER INFO WHEN THE USER STATUS IS ${_userStateNotifier.state}');
    }
  }

  Future<void> _deactivateUser(
      DeactivateUserEvent event, Emitter<UserControllerState> emit) async {
    await _userStateNotifier.removeEmployeeWithSpace();
    _userStateNotifier.removeListener(() {});
  }

  Future<void> _cancelStreamSubscription() async {
    await _leaveRepo.cancel();
    await _employeeRepo.cancel();
  }

  Future<void> _resetStreamSubscription() async {
    await _leaveRepo.reset();
    await _employeeRepo.reset();
  }
}
