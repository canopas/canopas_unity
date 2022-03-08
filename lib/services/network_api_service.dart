import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:projectunity/LoginRequestDataProvider/device_info_provider.dart';
import 'package:projectunity/model/login_request.dart';
import 'package:projectunity/utils/constant.dart';
import 'package:projectunity/utils/login_interceptor.dart';
import 'package:projectunity/utils/service_locator.dart';
import 'package:projectunity/services/base_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkApiService extends BaseApiService {
  final Dio dio = getIt<Dio>();

  @override
  Future login(String googleIdToken, String email) async {
    LoginRequestDataProvider loginRequestDataProvider =
        getIt<LoginRequestDataProvider>();
    LoginRequest loginRequest = await loginRequestDataProvider
        .getLoginRequestData(googleIdToken, email);
    await getIt.isReady<SharedPreferences>();
    final pref = getIt<SharedPreferences>();
    Map<String, dynamic> data = loginRequest.loginRequestToJson(loginRequest);

    try {
      Response response = await dio.post(
       '/api/v1/login-with-google',
        data: data,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> parsedData = jsonDecode(jsonEncode(response.data));
        var userData = parsedData.toString();
        await pref.setString(kUserData, userData);

        List<dynamic> accessToken =
            jsonDecode(jsonEncode(response.headers[kAccessToken]));
        var accessTokenData = accessToken.toString();
        await pref.setString(kAccessToken, accessTokenData);

        List<dynamic> refreshToken =
            jsonDecode(jsonEncode(response.headers[kRefreshToken]));
        var refreshTokenData = refreshToken.toString();
        await pref.setString(kRefreshToken, refreshTokenData);

        //   User user = User.fromJson(parsedData);

      } else {
        throw Exception(response.data.toString());
      }
    } catch (e) {
      throw Exception('Error to get user account: $e');
    }
    return;
  }
}
