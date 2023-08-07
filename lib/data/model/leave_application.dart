import 'package:equatable/equatable.dart';
import 'employee/employee.dart';
import 'leave/leave.dart';

class LeaveApplication extends Equatable {
  final Employee employee;
  final Leave leave;

  const LeaveApplication(
      {required this.employee, required this.leave });

  @override
  List<Object?> get props => [employee, leave];
}
