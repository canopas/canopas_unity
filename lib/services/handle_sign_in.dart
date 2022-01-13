import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
]);

class SignIn {
  Future<void> handleSignIn() async {
    try {
      GoogleSignInAccount? account = await googleSignIn.signIn();
      GoogleSignInAuthentication? googleKey = await account!.authentication;
      var googleSignInIdToken = googleKey.idToken;
      print('signed in!');
    } catch (error) {
      print('Error :' + error.toString());
    }
  }
}
