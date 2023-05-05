import 'package:equatable/equatable.dart';
import 'package:projectunity/data/model/leave/leave.dart';

abstract class ApplyLeaveEvent extends Equatable {}


class ApplyLeaveStartDateChangeEvents extends ApplyLeaveEvent{
  final DateTime? startDate;
  ApplyLeaveStartDateChangeEvents({required this.startDate});
  @override
  List<Object?> get props => [startDate];
}

class ApplyLeaveChangeLeaveTypeEvent extends ApplyLeaveEvent{
  final int? leaveType;
  ApplyLeaveChangeLeaveTypeEvent({required this.leaveType});
  @override
  List<Object?> get props => [leaveType];
}

class ApplyLeaveEndDateChangeEvent extends ApplyLeaveEvent{
  final DateTime? endDate;
  ApplyLeaveEndDateChangeEvent({required this.endDate});
  @override
  List<Object?> get props => [endDate];
}

class ApplyLeaveReasonChangeEvent extends ApplyLeaveEvent{
  final String reason;
  ApplyLeaveReasonChangeEvent({required this.reason});
  @override
  List<Object?> get props => [reason];
}

class ApplyLeaveUpdateLeaveOfTheDayEvent extends ApplyLeaveEvent{
  final DateTime date;
  final LeaveDayDuration value;
  ApplyLeaveUpdateLeaveOfTheDayEvent({required this.date,required this.value});
  @override
  List<Object?> get props => [date,value];
}

class ApplyLeaveSubmitFormEvent extends ApplyLeaveEvent{
  @override
  List<Object?> get props => [];
}


