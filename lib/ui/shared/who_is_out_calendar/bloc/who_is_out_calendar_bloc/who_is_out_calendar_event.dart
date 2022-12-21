import 'package:equatable/equatable.dart';
import 'package:table_calendar/table_calendar.dart';

abstract class WhoIsOutCalendarEvent extends Equatable{}

class WhoIsOutCalendarSelectDateEvent extends WhoIsOutCalendarEvent{
  final DateTime selectDate;
  WhoIsOutCalendarSelectDateEvent(this.selectDate);

  @override
  List<Object?> get props => [selectDate];
}

class WhoIsOutCalendarFormatChangeEvent extends WhoIsOutCalendarEvent{
  final CalendarFormat calendarFormat;
  WhoIsOutCalendarFormatChangeEvent(this.calendarFormat);

  @override
  List<Object?> get props => [calendarFormat];
}

class WhoIsOutCalendarFormatChangeBySwipeEvent extends WhoIsOutCalendarEvent{
  final int direction;
  WhoIsOutCalendarFormatChangeBySwipeEvent(this.direction);

  @override
  List<Object?> get props => [direction];
}
