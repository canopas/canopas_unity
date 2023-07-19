import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/bloc/user_state/user_state_controller_event.dart';
import 'package:projectunity/data/bloc/user_state/user_controller_state.dart';
import 'package:projectunity/data/model/space/space.dart';
import '../../Repo/employee_repo.dart';
import '../../model/employee/employee.dart';
import '../../provider/user_state.dart';
import '../../services/space_service.dart';

@Injectable()
class UserStateControllerBloc
    extends Bloc<UserStateControllerEvent, UserControllerState> {
  final EmployeeRepo _employeeRepo;
  final UserStateNotifier _userStateNotifier;
  final SpaceService _spaceService;

  UserStateControllerBloc(
      this._employeeRepo, this._userStateNotifier, this._spaceService)
      : super(const UserControllerState()) {
    on<CheckUserStatus>(_updateEmployee);
    on<ClearDataForDisableUser>(_clearData);
    on<UpdateUserData>(_updateData);
  }

  Future<void> _updateEmployee(
      CheckUserStatus event, Emitter<UserControllerState> emit) async {
    try {
      final Space? space =
          await _spaceService.getSpace(_userStateNotifier.currentSpaceId!);
      return emit.forEach(
        _employeeRepo.memberDetails(_userStateNotifier.employeeId),
        onData: (Employee? employee) {
          if (employee != null &&
              space != null &&
              employee.status == EmployeeStatus.active) {
            _userStateNotifier.setEmployeeWithSpace(space: space, spaceUser: employee, redirect: false);
            return const UserControllerState(userState: UserState.authenticated);
          } else {
            return const UserControllerState(
                userState: UserState.unauthenticated);
          }
        },
        onError: (error, _) {
           return const UserControllerState(userState: UserState.unauthenticated);
        },
      );
    } on Exception {
      emit(const UserControllerState(userState: UserState.unauthenticated));
    }
  }

  Future<void> _updateData(
      UpdateUserData event, Emitter<UserControllerState> emit) async {

  }

  Future<void> _clearData(
      ClearDataForDisableUser event, Emitter<UserControllerState> emit) async {
    await _userStateNotifier.removeEmployeeWithSpace();
  }
}
