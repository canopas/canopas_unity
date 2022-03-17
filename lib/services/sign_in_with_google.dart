import 'package:google_sign_in/google_sign_in.dart';
import 'package:projectunity/services/network_repository.dart';
import 'package:projectunity/utils/constant.dart';
import 'package:projectunity/utils/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
]);

class LoginModel {
  final NetworkRepository _networkRepository = getIt<NetworkRepository>();

  Future<bool> signInWithGoogle() async {
    GoogleSignInAccount? account = await googleSignIn.signIn();
    if (account != null) {
      GoogleSignInAuthentication googleKey = await account.authentication;
      String? googleIdToken = googleKey.idToken!;
      String email = account.email;
      String _data = await _networkRepository.googleLogin(googleIdToken, email);
      bool success = await _isSignedIn(_data);
      return success;
    } else {
      throw Exception('Error in google sign in');
    }
  }

  Future<bool> _isSignedIn(String data) async {
    await getIt.isReady<SharedPreferences>();
    final pref = getIt<SharedPreferences>();
    var storedData = pref.getString(kEmployeeData);
    if (data == storedData) {
      return true;
    } else {
      throw Exception('Please Sign in to continue');
    }
  }
}
