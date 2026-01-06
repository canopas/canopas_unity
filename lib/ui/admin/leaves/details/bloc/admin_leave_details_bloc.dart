import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/repo/leave_repo.dart';
import '../../../../../data/services/mail_notification_service.dart';
import 'admin_leave_details_event.dart';
import 'admin_leave_details_state.dart';

@Injectable()
class AdminLeaveDetailsBloc
    extends Bloc<AdminLeaveDetailsEvents, AdminLeaveDetailsState> {
  final LeaveRepo _leaveRepo;
  final NotificationService _notificationService;

  AdminLeaveDetailsBloc(this._leaveRepo, this._notificationService)
    : super(const AdminLeaveDetailsState()) {
    on<AdminLeaveDetailsFetchLeaveCountEvent>(_fetchLeaveCounts);
    on<ReasonChangedEvent>(_onReplyChange);
    on<LeaveResponseEvent>(_responseToLeaveApplication);
  }

  Future<void> _fetchLeaveCounts(
    AdminLeaveDetailsFetchLeaveCountEvent event,
    Emitter<AdminLeaveDetailsState> emit,
  ) async {
    emit(state.copyWith(leaveCountStatus: Status.loading));
    try {
      final leaveCounts = await _leaveRepo.getUserUsedLeaves(
        uid: event.employeeId,
      );
      emit(
        state.copyWith(
          leaveCountStatus: Status.success,
          usedLeavesCount: leaveCounts,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          error: firestoreFetchDataError,
          leaveCountStatus: Status.error,
        ),
      );
    }
  }

  Future<void> _responseToLeaveApplication(
    LeaveResponseEvent event,
    Emitter<AdminLeaveDetailsState> emit,
  ) async {
    emit(state.copyWith(actionStatus: Status.loading));
    try {
      await _leaveRepo.updateLeaveStatus(
        leaveId: event.leaveId,
        status: event.responseStatus,
        response: state.adminReply,
      );
      await _notificationService.leaveResponse(
        name: event.name,
        startDate: event.startDate,
        endDate: event.endDate,
        status: event.responseStatus,
        receiver: event.email,
      );
      emit(state.copyWith(actionStatus: Status.success));
    } on Exception {
      emit(
        state.copyWith(
          error: firestoreFetchDataError,
          actionStatus: Status.error,
        ),
      );
    }
  }

  void _onReplyChange(
    ReasonChangedEvent event,
    Emitter<AdminLeaveDetailsState> emit,
  ) {
    emit(state.copyWith(adminReply: event.adminReply));
  }
}
