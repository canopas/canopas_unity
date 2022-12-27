import 'package:equatable/equatable.dart';
import '../../../../../model/leave_application.dart';

abstract class AllLeavesViewEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AllLeavesInitialLoadEvent extends AllLeavesViewEvent {
  @override
  List<Object?> get props => [];
}

class RemoveLeaveApplicationOnAllLeaveViewEvent extends AllLeavesViewEvent {
  final LeaveApplication leaveApplication;

  RemoveLeaveApplicationOnAllLeaveViewEvent(this.leaveApplication);

  @override
  List<Object?> get props => [leaveApplication];
}

class RefreshAllLeaveViewEvent extends AllLeavesViewEvent{}

class RemoveFilterAllLeavesViewEvent extends AllLeavesViewEvent {}

class ApplyFilterAllLeavesViewEvent extends AllLeavesViewEvent {
  final List<int> leaveType;
  final List<int> leaveStatus;
  final DateTime? startDate;
  final DateTime? endDate;

  ApplyFilterAllLeavesViewEvent(
      {this.startDate,
      this.endDate,
      this.leaveType = const [],
      this.leaveStatus = const []});

  @override
  List<Object?> get props => [leaveStatus, leaveType, endDate, startDate];
}
