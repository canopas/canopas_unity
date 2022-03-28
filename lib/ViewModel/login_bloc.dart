import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ViewModel/api_response.dart';
import 'package:rxdart/rxdart.dart';
import '../services/network_repository.dart';

GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
]);

@Singleton()
class LoginBloc {
  final NetworkRepository _networkRepository;

  LoginBloc(this._networkRepository);

  final _loginSubject = BehaviorSubject<ApiResponse<bool>>();

  BehaviorSubject<ApiResponse<bool>> get loginResponse => _loginSubject;

  signInWithGoogle() async {
    try {
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        GoogleSignInAuthentication googleKey = await account.authentication;
        String? googleIdToken = googleKey.idToken!;
        String email = account.email;

        await _networkRepository.googleLogin(googleIdToken, email);
        _loginSubject.sink.add(ApiResponse.completed(true));
      } else {
        _loginSubject.sink.addError(ApiResponse.error("Unable to sign in"));
      }
    } catch (error) {
      _loginSubject.sink.addError(ApiResponse.error(error.toString()));
    }
  }

  void dispose() {
    _loginSubject.close();
  }
}
