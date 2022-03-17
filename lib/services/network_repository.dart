import 'package:projectunity/model/employee.dart';
import 'package:projectunity/services/employee_list_api_service.dart';
import 'package:projectunity/services/login_api_service.dart';
import 'package:projectunity/utils/service_locator.dart';

class NetworkRepository {
  final _loginApiService = getIt<LoginApiService>();
  final _employeeListApiService = getIt<EmployeeListApiService>();

  Future<String> googleLogin(String googleIdToken, String email) {
    return _loginApiService.login(googleIdToken, email);
  }

  Future<List<Employee>> getEmployeeListFromRepo() {
    return _employeeListApiService.getEmployeeListFromAPI();
  }
}
