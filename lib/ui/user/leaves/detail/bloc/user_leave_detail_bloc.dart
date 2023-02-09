import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_event.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_state.dart';

import '../../../../../services/user/user_leave_service.dart';

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
      if (leave == null)
        emit(UserLeaveDetailErrorState(error: firestoreFetchDataError));
      emit(UserLeaveDetailSuccessState(leave: leave!));
    } on Exception {
      emit(UserLeaveDetailErrorState(error: firestoreFetchDataError));
    }
  }

  Future<void> _cancelLeaveApplication(
      CancelLeaveApplicationEvent event, Emitter<UserLeaveDetailState> emit) {}
}
