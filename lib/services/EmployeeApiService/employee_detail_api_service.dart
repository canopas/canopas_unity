import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/model/Employee/employee.dart';
import 'package:projectunity/user/user_preference.dart';
import 'package:projectunity/utils/constant.dart';
import 'package:projectunity/utils/data_exception.dart';

@Injectable()
class EmployeeDetailApiService {
  final Dio _dio;
  final UserPreference _userPreference;

  EmployeeDetailApiService(this._dio, this._userPreference);

  Future<Employee> getEmployeeByID(int employeeID) async {
    String? accessToken = _userPreference.getAccessToken();
    try {
      Response response = await _dio.get(
          getEmployeeByIdApi + employeeID.toString(),
          options: Options(headers: {kAccessToken: accessToken}));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        Employee employee = Employee.fromJson(data);
        return employee;
      } else {
        throw DataException('Unable to load Employee Detail');
      }
    } on DioError catch (error) {
      throw DataException(error.message);
    }
  }
}
