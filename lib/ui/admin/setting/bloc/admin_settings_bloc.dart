import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../event_bus/events.dart';
import '../../../../exception/error_const.dart';
import '../../../../pref/user_preference.dart';
import '../../../../provider/user_data.dart';
import '../../../../services/auth/auth_service.dart';
import 'admin_settings_event.dart';
import 'admin_settings_state.dart';

@Injectable()
class AdminSettingsBloc extends Bloc<AdminSettingsEvent, AdminSettingsState> {
  late StreamSubscription _subscription;
  final AuthService _authService;
  final UserManager _userManager;
  final UserPreference _userPreference;

  AdminSettingsBloc(this._userManager, this._authService, this._userPreference)
      : super(AdminSettingsState(currentEmployee: _userManager.employee)) {
    on<GetCurrentEmployeeAdminSettingsEvent>(_getCurrentEmployee);
    on<AdminSettingsLogOutEvent>(_logOut);

    _subscription =
        eventBus.on<GetCurrentEmployeeAdminSettingsEvent>().listen((event) {
      add(GetCurrentEmployeeAdminSettingsEvent());
    });
  }

  _getCurrentEmployee(GetCurrentEmployeeAdminSettingsEvent event,
      Emitter<AdminSettingsState> emit) {
    emit(state.copyWith(currentEmployee: _userManager.employee));
  }

  _logOut(
      AdminSettingsLogOutEvent event, Emitter<AdminSettingsState> emit) async {
    emit(state.copyWith(status: AdminSettingsStatus.loading));
    bool isLogOut = await _authService.signOutWithGoogle();
    if (isLogOut) {
      await _userPreference.removeCurrentUser();
      _userManager.hasLoggedIn();
      emit(state.copyWith(status: AdminSettingsStatus.success));
    } else {
      emit(state.copyWith(
          error: signOutError, status: AdminSettingsStatus.failure));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
