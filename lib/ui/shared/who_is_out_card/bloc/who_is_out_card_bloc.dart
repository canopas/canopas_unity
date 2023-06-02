import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/extensions/leave_extension.dart';
import '../../../../data/core/exception/error_const.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/model/employee/employee.dart';
import '../../../../data/model/leave/leave.dart';
import '../../../../data/model/leave_application.dart';
import '../../../../data/services/employee_service.dart';
import '../../../../data/services/leave_service.dart';
import 'who_is_out_card_event.dart';
import 'who_is_out_card_state.dart';

@Injectable()
class WhoIsOutCardBloc extends Bloc<WhoIsOutEvent, WhoIsOutCardState> {
  final EmployeeService _employeeService;
  final LeaveService _leaveService;

  WhoIsOutCardBloc(
    this._employeeService,
    this._leaveService,
  ) : super(WhoIsOutCardState(
            selectedDate: DateTime.now(), focusDay: DateTime.now())) {
    on<WhoIsOutInitialLoadEvent>(_load);
    on<ChangeCalendarDate>(_changeCalendarDate);
    on<ChangeCalendarFormat>(_changeCalendarFormat);
    on<FetchMoreLeaves>(_fetchMoreLeavesEvent);
  }

  List<Employee> _employees = [];
  final Set<String> _loadHistory = {};

  FutureOr<void> _load(
      WhoIsOutInitialLoadEvent event, Emitter<WhoIsOutCardState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      _employees = await _employeeService.getEmployees();
      final allAbsences = await fetchAbsences(state.selectedDate);
      emit(state.copyWith(
          status: Status.success,
          selectedDayAbsences: getPerDayAbsences(
              date: state.selectedDate, allAbsences: allAbsences),
          allAbsences: allAbsences));
    } on Exception {
      emit(
          state.copyWith(status: Status.error, error: firestoreFetchDataError));
    }
  }

  Future<void> _changeCalendarDate(
      ChangeCalendarDate event, Emitter<WhoIsOutCardState> emit) async {
    emit(state.copyWith(
        selectedDate: event.date,
        selectedDayAbsences: getPerDayAbsences(
            date: event.date, allAbsences: state.allAbsences)));
  }

  Future<void> _changeCalendarFormat(
      ChangeCalendarFormat event, Emitter<WhoIsOutCardState> emit) async {
    emit(state.copyWith(calendarFormat: event.calendarFormat));
  }

  Future<void> _fetchMoreLeavesEvent(
      FetchMoreLeaves event, Emitter<WhoIsOutCardState> emit) async {
    emit(state.copyWith(focusDay: event.date));
    final bool loadMore =
        !_loadHistory.contains("${event.date.month}-${event.date.year}");

    final allAbsences = state.allAbsences.toList();

    if (loadMore) {
      try {
        final fetchedAbsences = await fetchAbsences(event.date);
        allAbsences.addAll(fetchedAbsences);
        emit(state.copyWith(allAbsences: allAbsences, status: Status.success));
      } on Exception {
        emit(state.copyWith(
            status: Status.error, error: firestoreFetchDataError));
      }
    }
  }

  Future<List<LeaveApplication>> fetchAbsences(DateTime date) async {
    List<Leave> absenceLeaves = await _leaveService.getAllAbsence(date: date);
    List<LeaveApplication> absences =
        _getLeaveApplication(employees: _employees, leaves: absenceLeaves);
    _loadHistory.add("${date.month}-${date.year}");
    return absences;
  }

  List<LeaveApplication> getPerDayAbsences(
      {required DateTime date, required List<LeaveApplication> allAbsences}) {
    return allAbsences
        .where((la) =>
            la.leave.getDateAndDuration().containsKey(date.dateOnly) &&
            la.leave.getDateAndDuration()[date.dateOnly] !=
                LeaveDayDuration.noLeave)
        .toList();
  }

  List<LeaveApplication> _getLeaveApplication(
      {required List<Employee> employees, required List<Leave> leaves}) {
    return leaves
        .map((leave) {
          final employee =
              employees.firstWhereOrNull((emp) => emp.uid == leave.uid);
          return (employee == null)
              ? null
              : LeaveApplication(employee: employee, leave: leave);
        })
        .whereNotNull()
        .toList();
  }

  @override
  Future<void> close() {
    _employees.clear();
    _loadHistory.clear();
    return super.close();
  }
}
