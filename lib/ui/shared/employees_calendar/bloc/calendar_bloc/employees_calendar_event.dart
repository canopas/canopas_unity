import 'package:equatable/equatable.dart';
import 'package:table_calendar/table_calendar.dart';

abstract class EmployeesCalendarEvent extends Equatable{}

class EmployeesCalendarSelectDateEvent extends EmployeesCalendarEvent{
  final DateTime selectDate;
  EmployeesCalendarSelectDateEvent(this.selectDate);

  @override
  List<Object?> get props => [selectDate];
}

class EmployeesCalendarFormatChangeEvent extends EmployeesCalendarEvent{
  final CalendarFormat calendarFormat;
  EmployeesCalendarFormatChangeEvent(this.calendarFormat);

  @override
  List<Object?> get props => [calendarFormat];
}

class EmployeesCalendarVerticalSwipeEvent extends EmployeesCalendarEvent{
  final int direction;
  EmployeesCalendarVerticalSwipeEvent(this.direction);

  @override
  List<Object?> get props => [direction];
}
