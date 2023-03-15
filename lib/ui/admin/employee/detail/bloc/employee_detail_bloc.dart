import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/utils/const/role.dart';
import 'package:projectunity/event_bus/events.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/services/employee_service.dart';
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_event.dart';
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_state.dart';
import '../../../../../model/employee/employee.dart';
import '../../../../../services/leave_service.dart';
import '../../../../../services/paid_leave_service.dart';

@Injectable()
class EmployeeDetailBloc
    extends Bloc<EmployeeDetailEvent, AdminEmployeeDetailState> {
  final LeaveService _leaveService;
  final EmployeeService _employeeService;
  final PaidLeaveService _paidLeaveService;

  EmployeeDetailBloc(
      this._paidLeaveService, this._employeeService, this._leaveService)
      : super(EmployeeDetailInitialState()) {
    eventBus.on<EmployeeDetailInitialLoadEvent>().listen((event) {
      add(EmployeeDetailInitialLoadEvent(employeeId: event.employeeId));
    });
    on<EmployeeDetailInitialLoadEvent>(_onInitialLoad);
    on<DeleteEmployeeEvent>(_onDeleteEmployeeEvent);
    on<EmployeeDetailsChangeRoleEvent>(_makeAndRemoveAsAdmin);
  }

  Future<void> _onInitialLoad(EmployeeDetailInitialLoadEvent event,
      Emitter<AdminEmployeeDetailState> emit) async {
    emit(EmployeeDetailLoadingState());

    try {
      Employee? employee = await _employeeService.getEmployee(event.employeeId);
      final double usedLeaves =
          await _leaveService.getUserUsedLeaves(event.employeeId);
      final int totalLeaves = await _paidLeaveService.getPaidLeaves();
      final percentage = usedLeaves / totalLeaves;
      if (employee != null) {
        emit(EmployeeDetailLoadedState(
            employee: employee,
            timeOffRatio: percentage,
            paidLeaves: totalLeaves,
            usedLeaves: usedLeaves));
      } else {
        emit(EmployeeDetailFailureState(error: firestoreFetchDataError));
      }
    } on Exception catch (e){
      emit(EmployeeDetailFailureState(error: firestoreFetchDataError));
    }
  }

  Future<void> _makeAndRemoveAsAdmin(EmployeeDetailsChangeRoleEvent event,
      Emitter<AdminEmployeeDetailState> emit) async {
    if (state is EmployeeDetailLoadedState) {
      final loadedState = state as EmployeeDetailLoadedState;
      int roleType = kRoleTypeEmployee;
      try {
        if (loadedState.employee.roleType != kRoleTypeAdmin) {
          roleType = kRoleTypeAdmin;
        }
        await _employeeService.changeEmployeeRoleType(
            loadedState.employee.id, roleType);
        emit(EmployeeDetailLoadedState(
            employee: loadedState.employee.copyWith(roleType: roleType),
            timeOffRatio: loadedState.timeOffRatio,
            paidLeaves: loadedState.paidLeaves,
            usedLeaves: loadedState.usedLeaves));
      } on Exception {
        emit(EmployeeDetailFailureState(error: firestoreFetchDataError));
      }
    }
  }

  Future<void> _onDeleteEmployeeEvent(
      DeleteEmployeeEvent event, Emitter<AdminEmployeeDetailState> emit) async {
    try {
      await _employeeService.deleteEmployee(event.employeeId);
      await _leaveService.deleteAllLeavesOfUser(event.employeeId);
      eventBus.fire(DeleteEmployeeByAdmin(event.employeeId));
    } on Exception {
      emit(EmployeeDetailFailureState(error: firestoreFetchDataError));
    }
  }
}
