import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/model/leave/leave.dart';

class LeaveApplication {
  Employee employee;
  Leave leave;

  LeaveApplication({required this.employee, required this.leave});
}
