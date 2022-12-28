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
import '../../../../../../services/admin/paid_leave/paid_leave_service.dart';
import '../../../../../../services/leave/user_leave_service.dart';
import 'leave_request_view_events.dart';
import 'leave_request_view_states.dart';

@Injectable()
class LeaveRequestBloc extends Bloc<LeaveRequestEvents, LeaveRequestViewState> {

  final PaidLeaveService _paidLeaveService;
  final UserLeaveService _userLeaveService;
  final UserManager _userManager;

  LeaveRequestBloc(this._userManager, this._paidLeaveService, this._userLeaveService)
      : super(LeaveRequestViewState(
      startDate: DateTime.now().dateOnly,
      endDate: DateTime.now().dateOnly,
      selectedDates: <DateTime,int>{}.getSelectedLeaveOfTheDays(startDate: DateTime.now().dateOnly,endDate: DateTime.now().dateOnly),
      totalLeaveDays: <DateTime,int>{}.getSelectedLeaveOfTheDays(startDate: DateTime.now().dateOnly,endDate: DateTime.now().dateOnly).getTotalLeaveCount(),
  )) {
    on<LeaveRequestFormInitialLoadEvent>(_fetchLeaveCount);
    on<LeaveRequestStartDateChangeEvents>(_updateStartLeaveDate);
    on<LeaveRequestEndDateChangeEvent>(_updateEndLeaveDate);
    on<LeaveRequestReasonChangeEvent>(_updateReason);
    on<LeaveRequestUpdateLeaveOfTheDayEvent>(_updateLeaveOfTheDay);
    on<LeaveRequestApplyLeaveEvent>(_applyLeave);
    on<LeaveRequestLeaveTypeChangeEvent>(_updateLeaveType);

  }

  Future<void> _fetchLeaveCount(LeaveRequestFormInitialLoadEvent event, Emitter<LeaveRequestViewState> emit) async {
    emit(state.copyWith(leaveCountStatus: LeaveRequestLeaveCountStatus.loading));
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
      emit(state.copyWith(leaveCountStatus: LeaveRequestLeaveCountStatus.success,leaveCounts: leaveCounts));
    } on Exception {
      emit(state.copyWith(leaveCountStatus: LeaveRequestLeaveCountStatus.failure,error: firestoreFetchDataError));
    }
  }

  void _updateStartLeaveDate(LeaveRequestStartDateChangeEvents event, Emitter<LeaveRequestViewState> emit) {
    Map<DateTime, int> updatedSelectedLeaves = state.selectedDates.getSelectedLeaveOfTheDays(startDate: event.startDate ?? state.startDate, endDate: state.endDate);
    emit(state.copyWith(
        startDate: event.startDate,
        selectedDates: updatedSelectedLeaves,
        totalLeaveDays: updatedSelectedLeaves.getTotalLeaveCount()));
  }

  void _updateLeaveType(LeaveRequestLeaveTypeChangeEvent event, Emitter<LeaveRequestViewState> emit) {
   emit(state.copyWith(leaveType: event.leaveType));
  }

  void _updateEndLeaveDate(LeaveRequestEndDateChangeEvent event, Emitter<LeaveRequestViewState> emit) {
    Map<DateTime, int> updatedSelectedLeaves = state.selectedDates.getSelectedLeaveOfTheDays(startDate: state.startDate, endDate: event.endDate ?? state.endDate);
    emit(state.copyWith(
        endDate: event.endDate,
        selectedDates: updatedSelectedLeaves,
        totalLeaveDays: updatedSelectedLeaves.getTotalLeaveCount()));
  }

  void _updateLeaveOfTheDay(LeaveRequestUpdateLeaveOfTheDayEvent event, Emitter<LeaveRequestViewState> emit) {
    Map<DateTime, int> leaveOfTheDays = state.selectedDates;
    leaveOfTheDays.update(event.date, (value) => event.value, ifAbsent: () => event.date.isWeekend ? noLeave : fullLeave);
    emit(state.copyWith(
        selectedDates: leaveOfTheDays,
        totalLeaveDays: leaveOfTheDays.getTotalLeaveCount()));
  }

  void _updateReason(LeaveRequestReasonChangeEvent event, Emitter<LeaveRequestViewState> emit) {
      if(event.reason.length < 4){
        emit(state.copyWith(reason: event.reason,showTextFieldError: true));
      } else {
        emit(state.copyWith(reason: event.reason,showTextFieldError: false));
      }
  }

  Future<void> _applyLeave(LeaveRequestApplyLeaveEvent event, Emitter<LeaveRequestViewState> emit)  async {
    emit(state.copyWith(leaveRequestStatus: LeaveRequestStatus.loading));
    if (state.reason.length < 4) {
      emit(state.copyWith(error: fillDetailsError,showTextFieldError: true,leaveRequestStatus: LeaveRequestStatus.failure));
    } else if (state.totalLeaveDays == 0) {
      emit(state.copyWith(error: applyMinimumHalfDay,leaveRequestStatus: LeaveRequestStatus.failure));
    } else if (state.endDate.difference(state.startDate).inDays.isNegative) {
      emit(state.copyWith(error: invalidLeaveDateError,leaveRequestStatus: LeaveRequestStatus.failure));
    } else {
      try {
        await _userLeaveService.applyForLeave(_getLeaveData());
        emit(state.copyWith(leaveRequestStatus: LeaveRequestStatus.success));
      } on Exception {
        emit(state.copyWith(error: firestoreFetchDataError,leaveRequestStatus: LeaveRequestStatus.failure));
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
