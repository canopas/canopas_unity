import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_event.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_state.dart';
import '../../../../../../data/core/exception/error_const.dart';
import '../../../../../../data/core/utils/bloc_status.dart';
import '../../../../../../data/event_bus/events.dart';
import '../../../../../../data/model/leave/leave.dart';
import '../../../../../../data/provider/user_data.dart';
import '../../../../../../data/services/leave_service.dart';

@Injectable()
class UserLeaveBloc extends Bloc<FetchUserLeaveEvent, UserLeaveState> {
  final LeaveService _leaveService;
  final UserManager _userManager;
  late StreamSubscription? _streamSubscription;

  UserLeaveBloc(this._userManager, this._leaveService)
      : super(const UserLeaveState()) {
    on<FetchUserLeaveEvent>(_fetchLeaves);
    _streamSubscription = eventBus.on<CancelLeaveByUser>().listen((event) {
      add(FetchUserLeaveEvent());
    });
  }

  Future<void> _fetchLeaves(
      FetchUserLeaveEvent event, Emitter<UserLeaveState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      List<Leave> leaves =
          await _leaveService.getAllLeavesOfUser(_userManager.employeeId);
      leaves.sort((a, b) => b.startDate.compareTo(a.startDate));
      emit(state.copyWith(status: Status.success, leaves: leaves));
    } on Exception {
      emit(
          state.copyWith(status: Status.error, error: firestoreFetchDataError));
    }
  }

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    return super.close();
  }
}
