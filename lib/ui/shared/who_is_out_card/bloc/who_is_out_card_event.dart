import 'package:equatable/equatable.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../data/model/leave_application.dart';

abstract class WhoIsOutEvent extends Equatable {}

class FetchWhoIsOutCardLeaves extends WhoIsOutEvent {
  final DateTime? focusDay;

  FetchWhoIsOutCardLeaves({this.focusDay});

  @override
  List<Object?> get props => [focusDay];
}

class ShowCalendarData extends WhoIsOutEvent {
  final List<LeaveApplication> allAbsence;

  ShowCalendarData(this.allAbsence);

  @override
  List<Object?> get props => [allAbsence];
}

class ShowCalendarError extends WhoIsOutEvent {
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
