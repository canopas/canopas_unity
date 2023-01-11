import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/extensions/map_extension.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:uuid/uuid.dart';
import '../../../../../../core/utils/const/leave_time_constants.dart';
import '../../../../../../model/leave/leave.dart';
import '../../../../../../model/leave_count.dart';
import '../../../../../../provider/user_data.dart';
import '../../../../../../services/admin/paid_leave_service.dart';
import '../../../../../../services/user/user_leave_service.dart';
import 'apply_leave_event.dart';
import 'apply_leave_state.dart';

@Injectable()
class ApplyLeaveBloc extends Bloc<ApplyLeaveEvent, ApplyLeaveState> {

  final PaidLeaveService _paidLeaveService;
  final UserLeaveService _userLeaveService;
  final UserManager _userManager;

  ApplyLeaveBloc(this._userManager, this._paidLeaveService, this._userLeaveService)
      : super(ApplyLeaveState(
      startDate: DateTime.now().dateOnly,
      endDate: DateTime.now().dateOnly,
      selectedDates: <DateTime,int>{}.getSelectedLeaveOfTheDays(startDate: DateTime.now().dateOnly,endDate: DateTime.now().dateOnly),
      totalLeaveDays: <DateTime,int>{}.getSelectedLeaveOfTheDays(startDate: DateTime.now().dateOnly,endDate: DateTime.now().dateOnly).getTotalLeaveCount(),
  )) {
    on<ApplyLeaveInitialEvent>(_fetchLeaveCount);
    on<ApplyLeaveStartDateChangeEvents>(_updateStartLeaveDate);
    on<ApplyLeaveEndDateChangeEvent>(_updateEndLeaveDate);
    on<ApplyLeaveReasonChangeEvent>(_updateReason);
    on<ApplyLeaveUpdateLeaveOfTheDayEvent>(_updateLeaveOfTheDay);
    on<ApplyLeaveSubmitFormEvent>(_applyLeave);
    on<ApplyLeaveChangeLeaveTypeEvent>(_updateLeaveType);

  }

  Future<void> _fetchLeaveCount(ApplyLeaveInitialEvent event, Emitter<ApplyLeaveState> emit) async {
    emit(state.copyWith(leaveCountStatus: LeaveCountStatus.loading));
    try {
      double usedLeaveCount = await _userLeaveService.getUserUsedLeaveCount(_userManager.employeeId);
      int paidLeaveCount = await _paidLeaveService.getPaidLeaves();
      double remainingLeaveCount = paidLeaveCount - usedLeaveCount;
      LeaveCounts leaveCounts = LeaveCounts(
          remainingLeaveCount: remainingLeaveCount < 0
              ? 0
              : remainingLeaveCount,
          paidLeaveCount: paidLeaveCount,
          usedLeaveCount: usedLeaveCount);
      emit(state.copyWith(leaveCountStatus: LeaveCountStatus.success,leaveCounts: leaveCounts));
    } on Exception {
      emit(state.copyWith(leaveCountStatus: LeaveCountStatus.failure,error: firestoreFetchDataError));
    }
  }

  void _updateStartLeaveDate(ApplyLeaveStartDateChangeEvents event, Emitter<ApplyLeaveState> emit) {
    Map<DateTime, int> updatedSelectedLeaves = state.selectedDates.getSelectedLeaveOfTheDays(startDate: event.startDate ?? state.startDate, endDate: state.endDate);
    emit(state.copyWith(
        startDate: event.startDate,
        selectedDates: updatedSelectedLeaves,
        totalLeaveDays: updatedSelectedLeaves.getTotalLeaveCount()));
  }

  void _updateLeaveType(ApplyLeaveChangeLeaveTypeEvent event, Emitter<ApplyLeaveState> emit) {
   emit(state.copyWith(leaveType: event.leaveType));
  }

  void _updateEndLeaveDate(ApplyLeaveEndDateChangeEvent event, Emitter<ApplyLeaveState> emit) {
    Map<DateTime, int> updatedSelectedLeaves = state.selectedDates.getSelectedLeaveOfTheDays(startDate: state.startDate, endDate: event.endDate ?? state.endDate);
    emit(state.copyWith(
        endDate: event.endDate,
        selectedDates: updatedSelectedLeaves,
        totalLeaveDays: updatedSelectedLeaves.getTotalLeaveCount()));
  }

  void _updateLeaveOfTheDay(ApplyLeaveUpdateLeaveOfTheDayEvent event, Emitter<ApplyLeaveState> emit) {
    Map<DateTime, int> leaveOfTheDays = state.selectedDates;
    leaveOfTheDays.update(event.date, (value) => event.value, ifAbsent: () => event.date.isWeekend ? noLeave : fullLeave);
    emit(state.copyWith(
        selectedDates: leaveOfTheDays,
        totalLeaveDays: leaveOfTheDays.getTotalLeaveCount()));
  }

  void _updateReason(ApplyLeaveReasonChangeEvent event, Emitter<ApplyLeaveState> emit) {
      if(event.reason.length < 4){
        emit(state.copyWith(reason: event.reason,showTextFieldError: true));
      } else {
        emit(state.copyWith(reason: event.reason,showTextFieldError: false));
      }
  }

  Future<void> _applyLeave(ApplyLeaveSubmitFormEvent event, Emitter<ApplyLeaveState> emit)  async {
    emit(state.copyWith(leaveRequestStatus: ApplyLeaveStatus.loading));
    if (state.reason.length < 4) {
      emit(state.copyWith(error: fillDetailsError,showTextFieldError: true,leaveRequestStatus: ApplyLeaveStatus.failure));
    } else if (state.totalLeaveDays == 0) {
      emit(state.copyWith(error: applyMinimumHalfDay,leaveRequestStatus: ApplyLeaveStatus.failure));
    } else if (state.endDate.difference(state.startDate).inDays.isNegative) {
      emit(state.copyWith(error: invalidLeaveDateError,leaveRequestStatus: ApplyLeaveStatus.failure));
    } else {
      try {
        await _userLeaveService.applyForLeave(_getLeaveData());
        emit(state.copyWith(leaveRequestStatus: ApplyLeaveStatus.success));
      } on Exception {
        emit(state.copyWith(error: firestoreFetchDataError,leaveRequestStatus: ApplyLeaveStatus.failure));
      }
    }
  }

  Leave _getLeaveData() {
    final entries = state.selectedDates.entries.where((day) => day.value != noLeave);
    DateTime firstDate = entries.first.key;
    DateTime lastDate = entries.last.key;
    Map<DateTime,int> selectedDates = state.selectedDates..removeWhere((key, value) => key.isBefore(firstDate) || key.isAfter(lastDate));
    return Leave(
      leaveId: const Uuid().v4(),
      uid: _userManager.employeeId,
      leaveType: state.leaveType,
      startDate: firstDate.timeStampToInt,
      endDate: lastDate.timeStampToInt,
      totalLeaves: state.totalLeaveDays,
      reason: state.reason,
      leaveStatus: pendingLeaveStatus,
      appliedOn: DateTime.now().timeStampToInt,
      perDayDuration: selectedDates.values.toList(),
    );
  }

}
