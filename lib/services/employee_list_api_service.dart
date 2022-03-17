import 'package:dio/dio.dart';
import 'package:projectunity/model/employee.dart';
import 'package:projectunity/utils/constant.dart';
import 'package:projectunity/utils/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeListApiService {
  final Dio _dio = getIt<Dio>();

  Future<List<Employee>> getEmployeeListFromAPI() async {
    await getIt.isReady<SharedPreferences>();
    final pref = getIt<SharedPreferences>();
    String? accessToken = pref.getString(kAccessToken);

    try {
      Response response = await _dio.get(getEmployeeListApi,
          options: Options(headers: {kAccessToken: accessToken}));
      if (response.statusCode == 200) {
        List<dynamic> parsedData = response.data;
        List<Employee> userList =
            parsedData.map((user) => Employee.fromJson(user)).toList();
        return userList;
      } else {
        throw Exception(
            '${response.statusCode}  : ${response.data.toString()}');
      }
    } catch (error) {
      throw Exception('Error to get employee list ' + error.toString());
    }
  }
}
