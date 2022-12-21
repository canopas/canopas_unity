import 'package:equatable/equatable.dart';
import '../../../../model/leave_application.dart';

abstract class RequestedLeavesViewStates extends Equatable {}

class RequestedLeaveViewInitialState extends RequestedLeavesViewStates {
  @override
  List<Object?> get props => [];
}
class RequestedLeaveViewLoadingState extends RequestedLeavesViewStates {
  @override
  List<Object?> get props => [];
}
class RequestedLeaveViewFailureState extends RequestedLeavesViewStates {
  final String error;
  RequestedLeaveViewFailureState({required this.error});
  @override
  List<Object?> get props => [error];
}
class RequestedLeaveViewSuccessState extends RequestedLeavesViewStates {
  final List<LeaveApplication> leaveApplications;
  RequestedLeaveViewSuccessState({required this.leaveApplications});
  @override
  List<Object?> get props => [leaveApplications];
}