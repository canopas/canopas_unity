import 'package:google_sign_in/google_sign_in.dart';
import 'package:projectunity/services/network_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/service_locator.dart';

GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
]);

class LoginVM {
  NetworkApiService apiService = getIt<NetworkApiService>();

  Future signInWithGoogle() async {
    GoogleSignInAccount? account = await googleSignIn.signIn();
    if (account != null) {
      GoogleSignInAuthentication googleKey = await account.authentication;
      String? googleIdToken = googleKey.idToken!;
      String email = account.email;
      apiService.login(googleIdToken, email);
    } else {
      throw Exception('Error in google sign in');
    }
    return;
  }
}
