import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/model/Leave/leave_request_data.dart';
import 'package:projectunity/rest/data_exception.dart';
import 'package:projectunity/user/user_preference.dart';

import '../../utils/Constant/api_constant.dart';
import '../../utils/Constant/token_constant.dart';

@Singleton()
class ApplyForLeaveApiService {
  final Dio _dio;
  final UserPreference _userPreference;

  ApplyForLeaveApiService(this._dio, this._userPreference);

  Future applyForLeave(LeaveRequestData leaveRequestData) async {
    String? accessToken = _userPreference.getAccessToken();
    var data = leaveRequestData.toJson(leaveRequestData);

    Response response = await _dio.post(applyForLeaveApi,
        data: data, options: Options(headers: {kAccessToken: accessToken}));
    try {
      if (response.statusCode == 200) {
        String responseData = response.data;
      } else {
        throw DataException('Try again later');
      }
    } on DioError catch (error) {
      throw DataException(error.message);
    }
  }
}
