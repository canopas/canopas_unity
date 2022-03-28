import 'package:injectable/injectable.dart';
import 'package:projectunity/model/employee.dart';
import 'package:projectunity/services/employee_list_api_service.dart';
import 'package:projectunity/services/login/login_api_service.dart';

@Injectable()
class NetworkRepository {
  final LoginApiService _loginApiService;
  final EmployeeListApiService _employeeListApiService;

  NetworkRepository(this._loginApiService, this._employeeListApiService);

  Future googleLogin(String googleIdToken, String email) {
    return _loginApiService.login(googleIdToken, email);
  }

  Future<List<Employee>> getEmployeeListFromRepo() {
    return _employeeListApiService.getEmployeeListFromAPI();
  }
}
