import 'package:equatable/equatable.dart';
import '../../../../../model/leave_application.dart';

abstract class AllLeavesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AllLeavesInitialLoadEvent extends AllLeavesEvent {
  @override
  List<Object?> get props => [];
}

class RemoveLeaveApplicationOnAllLeaveViewEvent extends AllLeavesEvent {
  final LeaveApplication leaveApplication;

  RemoveLeaveApplicationOnAllLeaveViewEvent(this.leaveApplication);

  @override
  List<Object?> get props => [leaveApplication];
}

class RefreshAllLeaveEvent extends AllLeavesEvent{}

class RemoveFilterFromLeavesEvent extends AllLeavesEvent {}

class ApplyFilterToAllLeavesEvent extends AllLeavesEvent {
  final List<int> leaveType;
  final List<int> leaveStatus;
  final DateTime? startDate;
  final DateTime? endDate;

  ApplyFilterToAllLeavesEvent(
      {this.startDate,
      this.endDate,
      this.leaveType = const [],
      this.leaveStatus = const []});

  @override
  List<Object?> get props => [leaveStatus, leaveType, endDate, startDate];
}
