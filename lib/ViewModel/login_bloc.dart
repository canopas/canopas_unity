import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/services/auth_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../services/login/login_request_provider.dart';

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

  Future<Map<String, dynamic>> _getLoginData(
      String googleIdToken, String email) async {
    final loginData = await LoginRequestDataProvider.getLoginRequestData(
        googleIdToken, email);
    Map<String, dynamic> data = loginData.toJson(loginData);
    return data;
  }

  signInWithGoogle() async {
    try {
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        GoogleSignInAuthentication googleKey = await account.authentication;
        String? googleIdToken = googleKey.idToken!;
        String email = account.email;
        _loginSubject.sink.add(const ApiResponse.loading());
        Map<String, dynamic> data = await _getLoginData(googleIdToken, email);
        await _authManager.login(data);
        _loginSubject.sink.add(const ApiResponse.completed(data: true));
      } else {
        _loginSubject.sink
            .add(const ApiResponse.error(message: 'user not found'));
      }
    } on Exception catch (error) {
      _loginSubject.sink.add(ApiResponse.error(message: error.toString()));
    }
  }

  void dispose() {
    _loginSubject.close();
  }
}
