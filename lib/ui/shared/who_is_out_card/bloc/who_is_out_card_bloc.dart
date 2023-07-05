import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/extensions/leave_extension.dart';
import 'package:projectunity/data/core/extensions/stream_extension.dart';
import '../../../../data/Repo/employee_repo.dart';
import '../../../../data/Repo/leave_repo.dart';
import '../../../../data/core/exception/error_const.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../../data/model/leave/leave.dart';
import '../../../../data/model/leave_application.dart';
import 'who_is_out_card_event.dart';
import 'who_is_out_card_state.dart';

@Injectable()
class WhoIsOutCardBloc extends Bloc<WhoIsOutEvent, WhoIsOutCardState> {
  final EmployeeRepo employeeRepo;
  final LeaveRepo leaveRepo;

  WhoIsOutCardBloc(this.employeeRepo, this.leaveRepo)
      : super(WhoIsOutCardState(
            selectedDate: DateTime.now().dateOnly,
            focusDay: DateTime.now().dateOnly)) {
    on<WhoIsOutInitialLoadEvent>(_load);
    on<ChangeCalendarDate>(_changeCalendarDate);
    on<ChangeCalendarFormat>(_changeCalendarFormat);
    on<FetchMoreLeaves>(_fetchMoreLeavesEvent);
  }

  final Set<String> _loadHistory = {};

  FutureOr<void> _load(
      WhoIsOutInitialLoadEvent event, Emitter<WhoIsOutCardState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      return emit.forEach(leaveApplications(state.selectedDate),
          onData: (List<LeaveApplication> allAbsences) => state.copyWith(
              status: Status.success,
              selectedDayAbsences: getPerDayAbsences(
                  date: state.selectedDate, allAbsences: allAbsences),
              allAbsences: allAbsences),
          onError: (e,_) => state.copyWith(
              status: Status.error, error: firestoreFetchDataError));
    } on Exception {
      emit(state.copyWith(status: Status.error, error: firestoreFetchDataError));
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
        final fetchedAbsences = await leaveApplications(event.date).last;
        allAbsences.addAll(fetchedAbsences);
        emit(state.copyWith(allAbsences: allAbsences, status: Status.success));
      } on Exception {
        emit(state.copyWith(
            status: Status.error, error: firestoreFetchDataError));
      }
    }
  }

  Stream<List<LeaveApplication>> leaveApplications(DateTime selectedDate) {
    final stream = getLeaveApplicationStream(
        leaveStream: leaveRepo.absence(selectedDate),
        membersStream: employeeRepo.employees);
    _loadHistory.add("${selectedDate.month}-${selectedDate.year}");
    return stream;
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
    super.close();
    _loadHistory.clear();
  }
}
