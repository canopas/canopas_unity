import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/leave/user_leave_service.dart';
import '../../../../model/employee/employee.dart';
import '../../../../model/leave/leave.dart';
import '../../../../model/leave_application.dart';
import '../../../../model/leave_count.dart';
import '../../../../navigation/nav_stack/nav_stack_item.dart';
import '../../../../navigation/navigation_stack_manager.dart';
import '../../../../services/admin/employee/employee_service.dart';
import '../../../../services/admin/paid_leave/paid_leave_service.dart';
import '../../../../services/admin/requests/admin_leave_service.dart';
import 'employee_home_event.dart';
import 'employee_home_state.dart';

@Injectable()
class EmployeeHomeBloc extends Bloc<EmployeeHomeEvent, EmployeeHomeState> {
  final UserLeaveService _userLeaveService;
  final UserManager _userManager;
  final PaidLeaveService _paidLeaveService;
  final EmployeeService _employeeService;
  final AdminLeaveService _leaveService;
  final NavigationStackManager _stackManager;

  EmployeeHomeBloc(this._userManager,
      this._userLeaveService,
      this._paidLeaveService,
      this._employeeService,
      this._leaveService,
      this._stackManager)
      : super(const EmployeeHomeState()) {
    on<EmployeeHomeFetchEvent>(_load);
    on<EmployeeHomeShowSetting>((event, emit) {
      _navigateToSetting();
    });
    on<EmployeeHomeShowLeaveCalender>(
        (event, emit) => _navigateToUserCalender());
    on<EmployeeHomeShowAllLeaves>((event, emit) => _navigateToAllLeaves());
    on<EmployeeHomeShowRequestedLeaves>(
        (event, emit) => _navigateToRequestedLeaves());
    on<EmployeeHomeShowUpcomingLeaves>(
        (event, emit) => _navigateToUpcomingLeaves());
    on<EmployeeHomeShowApplyLeave>((event, emit) => _navigateToApplyLeave());
    on<EmployeeHomeShowWhosOut>((event, emit) => _navigateToWhosOutCalendar());
  }

  String get userID => _userManager.employeeId;

  FutureOr<void> _load(
      EmployeeHomeEvent event, Emitter<EmployeeHomeState> emit) async {
    emit(state.copyWith(status: EmployeeHomeStatus.loading));
    await _fetchSummary(emit);
    await _getAbsenceEmployees(emit);
  }

 Future<void> _fetchSummary(Emitter<EmployeeHomeState> emit) async {
    try {
      double usedLeaveCount = await _userLeaveService
          .getUserUsedLeaveCount(_userManager.employeeId);
      int paidLeaves = await _paidLeaveService.getPaidLeaves();
      double availableLeaveCount =
          paidLeaves < usedLeaveCount ? 0 : paidLeaves - usedLeaveCount;

      final leaveCounts = LeaveCounts(
          remainingLeaveCount: availableLeaveCount,
          usedLeaveCount: usedLeaveCount,
          paidLeaveCount: paidLeaves);

      emit(state.copyWith(leaveCounts: leaveCounts));
    } on Exception catch (_) {
      emit(state.failure(error: firestoreFetchDataError));
    }
  }

 Future<void> _getAbsenceEmployees(Emitter<EmployeeHomeState> emit) async {
    try {
      List<Employee> employees = await _employeeService.getEmployees();
      List<Leave> absenceLeaves = await _leaveService.getAllAbsence();

      List<LeaveApplication> absenceEmployee = absenceLeaves
          .map((leave) {
            final employee =
                employees.firstWhereOrNull((emp) => emp.id == leave.uid);
            return (employee == null)
                ? null
                : LeaveApplication(employee: employee, leave: leave);
          })
          .whereNotNull()
          .toList();

      emit(state.copyWith(
          status: EmployeeHomeStatus.success, absence: absenceEmployee));
    } on Exception catch (_) {
      emit(state.failure(error: firestoreFetchDataError));
    }
  }

  void _navigateToUserCalender() {
    _stackManager.push(NavStackItem.userLeaveCalendarState(userId: userID));
  }

  void _navigateToSetting() {
    _stackManager.push(const NavStackItem.employeeSettingsState());
  }

  void _navigateToAllLeaves() {
    _stackManager.push(const NavStackItem.employeeAllLeavesScreenState());
  }

  void _navigateToApplyLeave() {
    _stackManager.push(const NavStackItem.leaveRequestState());
  }

  void _navigateToRequestedLeaves() {
    _stackManager.push(const NavStackItem.employeeRequestedLeavesScreenState());
  }

  void _navigateToUpcomingLeaves() {
    _stackManager.push(const NavStackItem.employeeUpcomingLeavesScreenState());
  }

  void _navigateToWhosOutCalendar() {
    _stackManager.push(const NavStackItem.whoIsOutCalendarState());
  }
}
