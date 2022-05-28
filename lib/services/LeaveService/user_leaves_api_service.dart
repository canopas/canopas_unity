import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/model/Leave/leave_detail.dart';
import 'package:projectunity/rest/data_exception.dart';
import 'package:projectunity/user/user_preference.dart';

import '../../utils/Constant/api_constant.dart';

@Singleton()
class UserLeavesApiService {
  final UserPreference _userPreference;
  final Dio _dio;

  UserLeavesApiService(this._dio, this._userPreference);

  Future<LeaveDetail> getUserLeaves() async {
    String? accessToken = _userPreference.getAccessToken();
    Response response = await _dio.get(getLeavesOfLoggedInUserApi);
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        LeaveDetail leaveDetail = LeaveDetail.fromJson(data);
        return leaveDetail;
      } else {
        throw DataException('Try again');
      }
    } on DioError catch (error) {
      throw DataException(error.message);
    } on Exception catch (error) {
      throw DataException(error.toString());
    }
  }
}
