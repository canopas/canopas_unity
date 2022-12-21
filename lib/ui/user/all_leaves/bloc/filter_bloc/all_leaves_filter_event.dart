import 'package:equatable/equatable.dart';

abstract class AllLeavesFilterEvents extends Equatable {
  @override
  List<Object?> get props => [];

}

class RemoveFilterEvent extends AllLeavesFilterEvents{}

class ApplyFilterEvent extends AllLeavesFilterEvents{}

class LeaveTypeChangeEvent extends AllLeavesFilterEvents{
  final int  leaveType;
  LeaveTypeChangeEvent(this.leaveType);
  @override
  List<Object?> get props => [leaveType];
}

class LeaveStatusChangeEvent extends AllLeavesFilterEvents{
  final int  leaveStatus;
  LeaveStatusChangeEvent(this.leaveStatus);
  @override
  List<Object?> get props => [leaveStatus];
}

class StartDateChangeEvent extends AllLeavesFilterEvents{
  final DateTime? startDate;
  StartDateChangeEvent(this.startDate);
  @override
  List<Object?> get props => [startDate];
}

class EndDateChangeEvent extends AllLeavesFilterEvents{
  final DateTime? endDate;
  EndDateChangeEvent(this.endDate);
  @override
  List<Object?> get props => [endDate];
}

