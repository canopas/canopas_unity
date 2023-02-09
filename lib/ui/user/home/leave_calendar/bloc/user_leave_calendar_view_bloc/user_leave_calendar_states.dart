import 'package:equatable/equatable.dart';

import '../../../../../../model/leave_application.dart';

abstract class UserLeaveCalendarViewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserLeaveCalendarViewInitialState extends UserLeaveCalendarViewState {}

class UserLeaveCalendarViewLoadingState extends UserLeaveCalendarViewState {}

class UserLeaveCalendarViewSuccessState extends UserLeaveCalendarViewState {
  final List<LeaveApplication> allLeaveApplications;
  final List<LeaveApplication> leaveApplications;

  UserLeaveCalendarViewSuccessState(
      {this.leaveApplications = const [],
      this.allLeaveApplications = const []});

  @override
  List<Object?> get props => [leaveApplications, allLeaveApplications];
}

class UserLeaveCalendarViewFailureState extends UserLeaveCalendarViewState {
  final String error;

  UserLeaveCalendarViewFailureState(this.error);

  @override
  List<Object?> get props => [error];
}
