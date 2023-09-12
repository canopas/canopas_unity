import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/extensions/leave_extension.dart';
import 'package:projectunity/data/core/extensions/map_extension.dart';
import 'package:projectunity/data/core/functions/shared_function.dart';
import 'package:projectunity/data/core/mixin/input_validation.dart';
import 'package:projectunity/data/repo/leave_repo.dart';
import 'package:projectunity/data/services/mail_notification_service.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/model/leave/leave.dart';
import '../../../../../data/provider/user_state.dart';
import 'apply_leave_event.dart';
import 'apply_leave_state.dart';

@Injectable()
class ApplyLeaveBloc extends Bloc<ApplyLeaveEvent, ApplyLeaveState>
    with InputValidationMixin {
  final NotificationService _notificationService;
  final LeaveRepo _leaveRepo;
  final AppFunctions _appFunctions;
  final UserStateNotifier _userStateNotifier;

  ApplyLeaveBloc(this._userStateNotifier, this._leaveRepo,
      this._notificationService, this._appFunctions)
      : super(ApplyLeaveState(
          startDate: DateTime.now().dateOnly,
          endDate: DateTime.now().dateOnly,
          selectedDates: <DateTime, LeaveDayDuration>{}
              .getSelectedLeaveOfTheDays(
                  startDate: DateTime.now().dateOnly,
                  endDate: DateTime.now().dateOnly),
          totalLeaveDays: <DateTime, LeaveDayDuration>{}
              .getSelectedLeaveOfTheDays(
                  startDate: DateTime.now().dateOnly,
                  endDate: DateTime.now().dateOnly)
              .getTotalLeaveCount(),
        )) {
    on<ApplyLeaveStartDateChangeEvents>(_updateStartLeaveDate);
    on<ApplyLeaveEndDateChangeEvent>(_updateEndLeaveDate);
    on<ApplyLeaveReasonChangeEvent>(_updateReason);
    on<ApplyLeaveUpdateLeaveOfTheDayEvent>(_updateLeaveOfTheDay);
    on<ApplyLeaveSubmitFormEvent>(_applyLeave);
    on<ApplyLeaveChangeLeaveTypeEvent>(_updateLeaveType);
  }

  void _updateStartLeaveDate(
      ApplyLeaveStartDateChangeEvents event, Emitter<ApplyLeaveState> emit) {
    final Map<DateTime, LeaveDayDuration> updatedSelectedLeaves = {};
    updatedSelectedLeaves.addAll(state.selectedDates);
    updatedSelectedLeaves.getSelectedLeaveOfTheDays(
        startDate: event.startDate ?? state.startDate, endDate: state.endDate);
    emit(state.copyWith(
        startDate: event.startDate,
        selectedDates: updatedSelectedLeaves,
        totalLeaveDays: updatedSelectedLeaves.getTotalLeaveCount()));
  }

  void _updateLeaveType(
      ApplyLeaveChangeLeaveTypeEvent event, Emitter<ApplyLeaveState> emit) {
    emit(state.copyWith(leaveType: event.leaveType));
  }

  void _updateEndLeaveDate(
      ApplyLeaveEndDateChangeEvent event, Emitter<ApplyLeaveState> emit) {
    final Map<DateTime, LeaveDayDuration> updatedSelectedLeaves = {};
    updatedSelectedLeaves.addAll(state.selectedDates);
    updatedSelectedLeaves.getSelectedLeaveOfTheDays(
        startDate: state.startDate, endDate: event.endDate ?? state.endDate);
    emit(state.copyWith(
        endDate: event.endDate,
        selectedDates: updatedSelectedLeaves,
        totalLeaveDays: updatedSelectedLeaves.getTotalLeaveCount()));
  }

  void _updateLeaveOfTheDay(
      ApplyLeaveUpdateLeaveOfTheDayEvent event, Emitter<ApplyLeaveState> emit) {
    final Map<DateTime, LeaveDayDuration> leaveOfTheDays = {};
    leaveOfTheDays.addAll(state.selectedDates);
    leaveOfTheDays.update(event.date, (value) => event.value,
        ifAbsent: () => event.date.getLeaveDayDuration());
    emit(state.copyWith(
        selectedDates: leaveOfTheDays,
        totalLeaveDays: leaveOfTheDays.getTotalLeaveCount()));
  }

  void _updateReason(
      ApplyLeaveReasonChangeEvent event, Emitter<ApplyLeaveState> emit) {
    if (validInputLength(event.reason)) {
      emit(state.copyWith(reason: event.reason, showTextFieldError: false));
    } else {
      emit(state.copyWith(reason: event.reason, showTextFieldError: true));
    }
  }

  Future<void> _applyLeave(
      ApplyLeaveSubmitFormEvent event, Emitter<ApplyLeaveState> emit) async {
    emit(state.copyWith(leaveRequestStatus: Status.loading));
    if (!validInputLength(state.reason)) {
      emit(state.copyWith(
          error: fillDetailsError,
          showTextFieldError: true,
          leaveRequestStatus: Status.error));
    } else if (state.totalLeaveDays == 0) {
      emit(state.copyWith(
          error: applyMinimumHalfDay, leaveRequestStatus: Status.error));
    } else if (state.endDate.difference(state.startDate).inDays.isNegative) {
      emit(state.copyWith(
          error: invalidLeaveDateError, leaveRequestStatus: Status.error));
    } else {
      try {
        final leaveData = _getLeaveData();
        final leaveAlreadyExist = await _leaveRepo.checkLeaveAlreadyApplied(
            uid: _userStateNotifier.userUID!,
            dateDuration: leaveData.getDateAndDuration());
        if (leaveAlreadyExist) {
          emit(state.copyWith(
              error: alreadyLeaveAppliedError,
              leaveRequestStatus: Status.error));
        } else {
          await _leaveRepo.applyForLeave(leave: leaveData);
          final notificationEmail =
              _userStateNotifier.currentSpace!.notificationEmail;
          if (notificationEmail != null) {
            await _notificationService.notifyHRForNewLeave(
              name: _userStateNotifier.employee.name,
              startDate: leaveData.startDate,
              endDate: leaveData.endDate,
              reason: leaveData.reason,
              receiver: notificationEmail,
              duration: _appFunctions.getNotificationDuration(
                  total: leaveData.total,
                  firstLeaveDayDuration: leaveData.perDayDuration.first),
            );
          }
          emit(state.copyWith(
              leaveRequestStatus: Status.success, leaveId: leaveData.leaveId));
        }
      } on Exception {
        emit(state.copyWith(
            error: firestoreFetchDataError, leaveRequestStatus: Status.error));
      }
    }
  }

  Leave _getLeaveData() {
    final entries = state.selectedDates.entries
        .where((day) => day.value != LeaveDayDuration.noLeave);

    final DateTime firstDate = entries.first.key;
    final DateTime lastDate = entries.last.key;

    final Map<DateTime, LeaveDayDuration> selectedDates = state.selectedDates
      ..removeWhere(
          (key, value) => key.isBefore(firstDate) || key.isAfter(lastDate));

    final DateTime appliedOn = DateTime.now();

    final bool isUrgentLeave = _appFunctions.isUrgentLeave(
        startDate: firstDate,
        appliedOn: appliedOn,
        totalLeaves: state.totalLeaveDays);

    return Leave(
      leaveId: _leaveRepo.generateLeaveId,
      uid: _userStateNotifier.employeeId,
      type: isUrgentLeave ? LeaveType.urgentLeave : state.leaveType,
      startDate: firstDate,
      endDate: lastDate,
      total: state.totalLeaveDays,
      reason: state.reason,
      status: LeaveStatus.pending,
      appliedOn: appliedOn,
      perDayDuration: selectedDates.values.toList(),
    );
  }
}
