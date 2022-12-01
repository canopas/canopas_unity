import 'package:flutter_test/flutter_test.dart';
import 'package:projectunity/ui/shared/user_leave_calendar/bloc/calendar_bloc/leave_calendar_bloc.dart';
import 'package:projectunity/ui/shared/user_leave_calendar/bloc/calendar_bloc/leave_calendar_event.dart';
import 'package:projectunity/ui/shared/user_leave_calendar/bloc/calendar_bloc/leave_calendar_state.dart';
import 'package:table_calendar/table_calendar.dart';

void main(){

  late LeaveCalendarBloc leaveCalendarBloc;

  setUpAll((){
    leaveCalendarBloc = LeaveCalendarBloc();
  });

  group(" leave Calendar Test", () {

    test("change calendar format test", () {
      leaveCalendarBloc.add(ChangeCalendarFormatEvent(CalendarFormat.twoWeeks));
      leaveCalendarBloc.add(ChangeCalendarFormatEvent(CalendarFormat.month));
      emitsInOrder([const LeaveCalendarState(calendarFormat: CalendarFormat.twoWeeks),
        const LeaveCalendarState(calendarFormat: CalendarFormat.month),
      ]);
    });

    test("change calendar format by swipe test", () {
      leaveCalendarBloc.add(ChangeCalendarFormatBySwipeEvent(2));
      leaveCalendarBloc.add(ChangeCalendarFormatBySwipeEvent(1));
      emitsInOrder([ const LeaveCalendarState(calendarFormat: CalendarFormat.twoWeeks),
        const LeaveCalendarState(calendarFormat: CalendarFormat.month),
      ]);
    });

    test("change date range test", () {
      DateTime date = DateTime.now();
      leaveCalendarBloc.add(DateRangeSelectedCalendarEvent(date, date.add(const Duration(days: 1)), date));
      emits(LeaveCalendarState(endDate: date,startDate: date,selectedDate: date,calendarFormat: CalendarFormat.month));
    });

  });

}

