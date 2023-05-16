import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_event.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_state.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/event_bus/events.dart';
import '../../../../../data/provider/user_data.dart';
import '../../../../../data/services/auth_service.dart';
import '../../../../../data/services/leave_service.dart';

@Injectable()
class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  final UserManager _userManager;
  final AuthService _authService;
  final LeaveService _leaveService;
  StreamSubscription? _streamSubscription;
  StreamSubscription? _leaveRequestStreamSubscription;

  UserHomeBloc(this._authService, this._userManager,
      this._leaveService)
      : super(UserHomeInitialState()) {
    on<UserDisabled>(_removeUser);
    on<UserHomeFetchLeaveRequest>(_fetchLeaveRequest);

    _streamSubscription = eventBus.on<DeleteEmployeeByAdmin>().listen((event) {
      add(UserDisabled(event.userId));
    });

    _leaveRequestStreamSubscription =
        eventBus.on<CancelLeaveByUser>().listen((event) {
      add(UserHomeFetchLeaveRequest());
    });
  }

  Future<void> _removeUser(
      UserDisabled event, Emitter<UserHomeState> emit) async {
    if (event.employeeId == _userManager.employeeId) {
      try {
        await _authService.signOutWithGoogle();
        await _userManager.removeAll();
      } on Exception {
        throw Exception(somethingWentWrongError);
      }
    }
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
    await _streamSubscription?.cancel();
    await _leaveRequestStreamSubscription?.cancel();
    return super.close();
  }
}
