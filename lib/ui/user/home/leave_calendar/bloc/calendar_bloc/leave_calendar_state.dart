import 'package:equatable/equatable.dart';
import 'package:table_calendar/table_calendar.dart';

class LeaveCalendarState extends Equatable {
  final CalendarFormat calendarFormat;
  final DateTime? selectedDate;
  final DateTime? startDate;
  final DateTime? endDate;

  const LeaveCalendarState({
    this.calendarFormat = CalendarFormat.month,
    this.selectedDate,
    this.startDate,
    this.endDate,
  });

  copyWith({
    CalendarFormat? calendarFormat,
    required DateTime? selectedDate,
    required DateTime? startDate,
    required DateTime? endDate,
  }) {
    return LeaveCalendarState(
        calendarFormat: calendarFormat ?? this.calendarFormat,
        selectedDate: selectedDate,
        startDate: startDate,
        endDate: endDate);
  }

  changeCalendarFormatOnly({required CalendarFormat calendarFormat}) {
    return LeaveCalendarState(
        calendarFormat: calendarFormat,
        selectedDate: selectedDate,
        startDate: startDate,
        endDate: endDate);
  }

  @override
  List<Object?> get props => [calendarFormat, selectedDate, startDate, endDate];
}
