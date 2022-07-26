import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/stateManager/auth/auth_manager.dart';
import 'package:rxdart/rxdart.dart';

GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
]);

@Singleton()
class LoginBloc {
  final AuthManager _authManager;

  LoginBloc(this._authManager);

  final _loginSubject = BehaviorSubject<ApiResponse<bool>>();

  BehaviorSubject<ApiResponse<bool>> get loginResponse => _loginSubject;

  signIn() async {
    _loginSubject.add(const ApiResponse.loading());

    try {
      User? user = await _signInWithGoogle();

      if (user != null) {
        if (user.email == null) {
          _loginSubject.add(const ApiResponse.error(message: "Invalid email"));
          return;
        }

        final data = await _authManager.getUser(user.email!);

        if (data == null) {
          _loginSubject.add(const ApiResponse.error(message: 'User not found'));
          return;
        }
        _authManager.updateUser(data);

        _loginSubject.add(const ApiResponse.completed(data: true));
      } else {
        _loginSubject.add(const ApiResponse.error(message: 'User not found'));
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (e.code == 'invalid-credential') {
        _loginSubject
            .add(const ApiResponse.error(message: "Invalid credential"));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      _loginSubject
          .add(const ApiResponse.error(message: "Something went wrong"));
    }
  }

  Future<User?> _signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      user = userCredential.user;

      return user;
    }
    return null;
  }

  void dispose() {
    _loginSubject.close();
  }

  void reset() {
    _loginSubject.sink.add(const ApiResponse.idle());
  }
}
