import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/model/employee_leave_count/employee_leave_count.dart';
import 'package:projectunity/model/leave/leave.dart';

class LeaveApplication {
  Employee employee;
  Leave leave;
  LeaveCounts? leaveCounts;

  LeaveApplication({required this.employee, required this.leave, this.leaveCounts});
}
