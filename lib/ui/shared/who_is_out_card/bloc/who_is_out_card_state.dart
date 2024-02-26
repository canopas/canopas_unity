import 'package:equatable/equatable.dart';
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

// class WhoIsOutCardState extends Equatable {
//   final Status status;
//   final DateTime selectedDate;
//   final DateTime focusDay;
//   final CalendarFormat calendarFormat;
//   final List<LeaveApplication> allAbsences;
//   final List<LeaveApplication>? selectedDayAbsences;
//   final String? error;
//
//   const WhoIsOutCardState(
//       {this.calendarFormat = CalendarFormat.week,
//       required this.selectedDate,
//       required this.focusDay,
//       this.status = Status.initial,
//       this.allAbsences = const [],
//       this.selectedDayAbsences,
//       this.error});
//
//   WhoIsOutCardState copyWith(
//       {DateTime? selectedDate,
//       DateTime? focusDay,
//       Status? status,
//       CalendarFormat? calendarFormat,
//       String? error,
//       List<LeaveApplication>? allAbsences,
//       List<LeaveApplication>? selectedDayAbsences}) {
//     return WhoIsOutCardState(
//       selectedDayAbsences: selectedDayAbsences ?? this.selectedDayAbsences,
//       calendarFormat: calendarFormat ?? this.calendarFormat,
//       selectedDate: selectedDate ?? this.selectedDate,
//       status: status ?? this.status,
//       error: error,
//       allAbsences: allAbsences ?? this.allAbsences,
//       focusDay: focusDay ?? this.focusDay,
//     );
//   }
//
//   @override
//   List<Object?> get props => [
//         status,
//         selectedDate,
//         allAbsences,
//         error,
//         calendarFormat,
//         selectedDayAbsences,
//         focusDay
//       ];
// }
