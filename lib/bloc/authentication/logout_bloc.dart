import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/services/auth/auth_service.dart';
import '../../../navigation/navigation_stack_manager.dart';
import '../../exception/error_const.dart';
import '../../navigation/nav_stack/nav_stack_item.dart';
import '../../pref/user_preference.dart';
import 'logout_event.dart';
import 'logout_state.dart';

@Injectable()
class LogOutBloc extends Bloc<SignOutEvent, LogOutState> {
  final UserPreference _userPreference;
  final AuthService _authService;
  final NavigationStackManager _navigationStackManager;

  LogOutBloc(this._navigationStackManager, this._userPreference, this._authService)
      : super(LogOutInitialState()) {
    on<SignOutEvent>(_signOut);
  }

  Future<void> _signOut(SignOutEvent event, Emitter<LogOutState> emit) async {
    emit(LogOutLoadingState());
    bool isLogOut = await _authService.signOutWithGoogle();
    if (isLogOut) {
      await _userPreference.removeCurrentUser();
      emit(LogOutSuccessState());
      _navigationStackManager.clearAndPush(const LoginNavStackItem());
    } else {
      emit(LogOutFailureState(error: signOutError));
    }
  }


}
