import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/user/settings/settings_screen/bloc/user_settings_event.dart';
import 'package:projectunity/ui/user/settings/settings_screen/bloc/user_settings_state.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/event_bus/events.dart';
import '../../../../../data/provider/user_data.dart';
import '../../../../../data/services/auth_service.dart';

@Injectable()
class UserSettingsBloc extends Bloc<UserSettingsEvent, UserSettingsState> {
  late StreamSubscription _subscription;
  final AuthService _authService;
  final UserManager _userManager;

  UserSettingsBloc(this._userManager, this._authService)
      : super(UserSettingsState(currentEmployee: _userManager.employee)) {
    on<GetCurrentEmployeeUserSettingsEvent>(_getCurrentEmployee);
    on<UserSettingsLogOutEvent>(_logOut);

    _subscription =
        eventBus.on<GetCurrentEmployeeUserSettingsEvent>().listen((event) {
      add(GetCurrentEmployeeUserSettingsEvent());
    });
  }

  void _getCurrentEmployee(GetCurrentEmployeeUserSettingsEvent event,
      Emitter<UserSettingsState> emit) {
    emit(state.copyWith(currentEmployee: _userManager.employee));
  }

  Future<void> _logOut(
      UserSettingsLogOutEvent event, Emitter<UserSettingsState> emit) async {
    emit(state.copyWith(status: UserSettingsStatus.loading));
    bool isLogOut = await _authService.signOutWithGoogle();
    if (isLogOut) {
      await _userManager.removeAll();
      emit(state.copyWith(status: UserSettingsStatus.success));
    } else {
      emit(state.copyWith(
          error: signOutError, status: UserSettingsStatus.failure));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
