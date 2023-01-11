import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/extensions/calendar_format_extension.dart';
import 'package:table_calendar/table_calendar.dart';

import 'employees_calendar_event.dart';
import 'employees_calendar_state.dart';


@Injectable()
class EmployeesCalenderBloc extends Bloc<EmployeesCalendarEvent, WhoIsOutCalendarState> {

  EmployeesCalenderBloc() :
        super(WhoIsOutCalendarState(selectedDate: DateTime.now())) {
    on<EmployeesCalendarSelectDateEvent>(_onSelectDate);
    on<EmployeesCalendarFormatChangeEvent>(_onFormatChange);
    on<EmployeesCalendarVerticalSwipeEvent>(_onFormatChangeBySwipe);
  }

  Future<void>_onSelectDate(EmployeesCalendarSelectDateEvent event,
      Emitter<WhoIsOutCalendarState> emit) async {
    emit( WhoIsOutCalendarState(selectedDate: event.selectDate));
  }

Future<void>  _onFormatChange(EmployeesCalendarFormatChangeEvent event,
      Emitter<WhoIsOutCalendarState> emit) async {
    emit( WhoIsOutCalendarState(selectedDate: state.selectedDate,calendarFormat: event.calendarFormat));
  }

 Future<void> _onFormatChangeBySwipe(EmployeesCalendarVerticalSwipeEvent event,
      Emitter<WhoIsOutCalendarState> emit) async {
    CalendarFormat calendarFormat = state.calendarFormat.changeCalendarFormatBySwipe(event.direction);
    emit(WhoIsOutCalendarState(selectedDate: state.selectedDate,calendarFormat: calendarFormat));
  }

}

