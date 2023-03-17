import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_event.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_state.dart';
import '../../../../../../data/core/exception/error_const.dart';
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
      : super(UserLeaveInitialState()) {
    on<FetchUserLeaveEvent>(_fetchLeaves);
    _streamSubscription = eventBus.on<CancelLeaveByUser>().listen((event) {
      add(FetchUserLeaveEvent());
    });
  }

  Future<void> _fetchLeaves(
      FetchUserLeaveEvent event, Emitter<UserLeaveState> emit) async {
    emit(UserLeaveLoadingState());
    try {
      List<Leave> allLeaves =
          await _leaveService.getAllLeavesOfUser(_userManager.employeeId);
      List<Leave> pastLeaves = allLeaves
          .where((leave) => leave.endDate <= DateTime.now().timeStampToInt)
          .toList();
      List<Leave> upcomingLeaves = allLeaves
          .where((leave) => leave.startDate >= DateTime.now().timeStampToInt)
          .where((leave) => leave.leaveStatus == approveLeaveStatus)
          .toList();
      emit(UserLeaveSuccessState(
          pastLeaves: pastLeaves, upcomingLeaves: upcomingLeaves));
    } on Exception {
      emit(UserLeaveErrorState(error: firestoreFetchDataError));
    }
  }

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    return super.close();
  }
}
