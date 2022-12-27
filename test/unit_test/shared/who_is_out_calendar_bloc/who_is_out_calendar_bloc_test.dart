import 'package:flutter_test/flutter_test.dart';
import 'package:projectunity/ui/shared/who_is_out_calendar/bloc/who_is_out_calendar_bloc/who_is_out_calendar_bloc.dart';
import 'package:projectunity/ui/shared/who_is_out_calendar/bloc/who_is_out_calendar_bloc/who_is_out_calendar_state.dart';
import 'package:projectunity/ui/shared/who_is_out_calendar/bloc/who_is_out_calendar_bloc/who_is_out_calendar_event.dart';
import 'package:table_calendar/table_calendar.dart';
void main(){

  late EmployeesCalenderBloc whoIsOutCalendarBloc;

  setUpAll((){
    whoIsOutCalendarBloc = EmployeesCalenderBloc();
  });

  group("Who is Out calendar test", () {

    test("calendar format change test", () {
      DateTime date = DateTime.now();
      whoIsOutCalendarBloc.add(WhoIsOutCalendarSelectDateEvent(date));
      whoIsOutCalendarBloc.add(WhoIsOutCalendarFormatChangeEvent(CalendarFormat.twoWeeks));
      whoIsOutCalendarBloc.add(WhoIsOutCalendarFormatChangeEvent(CalendarFormat.month));
      emitsInOrder([
         WhoIsOutCalendarState(selectedDate: date),
         WhoIsOutCalendarState(calendarFormat: CalendarFormat.twoWeeks, selectedDate: date),
         WhoIsOutCalendarState(calendarFormat: CalendarFormat.month, selectedDate: date),
      ]);
    });

    test("calendar format change by swipe test", () {
      DateTime date = DateTime.now();
      whoIsOutCalendarBloc.add(WhoIsOutCalendarSelectDateEvent(date));
      whoIsOutCalendarBloc.add(WhoIsOutCalendarFormatChangeBySwipeEvent(2));
      whoIsOutCalendarBloc.add(WhoIsOutCalendarFormatChangeBySwipeEvent(1));
      emitsInOrder([
        WhoIsOutCalendarState(selectedDate: date),
        WhoIsOutCalendarState(calendarFormat: CalendarFormat.twoWeeks, selectedDate: date),
        WhoIsOutCalendarState(calendarFormat: CalendarFormat.month, selectedDate: date),
      ]);
    });

    test("date change test", () {
      DateTime date = DateTime.now();
      whoIsOutCalendarBloc.add(WhoIsOutCalendarSelectDateEvent(date));
      emits(WhoIsOutCalendarState(selectedDate: date));
    });

  });

}

