import 'package:dio/dio.dart';
import 'package:projectunity/LoginRequestDataProvider/device_info_provider.dart';
import 'package:projectunity/model/login_request.dart';
import 'package:projectunity/utils/constant.dart';
import 'package:projectunity/utils/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginApiService {
  final Dio _dio = getIt<Dio>();

  Future<String> login(String googleIdToken, String email) async {
    LoginRequestDataProvider loginRequestDataProvider =
        getIt<LoginRequestDataProvider>();
    LoginRequest loginRequest = await loginRequestDataProvider
        .getLoginRequestData(googleIdToken, email);
    await getIt.isReady<SharedPreferences>();
    final pref = getIt<SharedPreferences>();
    Map<String, dynamic> data = loginRequest.loginRequestToJson(loginRequest);

    try {
      Response response = await _dio.post(
        loginWithGoogleApi,
        data: data,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> employeeData = response.data;
        String decodedEmployeeData = employeeData.toString();
        pref.setString(kEmployeeData, decodedEmployeeData);
        var data = decodedEmployeeData;

        String? accessToken = response.headers.value(kAccessToken);
        pref.setString(kAccessToken, accessToken!);

        String? refreshToken = response.headers.value(kRefreshToken);
        pref.setString(kRefreshToken, refreshToken!);
        return data;
      } else {
        throw Exception(response.data.toString());
      }
    } catch (e) {
      throw Exception('Error to get user account: $e');
    }
  }
}
