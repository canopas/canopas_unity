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
  List<Employee> _employees = [];

  AdminLeavesBloc(this._adminLeaveService, this._employeeService)
      : super(const AdminLeavesState()) {
    on<AdminLeavesInitialLoadEvent>(_initialLoad);
    on<AdminFetchMoreRecentLeavesEvent>(_loadMoreRecentLeaves);
  }

  void _initialLoad(
      AdminLeavesInitialLoadEvent event, Emitter<AdminLeavesState> emit) async {
    emit(state.copyWith(status: AdminLeavesStatus.loading));
    try {
    _employees = await _employeeService.getEmployees();

    List<Leave> leaves = await _adminLeaveService.getRecentLeaves();

    List<LeaveApplication> recentLeaveApplications = leaves
        .map((e) {
          Employee? emp =
              _employees.where((element) => element.id == e.uid).firstOrNull;
          return emp == null ? null : LeaveApplication(employee: emp, leave: e);
        })
        .whereNotNull()
        .toList();
      emit(state.copyWith(
          status: AdminLeavesStatus.success,
          upcomingLeaves: [],
          recentLeaves: recentLeaveApplications));
    } on Exception {
      emit(state.copyWith(
          status: AdminLeavesStatus.failure, error: firestoreFetchDataError));
    }
  }

  void _loadMoreRecentLeaves(
      AdminFetchMoreRecentLeavesEvent event, Emitter<AdminLeavesState> emit) async {
    emit(state.copyWith(fetchMoreRecentLeaves: true));
    try {
      List<Leave> leaves = await _adminLeaveService.getMoreRecentLeaves(leaves: state.recentLeaves.map((e) => e.leave).toList());

      List<LeaveApplication> recentLeaveApplications = leaves
          .map((e) {
        Employee? emp =
            _employees.where((element) => element.id == e.uid).firstOrNull;
        return emp == null ? null : LeaveApplication(employee: emp, leave: e);
      })
          .whereNotNull()
          .toList();
      emit(state.copyWith(
          status: AdminLeavesStatus.success,
          fetchMoreRecentLeaves: false,
          upcomingLeaves: [],
          recentLeaves: recentLeaveApplications));
    } on Exception {
      emit(state.copyWith(
          status: AdminLeavesStatus.failure, error: firestoreFetchDataError, fetchMoreRecentLeaves: false));
    }
  }

  @override
  Future<void> close() {
    _employees.clear();
    return super.close();
  }
}
