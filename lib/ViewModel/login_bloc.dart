import 'package:projectunity/ViewModel/api_response.dart';
import 'package:projectunity/services/sign_in_with_google.dart';
import 'package:rxdart/rxdart.dart';
import '../utils/service_locator.dart';

class LoginBloc {
  LoginModel loginModel = getIt<LoginModel>();
  final _loginSubject = BehaviorSubject<ApiResponse<bool>>();

  BehaviorSubject<ApiResponse<bool>> get loginResponse => _loginSubject;

  isSignedIn() async {
    try {
      bool success = await loginModel.signInWithGoogle();
      _loginSubject.sink.add(ApiResponse.completed(success));
    } catch (e) {
      _loginSubject.sink.addError(ApiResponse.error(e.toString()));
      throw Exception(e.toString());
    }
  }

  void dispose() {
    _loginSubject.close();
  }
}
