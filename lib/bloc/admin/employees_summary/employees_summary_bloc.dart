import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/model/employee_summary/employees_summary.dart';
import 'package:projectunity/services/employee/employee_service.dart';
import 'package:projectunity/services/leave/admin_leave_service.dart';
import 'package:rxdart/rxdart.dart';

@Injectable()
class EmployeesSummaryBloc extends BaseBLoc {
  final EmployeeService _employeeService;
  final AdminLeaveService _adminLeaveService;

  EmployeesSummaryBloc(this._adminLeaveService, this._employeeService);

  final _employeeSummary = BehaviorSubject.seeded(EmployeesSummary());

  BehaviorSubject get employeeSummary => _employeeSummary;

  _fetchEmployeeSummary() async {
    if (_employeeSummary.isClosed) return;

    int _totalEmployeesCount = await _employeeService.getEmployeesCount();
    int _requestCount = await _adminLeaveService.getRequestsCount();
    int _absenceCount = await _adminLeaveService.getAbsenceCount();

    _employeeSummary.sink.add(EmployeesSummary(
        totalEmployeesCount: _totalEmployeesCount,
        requestCount: _requestCount,
        absenceCount: _absenceCount));
  }

  @override
  void attach() {
    _fetchEmployeeSummary();
  }

  @override
  void detach() async {
    await _employeeSummary.drain();
    _employeeSummary.close();
  }
}
