import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/utils/const/firestore.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/services/admin/paid_leave_service.dart';

import '../../../../../services/admin/leave_service.dart';
import '../../../../../services/user/user_leave_service.dart';
import 'admin_leave_application_detail_event.dart';
import 'admin_leave_application_detail_state.dart';

@Injectable()
class AdminLeaveApplicationDetailsBloc extends Bloc<
    AdminLeaveApplicationDetailsEvents, AdminLeaveApplicationDetailsState> {
  final UserLeaveService _userLeaveService;
  final PaidLeaveService _paidLeaveService;
  final AdminLeaveService _adminLeaveService;

  AdminLeaveApplicationDetailsBloc(
      this._userLeaveService, this._adminLeaveService, this._paidLeaveService)
      : super(const AdminLeaveApplicationDetailsState()) {
    on<AdminLeaveApplicationFetchLeaveCountEvent>(_fetchLeaveCounts);
    on<AdminLeaveApplicationReasonChangedEvent>(_onReplyChange);
    on<AdminLeaveResponseEvent>(_responseToLeaveApplication);
  }

  Future<void> _fetchLeaveCounts(
      AdminLeaveApplicationFetchLeaveCountEvent event,
      Emitter<AdminLeaveApplicationDetailsState> emit) async {
    emit(state.copyWith(adminLeaveCountStatus: AdminLeaveCountStatus.loading));
    try {
      int paidLeaves = await _paidLeaveService.getPaidLeaves();
      double usedLeave =
          await _userLeaveService.getUserUsedLeaveCount(event.employeeId);
      emit(state.copyWith(
          adminLeaveCountStatus: AdminLeaveCountStatus.success,
          paidLeaveCount: paidLeaves,
          usedLeaves: usedLeave));
    } on Exception {
      emit(state.copyWith(
          error: firestoreFetchDataError,
          adminLeaveCountStatus: AdminLeaveCountStatus.failure));
    }
  }

  Future<void> _responseToLeaveApplication(AdminLeaveResponseEvent event,
      Emitter<AdminLeaveApplicationDetailsState> emit) async {
    emit(state.copyWith(
        adminLeaveResponseStatus: AdminLeaveResponseStatus.loading));
    try {
      if (event.response == AdminLeaveResponse.approve) {
        Map<String, dynamic> map =
            _setLeaveApproval(approveLeaveStatus, state.adminReply);
        await _adminLeaveService.updateLeaveStatus(event.leaveId, map);
      } else if (event.response == AdminLeaveResponse.reject) {
        Map<String, dynamic> map =
            _setLeaveApproval(rejectLeaveStatus, state.adminReply);
        await _adminLeaveService.updateLeaveStatus(event.leaveId, map);
      }
      emit(state.copyWith(
          adminLeaveResponseStatus: AdminLeaveResponseStatus.success));
    } on Exception {
      emit(state.copyWith(
          error: firestoreFetchDataError,
          adminLeaveCountStatus: AdminLeaveCountStatus.failure));
    }
  }

  void _onReplyChange(AdminLeaveApplicationReasonChangedEvent event,
      Emitter<AdminLeaveApplicationDetailsState> emit) {
    emit(state.copyWith(adminReply: event.adminReply));
  }

  Map<String, dynamic> _setLeaveApproval(int leaveStatus, String reason) {
    Map<String, dynamic> map = <String, dynamic>{
      FirestoreConst.leaveStatus: leaveStatus,
      FirestoreConst.rejectionReason: reason,
    };
    return map;
  }
}