import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_event.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_state.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/event_bus/events.dart';
import '../../../../../data/provider/user_state.dart';
import '../../../../../data/services/leave_service.dart';

@Injectable()
class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  final UserStateNotifier _userManager;
  final LeaveService _leaveService;
  StreamSubscription? _leaveRequestStreamSubscription;

  UserHomeBloc(this._userManager, this._leaveService)
      : super(UserHomeInitialState()) {
    on<UserHomeFetchLeaveRequest>(_fetchLeaveRequest);
    _leaveRequestStreamSubscription =
        eventBus.on<UpdateLeavesEvent>().listen((event) {
      add(UserHomeFetchLeaveRequest());
    });
  }

  Future<void> _fetchLeaveRequest(
      UserHomeFetchLeaveRequest event, Emitter<UserHomeState> emit) async {
    emit(UserHomeLoadingState());
    try {
      final requests =
          await _leaveService.getRequestedLeave(_userManager.employeeId);
      emit(UserHomeSuccessState(requests: requests));
    } on Exception {
      emit(UserHomeErrorState(error: firestoreFetchDataError));
    }
  }

  @override
  Future<void> close() async {
    await _leaveRequestStreamSubscription?.cancel();
    return super.close();
  }
}
