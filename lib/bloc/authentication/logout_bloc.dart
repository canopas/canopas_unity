import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/pref/user_preference.dart';

import '../../di/service_locator.dart';
import '../../navigation/navigation_stack_manager.dart';
import '../../provider/user_data.dart';
import '../../stateManager/login_state_manager.dart';

@Singleton()
class LogOutBloc {
  final LoginState _loginState;

  final UserPreference _userPreference;
  final NavigationStackManager _stateManager;
  final UserManager _userManager;

  LogOutBloc(this._loginState, this._userPreference, this._stateManager,
      this._userManager);

  Future<bool> signOutFromApp() async {
    bool success = await _signOut();
    if (success) {
      await getIt.unregister(instance: _stateManager);
      getIt.registerLazySingleton(() => NavigationStackManager(_userManager));

      return true;
    } else {
      return false;
    }
  }

  Future<bool> _signOut() async {
    bool isLogOut = await _signOutWithGoogle();
    if (isLogOut) {
      await _userPreference.removeCurrentUser();
      _loginState.setUserLogin(false);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _signOutWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      final FirebaseAuth auth = FirebaseAuth.instance;
      await googleSignIn.signOut();
      await auth.signOut();
      return true;
    } on Exception catch (error) {
      return false;
    }
  }
}