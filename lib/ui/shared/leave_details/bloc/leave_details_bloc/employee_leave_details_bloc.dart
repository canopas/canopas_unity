import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../exception/error_const.dart';
import '../../../../../event_bus/events.dart';
import '../../../../../provider/user_data.dart';
import '../../../../../services/admin/paid_leave/paid_leave_service.dart';
import '../../../../../services/leave/user_leave_service.dart';
import 'leave_details_event.dart';
import 'leave_details_state.dart';

@Injectable()
class LeaveDetailsBloc extends Bloc<LeaveDetailsEvents, LeaveDetailsState> {
  final UserLeaveService _userLeaveService;
  final PaidLeaveService _paidLeaveService;
  final UserManager _userManager;

  LeaveDetailsBloc(this._userLeaveService, this._paidLeaveService, this._userManager)
      : super(const LeaveDetailsState()) {
    on<LeaveDetailsInitialLoadEvents>(_initLeaveCounts);
    on<LeaveDetailsRemoveLeaveRequestEvent>(_removeLeaveRequest);
  }

  Future<void> _initLeaveCounts(LeaveDetailsInitialLoadEvents event, Emitter<LeaveDetailsState> emit) async {
    emit(state.copyWith(leaveDetailsLeaveCountStatus: LeaveDetailsLeaveCountStatus.loading));
    if (event.leaveApplication.leaveCounts != null) {
      emit(state.copyWith(
          leaveDetailsLeaveCountStatus: LeaveDetailsLeaveCountStatus.success,
          paidLeaveCount:event.leaveApplication.leaveCounts!.paidLeaveCount,
          remainingLeaveCount:  event.leaveApplication.leaveCounts!.remainingLeaveCount ));
    } else {
      try {
        int paidLeaves = await _paidLeaveService.getPaidLeaves();
        double usedLeave = await _userLeaveService
            .getUserUsedLeaveCount(event.leaveApplication.employee.id);
        double remainingLeaves = paidLeaves - usedLeave;
        emit(state.copyWith(
            leaveDetailsLeaveCountStatus: LeaveDetailsLeaveCountStatus.success,
            paidLeaveCount: paidLeaves,
            remainingLeaveCount: remainingLeaves < 0 ? 0 : remainingLeaves));
      } on Exception {
        emit(state.copyWith(error: firestoreFetchDataError,leaveDetailsLeaveCountStatus:LeaveDetailsLeaveCountStatus.failure));
      }
    }
  }

  String get currentUserId => _userManager.employeeId;
  bool get currentUserIsAdmin => _userManager.isAdmin;

  void _removeLeaveRequest(LeaveDetailsRemoveLeaveRequestEvent event,
      Emitter<LeaveDetailsState> emit) {
    emit(state.copyWith(leaveDetailsStatus: LeaveDetailsStatus.loading));
    try {
      _userLeaveService.deleteLeaveRequest(event.leaveApplication.leave.leaveId);
      eventBus.fire(LeaveUpdateEventListener(event.leaveApplication));
      emit(state.copyWith(leaveDetailsStatus:LeaveDetailsStatus.success));
    } on Exception {
      emit(state.copyWith(error: firestoreFetchDataError,leaveDetailsStatus:LeaveDetailsStatus.failure));
    }
  }

}
