import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/utils/const/firestore.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/leave/leave.dart';
import '../../../../../services/admin/paid_leave/paid_leave_service.dart';
import '../../../../../services/admin/requests/admin_leave_service.dart';
import '../../../../../services/leave/user_leave_service.dart';
import 'admin_leave_details_event.dart';
import 'admin_leave_details_state.dart';

@Injectable()
class AdminLeaveApplicationDetailsBloc extends Bloc<AdminLeaveApplicationDetailsEvents,AdminLeaveApplicationDetailsState> {
  final UserLeaveService _userLeaveService;
  final PaidLeaveService _paidLeaveService;
  final AdminLeaveService _adminLeaveService;

  AdminLeaveApplicationDetailsBloc(this._userLeaveService,
      this._adminLeaveService, this._paidLeaveService)
      : super(const AdminLeaveApplicationDetailsState()) {
    on<AdminLeaveRequestDetailsInitialLoadEvents>(_initLeaveCounts);
    on<AdminLeaveApplicationDetailsApproveRequestEvent>(_approveLeave);
    on<AdminLeaveApplicationDetailsRejectRequestEvent>(_rejectLeave);
    on<AdminLeaveApplicationReasonChangedEvent>(_onReplyChange);
  }
  
  
  Future<void> _initLeaveCounts(AdminLeaveRequestDetailsInitialLoadEvents event, Emitter<AdminLeaveApplicationDetailsState> emit) async {
    emit(state.copyWith(leaveDetailsLeaveCountStatus: AdminLeaveApplicationDetailsLeaveCountStatus.loading));
    if (event.leaveApplication.leaveCounts != null) {
      emit(state.copyWith(
          leaveDetailsLeaveCountStatus: AdminLeaveApplicationDetailsLeaveCountStatus.success,
          paidLeaveCount:event.leaveApplication.leaveCounts!.paidLeaveCount,
          remainingLeaveCount:  event.leaveApplication.leaveCounts!.remainingLeaveCount ));
    } else {
      try {
        int paidLeaves = await _paidLeaveService.getPaidLeaves();
        double usedLeave = await _userLeaveService
            .getUserUsedLeaveCount(event.leaveApplication.employee.id);
        double remainingLeaves = paidLeaves - usedLeave;
        emit(state.copyWith(
            leaveDetailsLeaveCountStatus: AdminLeaveApplicationDetailsLeaveCountStatus.success,
            paidLeaveCount: paidLeaves,
            remainingLeaveCount: remainingLeaves < 0 ? 0 : remainingLeaves));
      } on Exception {
        emit(state.copyWith(error: firestoreFetchDataError,leaveDetailsLeaveCountStatus:AdminLeaveApplicationDetailsLeaveCountStatus.failure));
      }
    }
  }

  void _approveLeave(AdminLeaveApplicationDetailsApproveRequestEvent event, Emitter<AdminLeaveApplicationDetailsState> emit) {
    emit(state.copyWith(leaveDetailsStatus: AdminLeaveApplicationDetailsStatus.approveLoading));
    Map<String, dynamic> map =
    _setLeaveApproval(approveLeaveStatus, state.adminReply);
    try {
      _adminLeaveService.updateLeaveStatus(event.leaveId, map);
      emit(state.copyWith(leaveDetailsStatus:AdminLeaveApplicationDetailsStatus.success));
    } on Exception {
      emit(state.copyWith(error: firestoreFetchDataError,leaveDetailsStatus:AdminLeaveApplicationDetailsStatus.failure));
    }
  }

  void _rejectLeave(
      AdminLeaveApplicationDetailsRejectRequestEvent event, Emitter<AdminLeaveApplicationDetailsState> emit) {
    emit(state.copyWith(leaveDetailsStatus: AdminLeaveApplicationDetailsStatus.rejectLoading));
    Map<String, dynamic> map =
    _setLeaveApproval(rejectLeaveStatus, state.adminReply);
    try {
      _adminLeaveService.updateLeaveStatus(event.leaveId, map);
      emit(state.copyWith(leaveDetailsStatus:AdminLeaveApplicationDetailsStatus.success));
    } on Exception {
      emit(state.copyWith(error: firestoreFetchDataError,leaveDetailsStatus:AdminLeaveApplicationDetailsStatus.failure));
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
