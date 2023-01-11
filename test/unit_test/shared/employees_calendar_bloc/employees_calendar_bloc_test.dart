import 'package:flutter_test/flutter_test.dart';
import 'package:projectunity/ui/shared/employees_calendar/bloc/calendar_bloc/employees_calendar_bloc.dart';
import 'package:projectunity/ui/shared/employees_calendar/bloc/calendar_bloc/employees_calendar_event.dart';
import 'package:projectunity/ui/shared/employees_calendar/bloc/calendar_bloc/employees_calendar_state.dart';
import 'package:table_calendar/table_calendar.dart';
void main(){

  late EmployeesCalenderBloc whoIsOutCalendarBloc;

  setUpAll((){
    whoIsOutCalendarBloc = EmployeesCalenderBloc();
  });

  group("Who is Out calendar test", () {

    test("calendar format change test", () {
      DateTime date = DateTime.now();
      whoIsOutCalendarBloc.add(EmployeesCalendarSelectDateEvent(date));
      whoIsOutCalendarBloc.add(EmployeesCalendarFormatChangeEvent(CalendarFormat.twoWeeks));
      whoIsOutCalendarBloc.add(EmployeesCalendarFormatChangeEvent(CalendarFormat.month));
      emitsInOrder([
         WhoIsOutCalendarState(selectedDate: date),
         WhoIsOutCalendarState(calendarFormat: CalendarFormat.twoWeeks, selectedDate: date),
         WhoIsOutCalendarState(calendarFormat: CalendarFormat.month, selectedDate: date),
      ]);
    });

    test("calendar format change by swipe test", () {
      DateTime date = DateTime.now();
      whoIsOutCalendarBloc.add(EmployeesCalendarSelectDateEvent(date));
      whoIsOutCalendarBloc.add(EmployeesCalendarVerticalSwipeEvent(2));
      whoIsOutCalendarBloc.add(EmployeesCalendarVerticalSwipeEvent(1));
      emitsInOrder([
        WhoIsOutCalendarState(selectedDate: date),
        WhoIsOutCalendarState(calendarFormat: CalendarFormat.twoWeeks, selectedDate: date),
        WhoIsOutCalendarState(calendarFormat: CalendarFormat.month, selectedDate: date),
      ]);
    });

    test("date change test", () {
      DateTime date = DateTime.now();
      whoIsOutCalendarBloc.add(EmployeesCalendarSelectDateEvent(date));
      emits(WhoIsOutCalendarState(selectedDate: date));
    });

  });

}

