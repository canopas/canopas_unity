import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_event.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_state.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/model/leave/leave.dart';
import '../../../../../data/services/leave_service.dart';

@Injectable()
class UserLeaveDetailBloc
    extends Bloc<UserLeaveDetailEvent, UserLeaveDetailState> {
  final LeaveService _leaveService;

  UserLeaveDetailBloc(this._leaveService)
      : super(UserLeaveDetailInitialState()) {
    on<FetchLeaveDetailEvent>(_fetchLeaveDetail);
    on<CancelLeaveApplicationEvent>(_cancelLeaveApplication);
  }

  Future<void> _fetchLeaveDetail(
      FetchLeaveDetailEvent event, Emitter<UserLeaveDetailState> emit) async {
    emit(UserLeaveDetailLoadingState());
    try {
      Leave? leave = await _leaveService.fetchLeave(event.leaveId);
      if (leave == null) {
        emit(UserLeaveDetailErrorState(error: firestoreFetchDataError));
      } else {
        bool canCancel =
            leave.startDate.toDate.areSameOrUpcoming(DateTime.now().dateOnly) &&
                leave.status == LeaveStatus.pending;
        emit(UserLeaveDetailSuccessState(
            leave: leave, showCancelButton: canCancel));
      }
    } on Exception {
      emit(UserLeaveDetailErrorState(error: firestoreFetchDataError));
    }
  }

  Future<void> _cancelLeaveApplication(CancelLeaveApplicationEvent event,
      Emitter<UserLeaveDetailState> emit) async {
    emit(UserLeaveDetailLoadingState());
    try {
      await _leaveService.updateLeaveStatus(id: event.leaveId,status: LeaveStatus.cancelled);
      emit(UserCancelLeaveSuccessState());
    } on Exception {
      emit(UserLeaveDetailErrorState(error: firestoreFetchDataError));
    }
  }
}
