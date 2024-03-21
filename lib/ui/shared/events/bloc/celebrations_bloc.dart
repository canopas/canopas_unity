import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/ui/shared/events/bloc/celebrations_state.dart';

import '../../../../data/core/utils/bloc_status.dart';
import '../model/event.dart';
import 'celebrations_event.dart';

@Injectable()
class CelebrationsBloc extends Bloc<CelebrationEvent, CelebrationsState> {
  final EmployeeService _employeeService;
  List<Employee> employees = [];
  List<Event> allBirthdayEvents = [];
  List<Event> allAnniversaryEvents = [];
  List<Event> currentWeekBday = [];
  List<Event> currentWeekAnniversaries = [];

  CelebrationsBloc(this._employeeService) : super(const CelebrationsState()) {
    on<FetchCelebrations>(_fetchEvent);
    on<ShowBirthdaysEvent>(_showAllBirthdays);
    on<ShowAnniversariesEvent>(_showAllAnniversaries);
  }

  Future<void> _fetchEvent(
      FetchCelebrations event, Emitter<CelebrationsState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final List<Employee> allEmployees = await _employeeService.getEmployees();
      employees = allEmployees.map((e) {
        if (e.dateOfBirth != null) {
          final birthdate = e.dateOfBirth!.convertToUpcomingDay();
          final Event event = Event(
              name: e.name,
              dateTime: DateUtils.dateOnly(e.dateOfBirth!),
              upcomingDate: DateUtils.dateOnly(birthdate),
              imageUrl: e.imageUrl);
          allBirthdayEvents.add(event);
        }
        if (e.role != Role.admin) {
          final upcomingDate = e.dateOfJoining.convertToUpcomingDay();
          final Event event = Event(
              name: e.name,
              dateTime: DateUtils.dateOnly(e.dateOfJoining),
              upcomingDate: DateUtils.dateOnly(upcomingDate),
              imageUrl: e.imageUrl);
          allAnniversaryEvents.add(event);
        }
        return e;
      }).toList();
      allBirthdayEvents
          .sort((a, b) => a.upcomingDate.compareTo(b.upcomingDate));
      allAnniversaryEvents
          .sort((a, b) => a.upcomingDate.compareTo(b.upcomingDate));

      currentWeekBday = _getBirthdays();
      currentWeekAnniversaries = _getAnniversaries();
      emit(state.copyWith(
          status: Status.success,
          birthdays: currentWeekBday,
          anniversaries: currentWeekAnniversaries));
    } on Exception {
      emit(
          state.copyWith(status: Status.error, error: firestoreFetchDataError));
    }
  }

  void _showAllBirthdays(
      ShowBirthdaysEvent event, Emitter<CelebrationsState> emit) {
    bool showAllBirthdays = !state.showAllBdays;
    if (showAllBirthdays) {
      emit(state.copyWith(
          showAllBdays: showAllBirthdays, birthdays: allBirthdayEvents));
    } else {
      emit(state.copyWith(
          showAllBdays: showAllBirthdays, birthdays: currentWeekBday));
    }
  }

  void _showAllAnniversaries(
      ShowAnniversariesEvent event, Emitter<CelebrationsState> emit) {
    bool allAnniversaries = !state.showAllAnniversaries;
    if (allAnniversaries) {
      emit(state.copyWith(
          showAllAnniversaries: allAnniversaries,
          anniversaries: allAnniversaryEvents));
    } else {
      emit(state.copyWith(
          showAllAnniversaries: allAnniversaries,
          anniversaries: currentWeekAnniversaries));
    }
  }

  List<Event> _getBirthdays() {
    final List<Event> birthdays = allBirthdayEvents.where((event) {
      return event.dateTime
          .isDateInCurrentWeek(DateUtils.dateOnly(DateTime.now()));
    }).toList();
    return birthdays;
  }

  List<Event> _getAnniversaries() {
    final List<Event> anniversaries = allAnniversaryEvents.where((event) {
      return event.dateTime
          .isDateInCurrentWeek(DateUtils.dateOnly(DateTime.now()));
    }).toList();
    return anniversaries;
  }
}
