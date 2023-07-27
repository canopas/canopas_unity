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
  final EmployeeRepo _employeeRepo;
  final LeaveRepo _leaveRepo;

  WhoIsOutCardBloc(
    this._employeeRepo,
    this._leaveRepo,
  ) : super(WhoIsOutCardState(
            selectedDate: DateTime.now().dateOnly,
            focusDay: DateTime.now().dateOnly)) {
    on<WhoIsOutInitialLoadEvent>(initialLoad);
    on<ChangeCalendarDate>(_changeCalendarDate);
    on<ChangeCalendarFormat>(_changeCalendarFormat);
    on<FetchMoreLeaves>(_fetchMoreLeavesEvent);
  }

  FutureOr<void> initialLoad(
      WhoIsOutInitialLoadEvent event, Emitter<WhoIsOutCardState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      return emit.forEach(
        getLeaveApplicationStream(
            leaveStream: _leaveRepo.leaveByMonth(state.focusDay),
            membersStream: _employeeRepo.employees),
        onData: (List<LeaveApplication> leaveApplications) => state.copyWith(
            allAbsences: leaveApplications,
            status: Status.success,
            selectedDayAbsences: getSelectedDateAbsences(
                date: state.selectedDate, allAbsences: leaveApplications)),
        onError: (error, stackTrace) => state.copyWith(
            status: Status.error, error: firestoreFetchDataError),
      );
    } on Exception {
      emit(
          state.copyWith(status: Status.error, error: firestoreFetchDataError));
    }
  }

  FutureOr<void> _fetchMoreLeavesEvent(
      FetchMoreLeaves event, Emitter<WhoIsOutCardState> emit) async {
    try {
      return emit.forEach(
        getLeaveApplicationStream(
            leaveStream: _leaveRepo.leaveByMonth(event.date),
            membersStream: _employeeRepo.employees),
        onData: (List<LeaveApplication> leaveApplications) => state.copyWith(
            allAbsences: leaveApplications, focusDay: event.date),
        onError: (error, stackTrace) => state.copyWith(
            status: Status.error,
            error: firestoreFetchDataError,
            focusDay: event.date),
      );
    } on Exception {
      emit(state.copyWith(
          status: Status.error,
          error: firestoreFetchDataError,
          focusDay: event.date));
    }
  }

  Future<void> _changeCalendarDate(
      ChangeCalendarDate event, Emitter<WhoIsOutCardState> emit) async {
    emit(state.copyWith(
        selectedDate: event.date,
        selectedDayAbsences: getSelectedDateAbsences(
            date: event.date, allAbsences: state.allAbsences)));
  }

  Future<void> _changeCalendarFormat(
      ChangeCalendarFormat event, Emitter<WhoIsOutCardState> emit) async {
    emit(state.copyWith(calendarFormat: event.calendarFormat));
  }

  List<LeaveApplication> getSelectedDateAbsences(
      {required DateTime date, required List<LeaveApplication> allAbsences}) {
    return allAbsences
        .where((la) =>
            la.leave.getDateAndDuration().containsKey(date.dateOnly) &&
            la.leave.getDateAndDuration()[date.dateOnly] !=
                LeaveDayDuration.noLeave)
        .toList();
  }
}
