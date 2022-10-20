import 'dart:async';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/extensions/list.dart';
import 'package:projectunity/services/admin/requests/admin_leave_service.dart';
import 'package:rxdart/rxdart.dart';
import '../../../exception/error_const.dart';
import '../../../model/employee/employee.dart';
import '../../../model/leave/leave.dart';
import '../../../model/leave_application.dart';
import '../../../model/leave_count.dart';
import '../../../rest/api_response.dart';
import '../../../services/admin/employee/employee_service.dart';
import '../../../services/admin/paid_leave/paid_leave_service.dart';

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

  Future _getPaidLeaves() async {
    _paidLeaveCount = await _userPaidLeaveService.getPaidLeaves();
  }

  void _getAbsentEmployees() async {
    List<Leave> absentEmployees = await _adminLeaveService.getAllAbsence();
    _absenceCount.sink.add(absentEmployees.length);
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
              LeaveCounts leaveCounts = _addLeaveCount(leave);

              return LeaveApplication(
                  leave: leave, employee: employee, leaveCounts: leaveCounts);
            })
            .whereNotNull()
            .toList();
      });

  LeaveCounts _addLeaveCount(Leave leave) {
    double usedLeave = leave.totalLeaves;
    double remainingLeaves = _paidLeaveCount - usedLeave;
    return LeaveCounts(
        remainingLeaveCount: remainingLeaves < 0 ? 0 : remainingLeaves,
        usedLeaveCount: usedLeave,
        paidLeaveCount: _paidLeaveCount);
  }

  @override
  void attach() async {
    await _getPaidLeaves();
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
