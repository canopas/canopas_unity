import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/extensions/leave_extension.dart';
import 'package:projectunity/data/core/extensions/stream_extension.dart';
import '../../../../data/repo/employee_repo.dart';
import '../../../../data/repo/leave_repo.dart';
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
  StreamSubscription? _subscription;

  WhoIsOutCardBloc(
    this._employeeRepo,
    this._leaveRepo,
  ) : super(WhoIsOutCardState(
            selectedDate: DateTime.now().dateOnly,
            focusDay: DateTime.now().dateOnly)) {
    on<FetchWhoIsOutCardLeaves>(_fetchWhoIsOutCardLeaves);
    on<ChangeCalendarDate>(_changeCalendarDate);
    on<ChangeCalendarFormat>(_changeCalendarFormat);
    on<ShowCalendarData>(_showCalendarData);
    on<ShowCalendarError>(_showCalendarError);
  }

  FutureOr<void> _fetchWhoIsOutCardLeaves(
      FetchWhoIsOutCardLeaves event, Emitter<WhoIsOutCardState> emit) async {
    emit(state.copyWith(
        status:
            state.selectedDayAbsences == null ? Status.loading : state.status,
        focusDay: event.focusDay ?? state.focusDay));
    try {
      if (_subscription != null) {
        await _subscription?.cancel();
      }
      _subscription = getLeaveApplicationStream(
              leaveStream:
                  _leaveRepo.leaveByMonth(event.focusDay ?? state.focusDay),
              membersStream: _employeeRepo.employees)
          .listen((List<LeaveApplication> leaveApplications) {
        add(ShowCalendarData(leaveApplications));
      }, onError: (error, _) {
        add(ShowCalendarError());
      });
    } on Exception {
      add(ShowCalendarError());
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

  void _showCalendarData(
      ShowCalendarData event, Emitter<WhoIsOutCardState> emit) async {
    emit(state.copyWith(
        status: Status.success,
        allAbsences: event.allAbsence,
        selectedDayAbsences: state.selectedDayAbsences ??
            getSelectedDateAbsences(
                date: state.selectedDate, allAbsences: event.allAbsence)));
  }

  void _showCalendarError(
      ShowCalendarError event, Emitter<WhoIsOutCardState> emit) async {
    emit(state.copyWith(status: Status.error, error: firestoreFetchDataError));
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

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
