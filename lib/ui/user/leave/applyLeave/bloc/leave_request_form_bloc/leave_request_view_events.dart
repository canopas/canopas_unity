import 'package:equatable/equatable.dart';

abstract class LeaveRequestEvents extends Equatable {}

class LeaveRequestFormInitialLoadEvent extends LeaveRequestEvents{
  @override
  List<Object?> get props => [];
}

class LeaveRequestStartDateChangeEvents extends LeaveRequestEvents{
  final DateTime? startDate;
  LeaveRequestStartDateChangeEvents({required this.startDate});
  @override
  List<Object?> get props => [startDate];
}

class LeaveRequestLeaveTypeChangeEvent extends LeaveRequestEvents{
  final int? leaveType;
  LeaveRequestLeaveTypeChangeEvent({required this.leaveType});
  @override
  List<Object?> get props => [leaveType];
}

class LeaveRequestEndDateChangeEvent extends LeaveRequestEvents{
  final DateTime? endDate;
  LeaveRequestEndDateChangeEvent({required this.endDate});
  @override
  List<Object?> get props => [endDate];
}

class LeaveRequestReasonChangeEvent extends LeaveRequestEvents{
  final String reason;
  LeaveRequestReasonChangeEvent({required this.reason});
  @override
  List<Object?> get props => [reason];
}

class LeaveRequestUpdateLeaveOfTheDayEvent extends LeaveRequestEvents{
  final DateTime date;
  final int value;
  LeaveRequestUpdateLeaveOfTheDayEvent({required this.date,required this.value});
  @override
  List<Object?> get props => [date,value];
}

class LeaveRequestApplyLeaveEvent extends LeaveRequestEvents{
  @override
  List<Object?> get props => [];
}


