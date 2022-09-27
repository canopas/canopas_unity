import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/stateManager/auth/auth_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../../exception/custom_exception.dart';
import '../../exception/error_const.dart';

GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
]);

@Singleton()
class LoginBloc {
  final AuthManager _authManager;

  LoginBloc(this._authManager);

  var _loginSubject = BehaviorSubject<ApiResponse<bool>>();

  BehaviorSubject<ApiResponse<bool>> get loginResponse => _loginSubject;

  Future<void> signIn() async {
    _loginSubject.add(const ApiResponse.loading());

    try {
      User? user = await _signInWithGoogle();
      if (user == null) {
        _loginSubject.add(const ApiResponse.error(error: userNotFoundError));
      } else {
        final data = await _authManager.getUser(user.email!);
        try {
          if (data != null) {
            await _authManager.updateUser(data);
            _loginSubject.add(const ApiResponse.completed(data: true));
          } else {
            _loginSubject.add(const ApiResponse.completed(data: false));
          }
        } on Exception {
          _loginSubject
              .add(const ApiResponse.error(error: userDataNotUpdateError));
        }
      }
    } on Exception catch (error) {
      _loginSubject.add(ApiResponse.error(error: error.toString()));
    }
  }

  Future<User?> _signInWithGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
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
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseAuthException {
        throw CustomException(firesbaseAuthError);
      }
    }
    return user;
  }

  void dispose() {
    _loginSubject.close();
  }

  void reset() {
    _loginSubject.sink.add(const ApiResponse.idle());
  }

  void restart(){
    _loginSubject = BehaviorSubject<ApiResponse<bool>>();
  }

}
