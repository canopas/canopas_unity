import 'package:equatable/equatable.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/model/leave/leave.dart';

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
