import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_event.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_state.dart';
import '../../../../../../data/Repo/leave_repo.dart';
import '../../../../../../data/core/exception/error_const.dart';
import '../../../../../../data/core/utils/bloc_status.dart';
import '../../../../../../data/model/leave/leave.dart';
import '../../../../../../data/provider/user_state.dart';

@Injectable()
class UserLeaveBloc extends Bloc<UserLeavesEvents, UserLeaveState> {
  final LeaveRepo _leaveRepo;
  final UserStateNotifier _userManager;
  StreamSubscription? _subscription;

  UserLeaveBloc(this._userManager, this._leaveRepo) : super(UserLeaveState()) {
    on<ListenUserLeaves>(_listenLeaves);
    on<ShowUserLeaves>(_showLeaves);
    on<ShowError>(_showError);
  }

  Future<void> _listenLeaves(
      ListenUserLeaves event, Emitter<UserLeaveState> emit) async {
    emit(state.copyWith(status: Status.loading, selectedYear: event.year));
    try {
      if (_subscription != null) {
       await _subscription?.cancel();
      }
      _subscription = _leaveRepo
          .userLeavesByYear(_userManager.employeeId, event.year)
          .listen((List<Leave> leaves) {
        add(ShowUserLeaves(leaves));
      }, onError: (error, _) {
        add(const ShowError());
      });
    } on Exception {
      add(const ShowError());
    }
  }

  void _showLeaves(ShowUserLeaves event, Emitter<UserLeaveState> emit) {
    event.leaves.sort((a, b) => b.startDate.compareTo(a.startDate));
    emit(state.copyWith(status: Status.success, leaves: event.leaves));
  }

  void _showError(ShowError event, Emitter<UserLeaveState> emit) {
    emit(state.copyWith(status: Status.error, error: firestoreFetchDataError));
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
