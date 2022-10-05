import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/model/employee_leave_count/employee_leave_count.dart';
import 'package:projectunity/model/employee_summary/employees_summary.dart';
import 'package:projectunity/services/employee/employee_service.dart';
import 'package:projectunity/services/leave/admin_leave_service.dart';
import 'package:rxdart/rxdart.dart';

import '../../../exception/error_const.dart';
import '../../../model/employee/employee.dart';
import '../../../model/leave/leave.dart';
import '../../../model/leave_application.dart';
import '../../../rest/api_response.dart';
import '../../../services/leave/paid_leave_service.dart';
import '../../../services/leave/user_leave_service.dart';

@Injectable()
class AdminHomeScreenBloc extends BaseBLoc {
  final EmployeeService _employeeService;
  final AdminLeaveService _adminLeaveService;
  final UserLeaveService _userLeaveService;
  final PaidLeaveService _userPaidLeaveService;

  AdminHomeScreenBloc(this._employeeService, this._adminLeaveService, this._userLeaveService, this._userPaidLeaveService);


  final BehaviorSubject<ApiResponse<EmployeesSummary>> _employeeSummary = BehaviorSubject<ApiResponse<EmployeesSummary>>.seeded(const ApiResponse.idle());
  BehaviorSubject<ApiResponse<EmployeesSummary>> get employeeSummary => _employeeSummary;


  final BehaviorSubject<ApiResponse<Map<DateTime, List<LeaveApplication>>>> _leaveApplication = BehaviorSubject<ApiResponse<Map<DateTime, List<LeaveApplication>>>>();
  Stream<ApiResponse<Map<DateTime, List<LeaveApplication>>>> get leaveApplication => _leaveApplication.stream;

  int _totalEmployeesCount = 0;
  int _absenceCount = 0;

  _fetchEmployeeSummary() async {
    _employeeSummary.add(const ApiResponse.loading());
    if (_employeeSummary.isClosed) return;

    _totalEmployeesCount = await _employeeService.getEmployeesCount();
    int _requestLeaveCount = _leaveApplicationsList.length;
    _absenceCount = await _adminLeaveService.getAbsenceCount();

    _employeeSummary.add(ApiResponse.completed(data: EmployeesSummary(
        totalEmployeesCount: _totalEmployeesCount,
        requestCount: _requestLeaveCount,
        absenceCount: _absenceCount)));
  }

  List<LeaveApplication> _leaveApplicationsList = <LeaveApplication>[];

  Future<List<LeaveApplication>> _getLeaveApplications(
      List<Leave> leaveList, List<Employee> employees) async {
    _leaveApplicationsList = await Future.wait(leaveList.map((leave) async {
      final employee = employees.firstWhere((emp) => emp.id == leave.uid);
      LeaveCounts _leaveCounts = await _fetchUserRemainingLeave(id: employee.id);
      return LeaveApplication(employee: employee, leave: leave, leaveCounts: _leaveCounts);
    }).toList());
    return _leaveApplicationsList;
  }

  Future<void> _getLeaveApplication() async {
    try {
      _leaveApplication.add(const ApiResponse.loading());

      Rx.combineLatest2(
          _adminLeaveService.getAllRequests(),
          _employeeService.getEmployees().asStream(),
          (List<Leave> leavesList, List<Employee> employees) =>
              _getLeaveApplications(leavesList, employees)).listen(
        (event) async {
          List<LeaveApplication> leaveApp = await event;
          Set<DateTime> _dates = leaveApp
              .map((leaveRequest) =>
                  DateUtils.dateOnly(leaveRequest.leave.appliedOn.toDate))
              .toSet();
          Map<DateTime, List<LeaveApplication>> _leaveApplicationsByDates = {};

          for (var _date in _dates) {
            List<LeaveApplication> _leaveApplications = <LeaveApplication>[];
            for (var leaveApplication in leaveApp) {
              if (_date == DateUtils.dateOnly(leaveApplication.leave.appliedOn.toDate)) {
                _leaveApplications.add(leaveApplication);
              }
            }
            _leaveApplications.sort((a, b) => b.leave.appliedOn.compareTo(a.leave.appliedOn));
            _leaveApplicationsByDates.addEntries([MapEntry(_date, _leaveApplications)]);
          }
          Map<DateTime, List<LeaveApplication>> _sortedMap = Map.fromEntries(_leaveApplicationsByDates.entries.toList()..sort((e1, e2) => e2.key.compareTo(e1.key)));
          _leaveApplication.add(ApiResponse.completed(data: _sortedMap));


          _employeeSummary.sink.add(ApiResponse.completed(data: EmployeesSummary(
            absenceCount: _absenceCount,
            requestCount: leaveApp.length,
            totalEmployeesCount: _totalEmployeesCount,
          )));
        },
      );
    } on Exception catch (_) {
      _leaveApplication.add(const ApiResponse.error(error: firestoreFetchDataError));
    }
  }

  Future<LeaveCounts> _fetchUserRemainingLeave({required String id}) async {
    int _userAllDays = await _userPaidLeaveService.getPaidLeaves();
    int _userUsedDays = await _userLeaveService.getUserUsedLeaveCount(id);
    int _remainingLeave= _userAllDays - _userUsedDays;
    if (_remainingLeave < 0) {
      _remainingLeave = 0;
    }
    return LeaveCounts(allLeaveCount: _userAllDays, availableLeaveCount: _remainingLeave, usedLeaveCount: _userUsedDays);
  }

  @override
  void attach() async {
    _fetchEmployeeSummary();
    await _getLeaveApplication();
  }

  @override
  void detach() async {
    await _employeeSummary.drain();
    _employeeSummary.close();
    _leaveApplication.close();
    _totalEmployeesCount = 0;
    _absenceCount = 0;
    _leaveApplicationsList.clear();
  }
}
