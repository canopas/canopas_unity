import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/extensions/calendar_format_extension.dart';
import 'package:table_calendar/table_calendar.dart';
import 'leave_calendar_event.dart';
import 'leave_calendar_state.dart';

@Injectable()
class LeaveCalendarBloc extends Bloc<LeaveCalendarEvent,LeaveCalendarState>{

  LeaveCalendarBloc() :super(const LeaveCalendarState()) {
    on<ChangeCalendarFormatBySwipeEvent>(_onCalendarFormatChangeBySwipe);
    on<ChangeCalendarFormatEvent>(_onCalendarFormatChange);
    on<DateRangeSelectedCalendarEvent>(_onDateRangeSelected);
  }

  void _onDateRangeSelected(DateRangeSelectedCalendarEvent event, Emitter<LeaveCalendarState> emit){
    emit(state.copyWith(selectedDate: event.selectedDate, startDate: event.startDate, endDate: event.endDate));
  }

  void _onCalendarFormatChange(ChangeCalendarFormatEvent event, Emitter<LeaveCalendarState> emit){
    emit(state.changeCalendarFormatOnly(calendarFormat: event.calendarFormat));
  }

  void _onCalendarFormatChangeBySwipe(ChangeCalendarFormatBySwipeEvent event, Emitter<LeaveCalendarState> emit){
    CalendarFormat calendarFormat = state.calendarFormat.changeCalendarFormatBySwipe(event.direction);
    emit(state.changeCalendarFormatOnly(calendarFormat: calendarFormat));
  }

}