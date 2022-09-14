import 'package:injectable/injectable.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:rxdart/rxdart.dart';
import '../../../model/employee/employee.dart';
import '../../../model/leave/leave.dart';
import '../../../services/employee/employee_service.dart';
import '../../../services/leave/admin_leave_service.dart';

@Singleton()
class AbsenceBloc {

  final EmployeeService _employeeService;
  final AdminLeaveService _adminLeaveService;

  AbsenceBloc(this._employeeService, this._adminLeaveService);

  BehaviorSubject<ApiResponse<List<LeaveApplication>>> _absenceEmployees = BehaviorSubject<ApiResponse<List<LeaveApplication>>>();

  Stream<ApiResponse<List<LeaveApplication>>> get absenceEmployee => _absenceEmployees;


  getAbsenceEmployees() async {
    _init();
    _absenceEmployees.add(const ApiResponse.loading());

    List<Employee> _employees = await _employeeService.getEmployees();
    List<Leave> absenceLeaves = await _adminLeaveService.getAllAbsence();

    List<LeaveApplication> _absenceEmployee = absenceLeaves.map((leave) {
      final employee = _employees.firstWhere((emp) => emp.id == leave.uid);
      return LeaveApplication(employee: employee, leave: leave);
    }).toList();

    _absenceEmployees.add(ApiResponse.completed(data: _absenceEmployee));
  }

  dispose(){
     _absenceEmployees.close();
  }

  _init(){
    if(_absenceEmployees.isClosed){
      _absenceEmployees = BehaviorSubject<ApiResponse<List<LeaveApplication>>>();
    }
  }

}
