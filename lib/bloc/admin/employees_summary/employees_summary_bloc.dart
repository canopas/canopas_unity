import 'package:injectable/injectable.dart';
import 'package:projectunity/model/employee_summary/employees_summary.dart';
import 'package:projectunity/services/employee/employee_service.dart';
import 'package:projectunity/services/leave/admin_leave_service.dart';
import 'package:rxdart/rxdart.dart';

@Singleton()
class EmployeesSummaryBloc{

  final EmployeeService _employeeService;
  final AdminLeaveService _adminLeaveService;

  EmployeesSummaryBloc(this._adminLeaveService, this._employeeService);

  var _employeeSummary = BehaviorSubject<EmployeesSummary>.seeded(EmployeesSummary(totalEmployeesCount: 0, requestCount: 0, absenceCount: 0));

  BehaviorSubject get employeeSummary => _employeeSummary;


  fetchEmployeeSummary() async {
    if(_employeeSummary.isClosed){
      _restart();
    }
    int _totalEmployeesCount = await _employeeService.getEmployeesCount();
    int _requestCount  = await _adminLeaveService.getRequestsCount();
    int _absenceCount = await _adminLeaveService.getAbsenceCount();
    _employeeSummary.sink.add(EmployeesSummary(totalEmployeesCount: _totalEmployeesCount, requestCount: _requestCount, absenceCount: _absenceCount));
  }

  dispose(){
    _employeeSummary.close();
  }

  _restart(){
    _employeeSummary = BehaviorSubject<EmployeesSummary>.seeded(EmployeesSummary(totalEmployeesCount: 0, requestCount: 0, absenceCount: 0));
  }

}