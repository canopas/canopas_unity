import 'package:injectable/injectable.dart';
import 'package:projectunity/model/employee_leave.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/services/employee/employee_service.dart';
import 'package:projectunity/services/leave/user_leave_service.dart';
import 'package:rxdart/rxdart.dart';

import '../../../model/employee/employee.dart';
import '../../../model/employee_leave.dart';
import '../../../model/leave/leave.dart';

@Singleton()
class EmployeeLeaveBloc {
  final EmployeeService _employeeService;
  final UserLeaveService _userLeaveService;

  EmployeeLeaveBloc(this._employeeService, this._userLeaveService);

  final BehaviorSubject<List<Leave>> _leaves = BehaviorSubject<List<Leave>>();
  final BehaviorSubject<List<Employee>> _employee =
      BehaviorSubject<List<Employee>>();

  BehaviorSubject<List<Leave>> get leaves => _leaves;

  BehaviorSubject<List<Employee>> get employee => _employee;
  final BehaviorSubject<ApiResponse<List<EmployeeLeave>>> _requests =
      BehaviorSubject<ApiResponse<List<EmployeeLeave>>>();

  Stream<ApiResponse<List<EmployeeLeave>>> get requests => _requests.stream;

  getEmployee() async {
    List<Employee> employees = await _employeeService.getEmployees();
    _employee.add(employees);
  }

  getLeaves() async {
    List<Leave> leaves = await _userLeaveService.getAllRequests();
    _leaves.add(leaves);
  }


  allLeaves() {
    _requests.add(const ApiResponse.loading());
    try {
      getLeaves();
      getEmployee();
      Rx.combineLatest2(
        leaves.stream,
        employee.stream,
            (List<Leave> leavesList, List<Employee> employees) =>
            leavesList.map((leave) {
          final employee = employees.firstWhere((emp) => emp.id == leave.uid);
          return EmployeeLeave(employee: employee, leave: leave);
        }).toList(),
      ).listen(
        (event) {
          _requests.add(ApiResponse.completed(data: event));
        },
      );
    } on Exception catch (error) {
      throw Exception(error.toString());
    }
  }
}
