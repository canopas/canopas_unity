import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/rest/data_exception.dart';
import 'package:projectunity/user/user_preference.dart';

import '../utils/Constant/api_constant.dart';
import '../utils/Constant/token_constant.dart';

@Singleton()
class AuthManager {
  final UserPreference _userPreference;
  final Dio _dio;

  AuthManager(this._userPreference, this._dio);

  Future login(Map<String, dynamic> data) async {
    try {
      Response response = await _dio.post(loginWithGoogleApi, data: data);
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
