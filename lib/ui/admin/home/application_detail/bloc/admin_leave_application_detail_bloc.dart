import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/space_service.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/core/utils/const/firestore.dart';
import '../../../../../data/model/leave/leave.dart';
import '../../../../../data/services/leave_service.dart';
import 'admin_leave_application_detail_event.dart';
import 'admin_leave_application_detail_state.dart';

@Injectable()
class AdminLeaveApplicationDetailsBloc extends Bloc<
    AdminLeaveApplicationDetailsEvents, AdminLeaveApplicationDetailsState> {
  final UserStateNotifier _userManager;
  final SpaceService _spaceService;
  final LeaveService _leaveService;

  AdminLeaveApplicationDetailsBloc(
    this._leaveService,
    this._userManager,
    this._spaceService,
  ) : super(const AdminLeaveApplicationDetailsState()) {
    on<AdminLeaveApplicationFetchLeaveCountEvent>(_fetchLeaveCounts);
    on<AdminLeaveApplicationReasonChangedEvent>(_onReplyChange);
    on<AdminLeaveResponseEvent>(_responseToLeaveApplication);
  }

  Future<void> _fetchLeaveCounts(
      AdminLeaveApplicationFetchLeaveCountEvent event,
      Emitter<AdminLeaveApplicationDetailsState> emit) async {
    emit(state.copyWith(adminLeaveCountStatus: Status.loading));
    try {
      int paidLeaves = await _spaceService.getPaidLeaves(
          spaceId: _userManager.currentSpaceId!);
      double usedLeave =
          await _leaveService.getUserUsedLeaves(event.employeeId);
      emit(state.copyWith(
          adminLeaveCountStatus: Status.success,
          paidLeaveCount: paidLeaves,
          usedLeaves: usedLeave));
    } on Exception {
      emit(state.copyWith(
          error: firestoreFetchDataError, adminLeaveCountStatus: Status.error));
    }
  }

  Future<void> _responseToLeaveApplication(AdminLeaveResponseEvent event,
      Emitter<AdminLeaveApplicationDetailsState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      if (event.response == AdminLeaveResponse.approve) {
        Map<String, dynamic> map =
            _setLeaveApproval(approveLeaveStatus, state.adminReply);
        await _leaveService.updateLeaveStatus(event.leaveId, map);
      } else if (event.response == AdminLeaveResponse.reject) {
        Map<String, dynamic> map =
            _setLeaveApproval(rejectLeaveStatus, state.adminReply);
        await _leaveService.updateLeaveStatus(event.leaveId, map);
      }
      emit(state.copyWith(status: Status.success));
    } on Exception {
      emit(state.copyWith(
          error: firestoreFetchDataError, adminLeaveCountStatus: Status.error));
    }
  }

  void _onReplyChange(AdminLeaveApplicationReasonChangedEvent event,
      Emitter<AdminLeaveApplicationDetailsState> emit) {
    emit(state.copyWith(adminReply: event.adminReply));
  }

  Map<String, dynamic> _setLeaveApproval(int leaveStatus, String reason) {
    Map<String, dynamic> map = <String, dynamic>{
      FireStoreConst.leaveStatus: leaveStatus,
      FireStoreConst.response: reason,
    };
    return map;
  }
}
