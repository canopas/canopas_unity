import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/model/leave/leave_detail.dart';
import 'package:projectunity/rest/data_exception.dart';
import 'package:projectunity/user/user_preference.dart';

import '../../utils/const/api_constant.dart';

@Singleton()
class TeamLeavesApiService {
  final Dio _dio;
  final UserPreference _userPreference;

  TeamLeavesApiService(this._dio, this._userPreference);

  Future<LeaveDetail> getTeamLeaves() async {
    String? accessToken = _userPreference.getAccessToken();
    Response response = await _dio.get(getLeavesOfTeamApi);
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
