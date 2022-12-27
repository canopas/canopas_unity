import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/extensions/calendar_format_extension.dart';
import 'package:projectunity/ui/shared/who_is_out_calendar/bloc/who_is_out_calendar_bloc/who_is_out_calendar_event.dart';
import 'package:projectunity/ui/shared/who_is_out_calendar/bloc/who_is_out_calendar_bloc/who_is_out_calendar_state.dart';
import 'package:table_calendar/table_calendar.dart';


@Injectable()
class EmployeesCalenderBloc extends Bloc<WhoIsOutCalendarEvent, WhoIsOutCalendarState> {

  EmployeesCalenderBloc() :
        super(WhoIsOutCalendarState(selectedDate: DateTime.now())) {
    on<WhoIsOutCalendarSelectDateEvent>(_onSelectDate);
    on<WhoIsOutCalendarFormatChangeEvent>(_onFormatChange);
    on<WhoIsOutCalendarFormatChangeBySwipeEvent>(_onFormatChangeBySwipe);
  }

  _onSelectDate(WhoIsOutCalendarSelectDateEvent event,
      Emitter<WhoIsOutCalendarState> emit) async {
    emit( WhoIsOutCalendarState(selectedDate: event.selectDate));
  }

  _onFormatChange(WhoIsOutCalendarFormatChangeEvent event,
      Emitter<WhoIsOutCalendarState> emit) async {
    emit( WhoIsOutCalendarState(selectedDate: state.selectedDate,calendarFormat: event.calendarFormat));
  }

  _onFormatChangeBySwipe(WhoIsOutCalendarFormatChangeBySwipeEvent event,
      Emitter<WhoIsOutCalendarState> emit) async {
    CalendarFormat calendarFormat = state.calendarFormat.findNextCalendarFormatBySwipeDirection(event.direction);
    emit(WhoIsOutCalendarState(selectedDate: state.selectedDate,calendarFormat: calendarFormat));
  }

}

