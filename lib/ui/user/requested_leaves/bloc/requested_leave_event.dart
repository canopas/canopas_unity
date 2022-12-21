import 'package:equatable/equatable.dart';
import '../../../../model/leave_application.dart';

abstract class RequestedLeavesViewEvents extends Equatable{}

class RequestedLeavesViewInitialLoadEvent extends RequestedLeavesViewEvents{
  @override
  List<Object?> get props => [];
}

class RemoveLeaveApplicationOnRequestedLeavesEvent extends RequestedLeavesViewEvents {
  final LeaveApplication leaveApplication;
  RemoveLeaveApplicationOnRequestedLeavesEvent(this.leaveApplication);
  @override
  List<Object?> get props => [leaveApplication];
}

class NavigateToLeaveDetailsViewRequestedLeavesEvent extends RequestedLeavesViewEvents{
  final LeaveApplication leaveApplication;
  NavigateToLeaveDetailsViewRequestedLeavesEvent({required this.leaveApplication});
  @override
  List<Object?> get props => [leaveApplication];
}


class NavigateToLeaveRequestViewRequestedLeavesEvent extends RequestedLeavesViewEvents{
  @override
  List<Object?> get props => [];
}
