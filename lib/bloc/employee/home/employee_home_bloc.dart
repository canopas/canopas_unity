import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/model/employee_leave_count/employee_leave_count.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/leave/user_leave_service.dart';
import 'package:rxdart/rxdart.dart';
import '../../../exception/error_const.dart';
import '../../../model/employee/employee.dart';
import '../../../model/leave/leave.dart';
import '../../../model/leave_application.dart';
import '../../../rest/api_response.dart';
import '../../../services/employee/employee_service.dart';
import '../../../services/leave/admin_leave_service.dart';
import '../../../services/leave/paid_leave_service.dart';

@Injectable()
class EmployeeHomeBLoc extends BaseBLoc {
  final UserLeaveService _userLeaveService;
  final UserManager _userManager;
  final PaidLeaveService _paidLeaveService;
  final EmployeeService _employeeService;
  final AdminLeaveService _adminLeaveService;

  EmployeeHomeBLoc(
      this._userManager, this._userLeaveService, this._paidLeaveService, this._employeeService, this._adminLeaveService);

  final _leaveCounts = BehaviorSubject<LeaveCounts>.seeded(LeaveCounts());

  Stream<LeaveCounts> get leaveCounts => _leaveCounts.stream;

  _fetchLeaveSummary() async {
    double usedLeaveCount = await _userLeaveService.getUserUsedLeaveCount(_userManager.employeeId);
    int paidLeaves = await _paidLeaveService.getPaidLeaves();
    double availableLeaveCount =
        paidLeaves < usedLeaveCount ? 0 : paidLeaves - usedLeaveCount;

    _leaveCounts.sink.add(LeaveCounts(
        remainingLeaveCount: availableLeaveCount,
        usedLeaveCount: usedLeaveCount,
        paidLeaveCount: paidLeaves));
  }

  final BehaviorSubject<ApiResponse<List<LeaveApplication>>> _absenceEmployees =
  BehaviorSubject<ApiResponse<List<LeaveApplication>>>();

  Stream<ApiResponse<List<LeaveApplication>>> get absenceEmployee =>
      _absenceEmployees;

  _getAbsenceEmployees() async {
    _absenceEmployees.add(const ApiResponse.loading());

    List<Employee> _employees = await _employeeService.getEmployees();
    List<Leave> absenceLeaves = await _adminLeaveService.getAllAbsence();
    try {
      List<LeaveApplication> _absenceEmployee = absenceLeaves.map((leave) {
        final employee = _employees.firstWhereOrNull((emp) => emp.id == leave.uid);
        return (employee==null)?null:LeaveApplication(employee: employee, leave: leave);
      }).whereNotNull().toList();
      _absenceEmployees.add(ApiResponse.completed(data: _absenceEmployee));
    } on Exception catch (_){
      _absenceEmployees.add(const ApiResponse.error(error: firestoreFetchDataError));
    }
  }

  @override
  void attach() {
    _fetchLeaveSummary();
    _getAbsenceEmployees();
  }

  @override
  void detach() async {
    await _leaveCounts.drain();
    _leaveCounts.close();
    _absenceEmployees.close();
  }
}
