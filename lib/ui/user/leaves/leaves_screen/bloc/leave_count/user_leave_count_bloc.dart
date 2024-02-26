import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/services/space_service.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_state.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_cout_event.dart';
import '../../../../../../data/core/exception/error_const.dart';
import '../../../../../../data/core/utils/bloc_status.dart';
import '../../../../../../data/provider/user_state.dart';
import '../../../../../../data/repo/leave_repo.dart';

@Injectable()
class UserLeaveCountBloc
    extends Bloc<FetchLeaveCountEvent, UserLeaveCountState> {
  final LeaveRepo _leaveRepo;
  final UserStateNotifier _userManger;

  UserLeaveCountBloc(this._leaveRepo, this._userManger)
      : super(const UserLeaveCountState()) {
    on<FetchLeaveCountEvent>(_fetchLeaveCount);
  }

  Future<void> _fetchLeaveCount(
      FetchLeaveCountEvent event, Emitter<UserLeaveCountState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final leaveCounts =
          await _leaveRepo.getUserUsedLeaves(uid: _userManger.employeeId);

      emit(state.copyWith(
          status: Status.success,
          usedLeavesCounts: leaveCounts,
         ));
    } on Exception {
      emit(state.copyWith(
          status: Status.success, error: firestoreFetchDataError));
    }
  }
}
