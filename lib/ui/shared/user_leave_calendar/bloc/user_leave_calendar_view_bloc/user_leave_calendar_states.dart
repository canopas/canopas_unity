import 'package:equatable/equatable.dart';
import '../../../../../model/leave_application.dart';

abstract class UserLeaveCalendarViewState extends Equatable{
  @override
  List<Object?> get props => [];
}

class UserLeaveCalendarViewInitialState extends UserLeaveCalendarViewState {}

class UserLeaveCalendarViewLoadingState extends UserLeaveCalendarViewState {}

class UserLeaveCalendarViewSuccessState extends UserLeaveCalendarViewState {
  final List<LeaveApplication> allLeaves;
  final List<LeaveApplication> leaveApplication;

  UserLeaveCalendarViewSuccessState({this.leaveApplication = const [],this.allLeaves = const []});

  @override
  List<Object?> get props => [leaveApplication,allLeaves];
}

class UserLeaveCalendarViewFailureState extends UserLeaveCalendarViewState {
  final String error;

  UserLeaveCalendarViewFailureState(this.error);

  @override
  List<Object?> get props => [error];
}
