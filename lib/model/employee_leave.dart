import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/model/leave/leave_request_data.dart';

class EmployeeLeave {
  Employee employee;
  LeaveRequestData leave;

  EmployeeLeave({required this.employee, required this.leave});
}
