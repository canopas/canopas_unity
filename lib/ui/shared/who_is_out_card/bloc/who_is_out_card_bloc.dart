import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/Repo/employee_repo.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/extensions/leave_extension.dart';
import 'package:projectunity/data/core/extensions/stream_extension.dart';
import '../../../../data/Repo/leave_repo.dart';
import '../../../../data/core/exception/error_const.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/model/leave/leave.dart';
import '../../../../data/model/leave_application.dart';
import 'who_is_out_card_event.dart';
import 'who_is_out_card_state.dart';

@Injectable()
class WhoIsOutCardBloc extends Bloc<WhoIsOutEvent, WhoIsOutCardState> {
  final LeaveRepo _leaveRepo;
  final EmployeeRepo _employeeRepo;
  late StreamSubscription<List<LeaveApplication>> _leaveApplicationSubscription;
  List<LeaveApplication> _leaveApplications = [];

  WhoIsOutCardBloc(
    this._leaveRepo,
    this._employeeRepo,
  ) : super(WhoIsOutCardState(
            selectedDate: DateTime.now().dateOnly,
            focusDay: DateTime.now().dateOnly)) {
    on<WhoIsOutInitialLoadEvent>(_load);
    on<ChangeCalendarDate>(_changeCalendarDate);
    on<ChangeCalendarFormat>(_changeCalendarFormat);
    on<FetchMoreLeaves>(_fetchMoreLeavesEvent);
    _leaveApplicationSubscription = getLeaveApplicationStream(
            leaveStream: _leaveRepo.leaves,
            membersStream: _employeeRepo.activeEmployees)
        .listen((leaveApplications) {
      _leaveApplications = leaveApplications;
      add(WhoIsOutInitialLoadEvent());
    });

  }

  final Set<String> _loadHistory = {};

  void _load(WhoIsOutInitialLoadEvent event, Emitter<WhoIsOutCardState> emit) {
    emit(state.copyWith(status: Status.loading));
    final selectedMonthApplications =
        monthWiseApplications(state.selectedDate, _leaveApplications);
    emit(state.copyWith(
        status: Status.success,
        selectedDayAbsences: getPerDayAbsences(
            date: state.selectedDate, allAbsences: selectedMonthApplications),
        allAbsences: selectedMonthApplications));
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

  void _fetchMoreLeavesEvent(
      FetchMoreLeaves event, Emitter<WhoIsOutCardState> emit) {
    emit(state.copyWith(focusDay: event.date));
    final bool loadMore =
        !_loadHistory.contains("${event.date.month}-${event.date.year}");
    final allAbsences = state.allAbsences.toList();
    if (loadMore) {
      try {
        final fetchedAbsences =
            monthWiseApplications(event.date, _leaveApplications);
        allAbsences.addAll(fetchedAbsences);
        emit(state.copyWith(allAbsences: allAbsences, status: Status.success));
      } on Exception {
        emit(state.copyWith(
            status: Status.error, error: firestoreFetchDataError));
      }
    }
  }

  List<LeaveApplication> monthWiseApplications(
      DateTime date, List<LeaveApplication> absenceLeaves) {
    _loadHistory.add("${date.month}-${date.year}");
    return absenceLeaves
        .where((leaveApplication) =>
            leaveApplication.leave.startDate.month == date.month &&
                leaveApplication.leave.startDate.year == date.year ||
            leaveApplication.leave.endDate.month == date.month &&
                leaveApplication.leave.endDate.year == date.year)
        .toList();
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

  @override
  Future<void> close() async {
    _leaveApplications.clear();
    _loadHistory.clear();
    await _leaveApplicationSubscription.cancel();
    return super.close();
  }
}
