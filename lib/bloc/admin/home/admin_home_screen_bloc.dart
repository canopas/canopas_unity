import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/extensions/list.dart';
import 'package:projectunity/model/employee_leave_count/employee_leave_count.dart';
import 'package:projectunity/services/employee/employee_service.dart';
import 'package:projectunity/services/leave/admin_leave_service.dart';
import 'package:rxdart/rxdart.dart';

import '../../../exception/error_const.dart';
import '../../../model/employee/employee.dart';
import '../../../model/leave/leave.dart';
import '../../../model/leave_application.dart';
import '../../../rest/api_response.dart';
import '../../../services/leave/paid_leave_service.dart';

@Injectable()
class AdminHomeScreenBloc extends BaseBLoc {
  final EmployeeService _employeeService;
  final AdminLeaveService _adminLeaveService;
  final PaidLeaveService _userPaidLeaveService;
  int _paidLeaveCount = 0;

  AdminHomeScreenBloc(this._employeeService, this._adminLeaveService,
      this._userPaidLeaveService);

  final _totalEmployees = BehaviorSubject<int>.seeded(0);

  get totalEmployees => _totalEmployees;

  final _totalRequest = BehaviorSubject<int>.seeded(0);

  get totalRequest => _totalRequest;

  final _absenceCount = BehaviorSubject<int>.seeded(0);

  get absenceCount => _absenceCount;

  final _leaveApplication =
      BehaviorSubject<ApiResponse<Map<DateTime, List<LeaveApplication>>>>();

  get leaveApplication => _leaveApplication;

  void _getPaidLeaves() async {
    _paidLeaveCount = await _userPaidLeaveService.getPaidLeaves();
  }

  void _getAbsentEmployees() async {
    List<Leave> _absentEmployees = await _adminLeaveService.getAllAbsence();
    _absenceCount.sink.add(_absentEmployees.length);
  }

  void _listenStream() async {
    _leaveApplication.add(const ApiResponse.loading());

    try {
      _combineStream.listen((event) {
        _totalRequest.add(event.length);

        Map<DateTime, List<LeaveApplication>> map = event.groupBy(
            (leaveApplication) => leaveApplication.leave.appliedOn.dateOnly);
        _leaveApplication.add(ApiResponse.completed(data: map));
      });
    } on Exception {
      leaveApplication
          .add(const ApiResponse.error(error: firestoreFetchDataError));
    }
  }

  Stream<List<LeaveApplication>> get _combineStream => Rx.combineLatest2(
          _adminLeaveService.getAllRequests(),
          _employeeService.getEmployeesStream(),
          (List<Leave> leaveList, List<Employee> employeeList) {
        return leaveList
            .map((leave) {
              _totalEmployees.add(employeeList.length);

              final employee = employeeList
                  .firstWhereOrNull((element) => element.id == leave.uid);
              if (employee == null) {
                return null;
              }
              LeaveCounts _leaveCounts = _addLeaveCount(leave);

              return LeaveApplication(
                  leave: leave, employee: employee, leaveCounts: _leaveCounts);
            })
            .whereNotNull()
            .toList();
      });

  LeaveCounts _addLeaveCount(Leave leave) {
    double _usedLeave = leave.totalLeaves;
    double _remainingLeaves = _paidLeaveCount - _usedLeave;
    return LeaveCounts(
        remainingLeaveCount: _remainingLeaves < 0 ? 0 : _remainingLeaves,
        usedLeaveCount: _usedLeave,
        paidLeaveCount: _paidLeaveCount);
  }

  @override
  void attach() async {
    _getPaidLeaves();
    _getAbsentEmployees();
    _listenStream();
  }

  @override
  void detach() async {
    await _absenceCount.drain();
    _absenceCount.close();
    _totalRequest.close();
    _totalEmployees.close();
    _leaveApplication.close();
  }
}
