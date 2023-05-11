import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/services/space_service.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_state.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_cout_event.dart';
import '../../../../../../data/core/exception/error_const.dart';
import '../../../../../../data/core/utils/bloc_status.dart';
import '../../../../../../data/provider/user_data.dart';
import '../../../../../../data/services/leave_service.dart';

@Injectable()
class UserLeaveCountBloc
    extends Bloc<FetchLeaveCountEvent, UserLeaveCountState> {
  final LeaveService _leaveService;
  final UserManager _userManger;
  final SpaceService _spaceService;

  UserLeaveCountBloc(this._leaveService, this._userManger, this._spaceService)
      : super(const UserLeaveCountState()) {
    on<FetchLeaveCountEvent>(_fetchLeaveCount);
  }

  Future<void> _fetchLeaveCount(
      FetchLeaveCountEvent event, Emitter<UserLeaveCountState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final double usedLeaves =
          await _leaveService.getUserUsedLeaves(_userManger.employeeId);
      final int totalLeaves = await _spaceService.getPaidLeaves(
          spaceId: _userManger.currentSpaceId!);
      final percentage = usedLeaves / totalLeaves;
      emit(state.copyWith(
          status: Status.success,
          used: usedLeaves,
          totalLeaves: totalLeaves,
          leavePercentage: percentage));
    } on Exception {
      emit(state.copyWith(
          status: Status.success, error: firestoreFetchDataError));
    }
  }
}
