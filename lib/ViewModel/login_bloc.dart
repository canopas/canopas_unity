import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/rest/api_response.dart';
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

  final _loginSubject = PublishSubject<ApiResponse<bool>>();

  PublishSubject<ApiResponse<bool>> get loginResponse => _loginSubject;

  signInWithGoogle() async {
    try {
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        GoogleSignInAuthentication googleKey = await account.authentication;
        String? googleIdToken = googleKey.idToken!;
        String email = account.email;
        _loginSubject.sink.add(const ApiResponse.loading());
        await _networkRepository.googleLogin(googleIdToken, email);
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
