import 'package:equatable/equatable.dart';
import '../../../../../model/leave/leave.dart';
import '../../../../../model/leave_application.dart';

abstract class EmployeeLeaveDetailsEvents extends Equatable {}

class EmployeeLeaveDetailsInitialLoadEvents extends EmployeeLeaveDetailsEvents{
  final LeaveApplication leaveApplication;
  EmployeeLeaveDetailsInitialLoadEvents({required this.leaveApplication});
  @override
  List<Object?> get props => [leaveApplication];
}

class EmployeeLeaveDetailsRemoveLeaveRequestEvent extends EmployeeLeaveDetailsEvents {
  final Leave leave;
  EmployeeLeaveDetailsRemoveLeaveRequestEvent(this.leave);
  @override
  List<Object?> get props => [leave];
}