import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../data/model/leave_application.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'who_is_out_card_state.freezed.dart';

@freezed
class WhoIsOutCardState with _$WhoIsOutCardState {
  const factory WhoIsOutCardState(
      {@Default(Status.initial) Status status,
      required DateTime selectedDate,
      required DateTime focusDay,
      @Default(CalendarFormat.week) CalendarFormat calendarFormat,
      @Default([]) List<LeaveApplication> allAbsences,
      List<LeaveApplication>? selectedDayAbsences,
      String? error}) = _WhoIsOutCardState;
}
