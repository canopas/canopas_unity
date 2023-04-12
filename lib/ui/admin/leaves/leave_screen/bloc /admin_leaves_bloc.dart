import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/model/employee/employee.dart';
import '../../../../../data/model/leave/leave.dart';
import '../../../../../data/model/leave_application.dart';
import '../../../../../data/provider/user_data.dart';
import '../../../../../data/services/employee_service.dart';
import '../../../../../data/services/leave_service.dart';
import 'admin_leave_event.dart';
import 'admin_leaves_state.dart';

@Injectable()
class AdminLeavesBloc extends Bloc<AdminLeavesEvent, AdminLeavesState> {
  final LeaveService _adminLeaveService;
  final UserManager _userManager;
  final EmployeeService _employeeService;

  AdminLeavesBloc(
      this._adminLeaveService, this._employeeService, this._userManager)
      : super(const AdminLeavesState()) {
    on<AdminLeavesInitialLoadEvent>(_initialLoad);
  }

  bool get isHR => _userManager.isHR;

  void _initialLoad(
      AdminLeavesInitialLoadEvent event, Emitter<AdminLeavesState> emit) async {
    emit(state.copyWith(status: AdminLeavesStatus.loading));
    try {
      List<Employee> employees = await _employeeService.getEmployees();
      List<Leave> recentLeaves = await _adminLeaveService.getRecentLeaves();
      List<Leave> upcomingLeaves = await _adminLeaveService.getUpcomingLeaves();

      List<LeaveApplication> recentLeaveApplications = recentLeaves
          .map((e) {
            Employee? emp =
                employees.where((element) => element.uid == e.uid).firstOrNull;
            return emp == null
                ? null
                : LeaveApplication(employee: emp, leave: e);
          })
          .whereNotNull()
          .toList();

      List<LeaveApplication> upcomingLeaveApplications = upcomingLeaves
          .map((e) {
            Employee? emp =
                employees.where((element) => element.uid == e.uid).firstOrNull;
            return emp == null
                ? null
                : LeaveApplication(employee: emp, leave: e);
          })
          .whereNotNull()
          .toList();

      emit(state.copyWith(
          status: AdminLeavesStatus.success,
          upcomingLeaves: upcomingLeaveApplications,
          recentLeaves: recentLeaveApplications));
    } catch (_) {
      emit(state.copyWith(
          status: AdminLeavesStatus.failure, error: firestoreFetchDataError));
    }
  }
}
