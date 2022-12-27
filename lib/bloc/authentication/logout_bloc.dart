import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/services/auth/auth_service.dart';
import '../../exception/error_const.dart';
import '../../pref/user_preference.dart';
import '../../provider/user_data.dart';
import 'logout_event.dart';
import 'logout_state.dart';

@Injectable()
class LogOutBloc extends Bloc<SignOutEvent, LogOutState> {
  final UserPreference _userPreference;
  final AuthService _authService;
  final UserManager _userManager;


  LogOutBloc( this._userPreference, this._authService,this._userManager)
      : super(LogOutInitialState()) {
    on<SignOutEvent>(_signOut);
  }

  Future<void> _signOut(SignOutEvent event, Emitter<LogOutState> emit) async {
    emit(LogOutLoadingState());
    bool isLogOut = await _authService.signOutWithGoogle();
    if (isLogOut) {
      await _userPreference.removeCurrentUser();
      _userManager.hasLoggedIn();
      emit(LogOutSuccessState());
    } else {
      emit(LogOutFailureState(error: signOutError));
    }
  }


}
