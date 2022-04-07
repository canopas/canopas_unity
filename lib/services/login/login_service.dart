import 'package:injectable/injectable.dart';
import 'package:projectunity/services/login/login_request_provider.dart';

@Injectable()
class LoginService {
  final LoginRequestDataProvider _loginRequestDataProvider;

  LoginService(this._loginRequestDataProvider);

  Future<Map<String, dynamic>> getLoginData(
      String googleIdToken, String email) async {
    final loginData = await _loginRequestDataProvider.getLoginRequestData(
        googleIdToken, email);
    Map<String, dynamic> data = loginData.toJson(loginData);
    return data;
  }
}
