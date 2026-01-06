import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/repo/leave_repo.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_event.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_state.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/model/leave/leave.dart';

@Injectable()
class UserLeaveDetailBloc
    extends Bloc<UserLeaveDetailEvent, UserLeaveDetailState> {
  final LeaveRepo _leaveRepo;

  UserLeaveDetailBloc(this._leaveRepo) : super(UserLeaveDetailInitialState()) {
    on<FetchLeaveDetailEvent>(_fetchLeaveDetail);
    on<CancelLeaveApplicationEvent>(_cancelLeaveApplication);
  }

  Future<void> _fetchLeaveDetail(
    FetchLeaveDetailEvent event,
    Emitter<UserLeaveDetailState> emit,
  ) async {
    emit(UserLeaveDetailLoadingState());
    try {
      Leave? leave = await _leaveRepo.fetchLeave(leaveId: event.leaveId);
      if (leave == null) {
        emit(UserLeaveDetailErrorState(error: firestoreFetchDataError));
      } else {
        bool canCancel =
            leave.startDate.areSameOrUpcoming(DateTime.now().dateOnly) &&
            leave.status == LeaveStatus.pending;
        emit(
          UserLeaveDetailSuccessState(
            leave: leave,
            showCancelButton: canCancel,
          ),
        );
      }
    } on Exception {
      emit(UserLeaveDetailErrorState(error: firestoreFetchDataError));
    }
  }

  Future<void> _cancelLeaveApplication(
    CancelLeaveApplicationEvent event,
    Emitter<UserLeaveDetailState> emit,
  ) async {
    emit(UserLeaveDetailLoadingState());
    try {
      await _leaveRepo.updateLeaveStatus(
        leaveId: event.leaveId,
        status: LeaveStatus.cancelled,
      );
      emit(UserCancelLeaveSuccessState());
    } on Exception {
      emit(UserLeaveDetailErrorState(error: firestoreFetchDataError));
    }
  }
}
