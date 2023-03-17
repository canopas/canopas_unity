import 'package:equatable/equatable.dart';
import 'employee/employee.dart';
import 'leave/leave.dart';
import 'leave_count.dart';

class LeaveApplication extends Equatable {
  final Employee employee;
  final Leave leave;
  final LeaveCounts? leaveCounts;

  const LeaveApplication(
      {required this.employee, required this.leave, this.leaveCounts});

  @override
  List<Object?> get props => [employee, leave, leaveCounts];
}
