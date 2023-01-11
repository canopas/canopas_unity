import 'package:equatable/equatable.dart';

abstract class ApplyLeaveEvent extends Equatable {}

class ApplyLeaveInitialEvent extends ApplyLeaveEvent{
  @override
  List<Object?> get props => [];
}

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
  final int value;
  ApplyLeaveUpdateLeaveOfTheDayEvent({required this.date,required this.value});
  @override
  List<Object?> get props => [date,value];
}

class ApplyLeaveSubmitFormEvent extends ApplyLeaveEvent{
  @override
  List<Object?> get props => [];
}


