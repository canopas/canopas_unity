import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/event_bus/events.dart';
import '../../../../../data/provider/user_data.dart';
import '../../../../../data/services/auth_service.dart';
import 'admin_settings_event.dart';
import 'admin_settings_state.dart';

@Injectable()
class AdminSettingsBloc extends Bloc<AdminSettingsEvent, AdminSettingsState> {
  late StreamSubscription _subscription;
  final AuthService _authService;
  final UserManager _userManager;

  AdminSettingsBloc(this._userManager, this._authService)
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
    emit(state.copyWith(status: Status.loading));
    bool isLogOut = await _authService.signOutWithGoogle();
    if (isLogOut) {
      await _userManager.removeAll();
      emit(state.copyWith(status: Status.success));
    } else {
      emit(state.copyWith(error: signOutError, status: Status.error));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
