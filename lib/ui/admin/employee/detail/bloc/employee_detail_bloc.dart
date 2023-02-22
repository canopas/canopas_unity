import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/utils/const/role.dart';
import 'package:projectunity/event_bus/events.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/services/admin/employee_service.dart';
import 'package:projectunity/services/admin/paid_leave_service.dart';
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_event.dart';
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_state.dart';

import '../../../../../model/employee/employee.dart';
import '../../../../../provider/user_data.dart';
import '../../../../../services/user/user_leave_service.dart';

@Injectable()
class EmployeeDetailBloc
    extends Bloc<EmployeeDetailEvent, AdminEmployeeDetailState> {
  final UserLeaveService _userLeaveService;
  final EmployeeService _employeeService;
  final UserManager _userManager;
  final PaidLeaveService _paidLeaveService;
  StreamSubscription? streamSubscription;
  EmployeeDetailBloc(this._paidLeaveService, this._employeeService,
      this._userLeaveService, this._userManager)
      : super(EmployeeDetailInitialState()) {
    eventBus.on<EmployeeDetailInitialLoadEvent>().listen((event) {
      add(EmployeeDetailInitialLoadEvent(employeeId: event.employeeId));
    });
    on<EmployeeDetailInitialLoadEvent>(_onInitialLoad);
    on<DeleteEmployeeEvent>(_onDeleteEmployeeEvent);
    on<EmployeeDetailsChangeRoleTypeEvent>(_makeAndRemoveAsAdmin);
  }

  Future<void> _onInitialLoad(EmployeeDetailInitialLoadEvent event,
      Emitter<AdminEmployeeDetailState> emit) async {
    emit(EmployeeDetailLoadingState());

    try {
      Employee? employee = await _employeeService.getEmployee(event.employeeId);
      final double usedLeaves = await _userLeaveService
          .getUserUsedLeaveCount(_userManager.employeeId);
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
    } on Exception {
      emit(EmployeeDetailFailureState(error: firestoreFetchDataError));
    }
  }

  bool get currentUserIsAdmin => _userManager.isAdmin;
  String get userEmployeeID => _userManager.employeeId;

  Future<void> _makeAndRemoveAsAdmin(EmployeeDetailsChangeRoleTypeEvent event,
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
      await _userLeaveService.deleteAllLeaves(event.employeeId);
      eventBus.fire(DeleteEmployeeByAdmin(event.employeeId));
    } on Exception {
      emit(EmployeeDetailFailureState(error: firestoreFetchDataError));
    }
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
