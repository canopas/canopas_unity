import 'package:equatable/equatable.dart';
import 'package:table_calendar/table_calendar.dart';

abstract class WhoIsOutEvent extends Equatable {}

class WhoIsOutInitialLoadEvent extends WhoIsOutEvent {
  @override
  List<Object?> get props => [];
}

class ChangeCalendarFormat extends WhoIsOutEvent {
  final CalendarFormat calendarFormat;

  ChangeCalendarFormat(this.calendarFormat);

  @override
  List<Object?> get props => [calendarFormat];
}

class ChangeCalendarDate extends WhoIsOutEvent {
  final DateTime date;

  ChangeCalendarDate(this.date);

  @override
  List<Object?> get props => [date];
}

class FetchMoreLeaves extends WhoIsOutEvent {
  final DateTime date;

  FetchMoreLeaves(this.date);

  @override
  List<Object?> get props => [date];
}
