import 'package:equatable/equatable.dart';
import 'package:table_calendar/table_calendar.dart';

abstract class LeaveCalendarEvent extends Equatable{
  @override
  List<Object?> get props => throw [];
}

class ChangeCalendarFormatEvent extends LeaveCalendarEvent {
  final CalendarFormat calendarFormat;
  ChangeCalendarFormatEvent(this.calendarFormat);

  @override
  List<Object?> get props => throw [calendarFormat];
}

class ChangeCalendarFormatBySwipeEvent extends LeaveCalendarEvent {
  final int direction;
  ChangeCalendarFormatBySwipeEvent(this.direction);

  @override
  List<Object?> get props => throw [direction];
}

class DateRangeSelectedCalendarEvent extends LeaveCalendarEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? selectedDate;

  DateRangeSelectedCalendarEvent(this.startDate,this.endDate,this.selectedDate);

  @override
  List<Object?> get props => throw [startDate,endDate,selectedDate];
}