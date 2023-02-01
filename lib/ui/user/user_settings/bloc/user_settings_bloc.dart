import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/pref/user_preference.dart';
import 'package:projectunity/services/auth/auth_service.dart';
import 'package:projectunity/ui/user/user_settings/bloc/user_settings_event.dart';
import 'package:projectunity/ui/user/user_settings/bloc/user_settings_state.dart';
import '../../../../event_bus/events.dart';
import '../../../../provider/user_data.dart';

@Injectable()
class UserSettingsBloc extends Bloc<UserSettingsEvent, UserSettingsState> {
  late StreamSubscription _subscription;
  final AuthService _authService;
  final UserManager _userManager;
  final UserPreference _userPreference;

  UserSettingsBloc(this._userManager, this._authService, this._userPreference)
      : super(UserSettingsState(currentEmployee: _userManager.employee)) {
    on<GetCurrentEmployeeUserSettingsEvent>(_getCurrentEmployee);
    on<UserSettingsLogOutEvent>(_logOut);

    _subscription = eventBus.on<GetCurrentEmployeeUserSettingsEvent>().listen((event) {
      add(GetCurrentEmployeeUserSettingsEvent());
    });
  }

  _getCurrentEmployee(
      GetCurrentEmployeeUserSettingsEvent event, Emitter<UserSettingsState> emit) {
    emit(state.copyWith(currentEmployee: _userManager.employee));
  }

  _logOut(UserSettingsLogOutEvent event, Emitter<UserSettingsState> emit) async {
    emit(state.copyWith(status: UserSettingsStatus.loading));
    bool isLogOut = await _authService.signOutWithGoogle();
    if (isLogOut) {
      await _userPreference.removeCurrentUser();
      _userManager.hasLoggedIn();
      emit(state.copyWith(status: UserSettingsStatus.success));
    } else {
      emit(state.copyWith(error: signOutError, status: UserSettingsStatus.failure));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
