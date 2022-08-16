import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/pref/user_preference.dart';
import '../../di/service_locator.dart';
import '../../stateManager/login_state_manager.dart';

@Singleton()
class SettingViewBLoc{

   final LoginState _loginState = getIt<LoginState>();
  final UserPreference _userPreference = getIt<UserPreference>();

  Future<void> singOut()async {
    await _signOutWithGoogle();
    await _userPreference.removeCurrentUser();
    _loginState.setUserLogin(false);
  }

  Future<void> _signOutWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth auth = FirebaseAuth.instance;
    await googleSignIn.signOut();
    await auth.signOut();
  }

}