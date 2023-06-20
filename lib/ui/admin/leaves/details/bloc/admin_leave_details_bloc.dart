import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/space_service.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/services/leave_service.dart';
import '../../../../../data/services/mail_notification_service.dart';
import 'admin_leave_details_event.dart';
import 'admin_leave_details_state.dart';

@Injectable()
class AdminLeaveDetailsBloc
    extends Bloc<AdminLeaveDetailsEvents, AdminLeaveDetailsState> {
  final UserStateNotifier _userManager;
  final SpaceService _spaceService;
  final LeaveService _leaveService;
  final NotificationService _notificationService;

  AdminLeaveDetailsBloc(
    this._leaveService,
    this._userManager,
    this._spaceService,
    this._notificationService,
  ) : super(const AdminLeaveDetailsState()) {
    on<AdminLeaveDetailsFetchLeaveCountEvent>(_fetchLeaveCounts);
    on<ReasonChangedEvent>(_onReplyChange);
    on<LeaveResponseEvent>(_responseToLeaveApplication);
  }

  Future<void> _fetchLeaveCounts(AdminLeaveDetailsFetchLeaveCountEvent event,
      Emitter<AdminLeaveDetailsState> emit) async {
    emit(state.copyWith(leaveCountStatus: Status.loading));
    try {
      int paidLeaves = await _spaceService.getPaidLeaves(
          spaceId: _userManager.currentSpaceId!);
      double usedLeave =
          await _leaveService.getUserUsedLeaves(event.employeeId);
      emit(state.copyWith(
          leaveCountStatus: Status.success,
          paidLeaveCount: paidLeaves,
          usedLeaves: usedLeave));
    } on Exception {
      emit(state.copyWith(
          error: firestoreFetchDataError, leaveCountStatus: Status.error));
    }
  }

  Future<void> _responseToLeaveApplication(
      LeaveResponseEvent event, Emitter<AdminLeaveDetailsState> emit) async {
    emit(state.copyWith(actionStatus: Status.loading));
    try {
      await _leaveService.updateLeaveStatus(
          id: event.leaveId,
          status: event.responseStatus,
          response: state.adminReply);
      await _notificationService.leaveResponse(
          name: event.name,
          startDate: event.startDate,
          endDate: event.endDate,
          status: event.responseStatus,
          receiver: event.email);
      emit(state.copyWith(actionStatus: Status.success));
    } on Exception {
      emit(state.copyWith(
          error: firestoreFetchDataError, actionStatus: Status.error));
    }
  }

  void _onReplyChange(
      ReasonChangedEvent event, Emitter<AdminLeaveDetailsState> emit) {
    emit(state.copyWith(adminReply: event.adminReply));
  }
}
