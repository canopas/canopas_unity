import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_event.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_state.dart';

import '../../../../../services/user/user_leave_service.dart';

@Injectable()
class UserLeaveDetailBloc
    extends Bloc<UserLeaveDetailEvent, UserLeaveDetailState> {
  final UserLeaveService _userLeaveService;

  UserLeaveDetailBloc(this._userLeaveService)
      : super(UserLeaveDetailInitialState()) {
    on<FetchLeaveDetailEvent>(_fetchLeaveDetail);
    on<CancelLeaveApplicationEvent>(_cancelLeaveApplication);
  }

  Future<void> _fetchLeaveDetail(
      FetchLeaveDetailEvent event, Emitter<UserLeaveDetailState> emit) async {
    emit(UserLeaveDetailLoadingState());
    try {
      Leave? leave = await _userLeaveService.fetchLeave(event.leaveId);
      if (leave == null) {
        emit(UserLeaveDetailErrorState(error: firestoreFetchDataError));
      } else {
        bool canCancel =
            leave.startDate.toDate.areSameOrUpcoming(DateTime.now().dateOnly) &&
                leave.leaveStatus == pendingLeaveStatus;
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
      await _userLeaveService.deleteLeaveRequest(event.leaveId);
      emit(UserCancelLeaveSuccessState());
    } on Exception {
      emit(UserLeaveDetailErrorState(error: firestoreFetchDataError));
    }
  }
}
