import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/model/employee.dart';
import 'package:projectunity/rest/data_exception.dart';
import 'package:projectunity/user/user_preference.dart';
import 'package:projectunity/utils/constant.dart';


@Injectable()
class EmployeeListApiService {
  final Dio _dio;
  final UserPreference _userPreference;

  EmployeeListApiService(this._dio, this._userPreference);

  Future<List<Employee>> getEmployeeListFromAPI() async {
    String? accessToken = _userPreference.getAccessToken();

    try {
      Response response = await _dio.get(getEmployeeListApi,
          options: Options(headers: {kAccessToken: accessToken}));
      if (response.statusCode == 200) {
        List<dynamic> parsedData = response.data;

        List<Employee> userList =
            parsedData.map((user) => Employee.fromJson(user)).toList();
        return userList;
      } else {
        throw DataException('Unable to load data');
      }
    } on DioError catch (error) {
      throw DataException(error.message);
    }
  }
}
