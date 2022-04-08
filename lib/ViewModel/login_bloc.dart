import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/utils/data_exception.dart';
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

  final _loginSubject = PublishSubject<ApiResponse<GoogleSignInAccount?>>();

  PublishSubject<ApiResponse<GoogleSignInAccount?>> get loginResponse => _loginSubject;

  isLogin() {
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? currentUser) {
        _loginSubject.sink.add( ApiResponse.completed(data: currentUser));

      print('already have a account');
    });
    googleSignIn.signInSilently();
  }

  signInWithGoogle() async {
    try {
     GoogleSignInAccount?  account = await googleSignIn.signIn();
      print('Google SigninAccount in loginbloc');
      if (account != null) {
        GoogleSignInAuthentication googleKey = await account.authentication;
        String? googleIdToken = googleKey.idToken!;
        String email = account.email;
        _loginSubject.sink.add(const ApiResponse.loading());
        await _networkRepository.googleLogin(googleIdToken, email);
        print('try to fetch account detail in login bloc');
        _loginSubject.sink.add(ApiResponse.completed(data: account));
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
