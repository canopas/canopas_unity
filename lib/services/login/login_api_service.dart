import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/services/login/login_service.dart';
import 'package:projectunity/user/user_preference.dart';
import 'package:projectunity/utils/constant.dart';
import 'package:projectunity/utils/data_exception.dart';

@Injectable()
class LoginApiService {
  final UserPreference _userPreference;
  final Dio _dio;
  final LoginService _loginService;

  LoginApiService(this._userPreference, this._dio, this._loginService);

  Future login(String googleIdToken, String email) async {
    Map<String, dynamic> data =
        await _loginService.getLoginData(googleIdToken, email);
    try {
      Response response = await _dio.post(
        loginWithGoogleApi,
        data: data,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> employeeData = response.data;
        String employee = jsonEncode(employeeData);
        _userPreference.updateCurrentUser(employee);

        String? accessToken = response.headers.value(kAccessToken);
        _userPreference.setAccessToken(accessToken);

        String? refreshToken = response.headers.value(kRefreshToken);
        _userPreference.setRefreshToken(refreshToken);
      } else {
        throw DataException(response.data.toString());
      }
    } on DioError catch (error) {
      throw DataException(error.message);
    }
  }
}
