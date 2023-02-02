import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/ui/admin/leaves/bloc%20/admin_leave_event.dart';
import 'package:projectunity/ui/admin/leaves/bloc%20/admin_leaves_state.dart';
import '../../../../model/employee/employee.dart';
import '../../../../model/leave/leave.dart';
import '../../../../services/admin/employee_service.dart';
import '../../../../services/admin/leave_service.dart';

@Injectable()
class AdminLeavesBloc extends Bloc<AdminLeavesEvent, AdminLeavesState> {
  final AdminLeaveService _adminLeaveService;
  final EmployeeService _employeeService;

  AdminLeavesBloc(this._adminLeaveService, this._employeeService)
      : super(const AdminLeavesState()) {
    on<AdminLeavesInitialLoadEvent>(_initialLoad);
  }

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
                employees.where((element) => element.id == e.uid).firstOrNull;
            return emp == null
                ? null
                : LeaveApplication(employee: emp, leave: e);
          })
          .whereNotNull()
          .toList();

      List<LeaveApplication> upcomingLeaveApplications = upcomingLeaves
          .map((e) {
            Employee? emp =
                employees.where((element) => element.id == e.uid).firstOrNull;
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
