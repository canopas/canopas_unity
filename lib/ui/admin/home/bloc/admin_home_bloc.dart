import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/extensions/list.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import 'package:projectunity/ui/admin/home/bloc/admin_home_event.dart';
import 'package:projectunity/ui/admin/home/bloc/admin_home_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../model/employee/employee.dart';
import '../../../../model/leave/leave.dart';
import '../../../../model/leave_count.dart';
import '../../../../navigation/navigation_stack_manager.dart';
import '../../../../services/admin/employee/employee_service.dart';
import '../../../../services/admin/paid_leave/paid_leave_service.dart';
import '../../../../services/admin/requests/admin_leave_service.dart';
import '../../../../services/leave/user_leave_service.dart';

@Injectable()
class AdminHomeBloc extends Bloc<AdminHomeEvent, AdminHomeState> {
  final AdminLeaveService _adminLeaveService;
  final EmployeeService _employeeService;
  final UserLeaveService _userLeaveService;
  final PaidLeaveService _paidLeaveService;
  StreamSubscription? _subscription;
  final NavigationStackManager _navigationStackManager;
  List<Employee> employees=[];

  AdminHomeBloc(this._navigationStackManager,this._adminLeaveService,this._employeeService,this._userLeaveService,this._paidLeaveService)
      : super(const AdminHomeState()) {
    on<AdminHomeInitialLoadEvent>(_onPageLoad);
    on(_onNavigationEvent);
  }

  void _onPageLoad(
      AdminHomeInitialLoadEvent event, Emitter<AdminHomeState> emit) async {
    emit(state.copyWith(status: AdminHomeStatus.loading));
   await   _addTotalOfAbsence(emit);
   await  _loadLeaveApplications(event, emit);
  }

  Future<void> _addTotalOfAbsence(Emitter<AdminHomeState> emit) async {
    List<Leave> absence = await _adminLeaveService.getAllAbsence();
    emit(state.copyWith(totalAbsence: absence.length));
  }

  Future<void> _loadLeaveApplications(
      AdminHomeInitialLoadEvent event, Emitter<AdminHomeState> emit) async {
    await _subscription?.cancel();
    try {
      await emit
          .forEach<List<LeaveApplication>>(_changeLeaveApplicationFormat(),
              onData: (List<LeaveApplication> leaveApplications) {
        return state.copyWith(
          status: AdminHomeStatus.success,
          leaveAppMap: convertListToMap(leaveApplications),
          totalOfEmployees: employees.length,
          totalOfRequests: leaveApplications.length,
        );
      });
    } catch (_) {
      emit( state.failureState(failureMessage: firestoreFetchDataError));
    }
  }

  Stream<List<LeaveApplication>> _changeLeaveApplicationFormat() {
    final StreamController<List<LeaveApplication>> applications =
        StreamController<List<LeaveApplication>>();
    _subscription = combineStream.listen((event) async {
      List<LeaveApplication> list = [];
      event.isEmpty
          ? applications.sink.add(list)
          : Future.wait(event.map((leaveApplication) async {
              LeaveApplication application =
                  await _addLeavesTo(leaveApplication);
              list.add(application);
              applications.sink.add(list);
            }));
    });
    return applications.stream;
  }

  Stream<List<LeaveApplication>> get combineStream => Rx.combineLatest2(
          _adminLeaveService.getLeaveStream,
          _employeeService.getEmployeeStream, (
        List<Leave> leaveList,
        List<Employee> employeeList,
      ) {
        employees = employeeList;
        return leaveList
            .map((leave) {
              final employee = employeeList
                  .firstWhereOrNull((element) => element.id == leave.uid);
              if (employee == null) {
                return null;
              }
              return LeaveApplication(leave: leave, employee: employee);
            })
            .whereNotNull()
            .toList();
      });

  Future<LeaveApplication> _addLeavesTo(LeaveApplication application) async {
    int paidLeaves = await _paidLeaveService.getPaidLeaves();
    double usedLeave =
        await _userLeaveService.getUserUsedLeaveCount(application.employee.id);
    double remainingLeaves = paidLeaves - usedLeave;
    LeaveCounts leaveCounts = LeaveCounts(
        remainingLeaveCount: remainingLeaves < 0 ? 0 : remainingLeaves,
        usedLeaveCount: usedLeave,
        paidLeaveCount: paidLeaves);
    return LeaveApplication(
        employee: application.employee,
        leave: application.leave,
        leaveCounts: leaveCounts);
  }

  Future<void> _onNavigationEvent(AdminHomeEvent event,Emitter<AdminHomeState> emit) async{
    if (event is AdminHomeNavigateToAddMember) {
      _navigateToAddMember();
    } else if (event is AdminHomeNavigateToSetting) {
      _navigateSettings();
    } else if (event is AdminHomeNavigateToEmployeeList) {
      _navigateToEmployeeList();
    } else if (event is AdminHomeNavigateToApplicationDetail) {
      _navigateToApplicationDetail(event.leaveApplication);
    } else if (event is AdminHomeNavigateToAbsenceList) {
      _navigateToAbsence();
    }
  }

  void _navigateToAddMember() {
    _navigationStackManager.push(const NavStackItem.addMemberState());
  }

  void _navigateSettings() {
    _navigationStackManager.push(const NavStackItem.adminSettingsState());
  }

  void _navigateToEmployeeList() {
    _navigationStackManager.push(const NavStackItem.adminEmployeeListState());
  }

  void _navigateToApplicationDetail(LeaveApplication leaveApplication) {
    _navigationStackManager
        .push(NavStackItem.leaveDetailState(leaveApplication));
  }

  void _navigateToAbsence() {
    _navigationStackManager.push(const NavStackItem.whoIsOutCalendarState());
  }

  Map<DateTime, List<LeaveApplication>> convertListToMap(
      List<LeaveApplication> leaveApplications) {
    return leaveApplications.groupBy(
        (leaveApplication) => leaveApplication.leave.appliedOn.dateOnly);
  }

  @override
  Future<void> close() async {
    _subscription?.cancel();
    super.close();
  }
}
