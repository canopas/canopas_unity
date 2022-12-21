import 'package:equatable/equatable.dart';

import '../../../../model/leave_application.dart';

abstract class UpcomingLeavesViewStates extends Equatable {}

class UpcomingLeaveViewInitialState extends UpcomingLeavesViewStates {
  @override
  List<Object?> get props => [];
}
class UpcomingLeaveViewLoadingState extends UpcomingLeavesViewStates {
  @override
  List<Object?> get props => [];
}
class UpcomingLeaveViewFailureState extends UpcomingLeavesViewStates {
  final String error;
  UpcomingLeaveViewFailureState({required this.error});
  @override
  List<Object?> get props => [error];
}
class UpcomingLeaveViewSuccessState extends UpcomingLeavesViewStates {
 final List<LeaveApplication> leaveApplications;
 UpcomingLeaveViewSuccessState({required this.leaveApplications});
  @override
  List<Object?> get props => [leaveApplications];
}