import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/user/user_preference.dart';
import 'package:projectunity/utils/constant.dart';
import 'package:projectunity/utils/data_exception.dart';


@Singleton()
class ApplyForLeaveApiService {
  final Dio _dio;
  final UserPreference _userPreference;

  ApplyForLeaveApiService(this._dio,this._userPreference);

  Future applyForLeave() async {
    String? accessToken = _userPreference.getAccessToken();
    Map<String, dynamic> data = {
    "start_date": 1549756800 ,
    "end_date" : 1549756800 ,
    "total_leaves": 2.0 ,
    "reason": "Out of city" ,
    "emergency_contact_person": 1,
    }
    ;
    Response response = await _dio.post(applyForLeaveApi,
        data: data,
    options: Options(
        headers: {kAccessToken: accessToken}
    ));
    try {
      if (response.statusCode == 200) {
        String responseData = response.data;
        print(response.statusCode.toString());
        print(responseData.toString());
      } else {
        throw DataException('Try again later');
      }
    } on DioError catch (error) {
      print('error');
      throw DataException(error.message);
    }
  }
}
