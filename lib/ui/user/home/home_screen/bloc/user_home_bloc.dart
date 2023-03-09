import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_event.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_state.dart';

import '../../../../../event_bus/events.dart';
import '../../../../../exception/error_const.dart';
import '../../../../../pref/user_preference.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../services/leave_service.dart';

@Injectable()
class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  final UserManager _userManager;
  final UserPreference _userPreference;
  final AuthService _authService;
  final LeaveService _leaveService;
  StreamSubscription? _streamSubscription;

  UserHomeBloc(this._userPreference, this._authService, this._userManager,
      this._leaveService)
      : super(UserHomeInitialState()) {
    on<UserDisabled>(_removeUser);
    on<UserHomeFetchLeaveRequest>(_fetchLeaveRequest);
    _streamSubscription = eventBus.on<DeleteEmployeeByAdmin>().listen((event) {
      add(UserDisabled(event.userId));
    });
  }

  Future<void> _removeUser(
      UserDisabled event, Emitter<UserHomeState> emit) async {
    if (event.employeeId == _userManager.employeeId) {
      try {
        await _authService.signOutWithGoogle();
        await _userPreference.removeCurrentUser();
        _userManager.hasLoggedIn();
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
          await _leaveService.getRequestedLeaveOfUser(_userManager.employeeId);
      emit(UserHomeSuccessState(requests: requests));
    } on Exception {
      emit(UserHomeErrorState(error: firestoreFetchDataError));
    }
  }

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    return super.close();
  }
}
