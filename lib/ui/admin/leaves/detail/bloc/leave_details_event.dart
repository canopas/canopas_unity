import 'package:equatable/equatable.dart';
import '../../../../../model/leave_application.dart';

abstract class LeaveDetailsEvents extends Equatable {}

class LeaveDetailsInitialLoadEvents extends LeaveDetailsEvents{
  final LeaveApplication leaveApplication;
  LeaveDetailsInitialLoadEvents({required this.leaveApplication});
  @override
  List<Object?> get props => [leaveApplication];
}

class LeaveDetailsRemoveLeaveRequestEvent extends LeaveDetailsEvents {
  final LeaveApplication leaveApplication;
  LeaveDetailsRemoveLeaveRequestEvent(this.leaveApplication);
  @override
  List<Object?> get props => [leaveApplication];
}