import 'package:equatable/equatable.dart';
import 'package:table_calendar/table_calendar.dart';

class WhoIsOutCalendarState extends Equatable {
  final CalendarFormat calendarFormat;
  final DateTime selectedDate;

  const WhoIsOutCalendarState({
    required this.selectedDate,
    this.calendarFormat = CalendarFormat.month,
  });

  @override
  List<Object?> get props => [calendarFormat,selectedDate];
}