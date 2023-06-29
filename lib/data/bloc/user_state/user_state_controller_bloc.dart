import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/bloc/user_state/user_state_controller_event.dart';
import 'package:projectunity/data/bloc/user_state/user_controller_state.dart';
import 'package:projectunity/data/model/space/space.dart';
import '../../model/employee/employee.dart';
import '../../provider/user_state.dart';
import '../../services/employee_service.dart';
import '../../services/space_service.dart';

@Injectable()
class UserStateControllerBloc
    extends Bloc<UserStateControllerEvent, UserControllerState> {
  final EmployeeService _employeeService;
  final UserStateNotifier _userManager;
  final SpaceService _spaceService;

  UserStateControllerBloc(
      this._employeeService, this._userManager, this._spaceService)
      : super(const UserControllerState()) {
    on<CheckUserStatus>(_updateEmployee);
    on<ClearDataForDisableUser>(_clearData);
  }

  Future<void> _updateEmployee(
      CheckUserStatus event, Emitter<UserControllerState> emit) async {
    try {
      final Employee? employee =
          await _employeeService.getEmployee(_userManager.userUID!);
      final Space? space =
          await _spaceService.getSpace(_userManager.currentSpaceId!);
      if (employee == null || space == null) {
        emit(const UserControllerState(userState: UserState.unauthenticated));
      } else {
        await _userManager.setEmployeeWithSpace(
            space: space, spaceUser: employee, redirect: false);
        emit(const UserControllerState(userState: UserState.authenticated));
      }
    } on Exception {
      emit(const UserControllerState(userState: UserState.unauthenticated));
    }
  }

  Future<void> _clearData(
      ClearDataForDisableUser event, Emitter<UserControllerState> emit) async {
    await _userManager.removeEmployeeWithSpace();
  }
}
