import 'package:injectable/injectable.dart';
import 'package:projectunity/model/Employee/employee.dart';
import 'package:projectunity/services/EmployeeApiService/employee_detail_api_service.dart';
import 'package:projectunity/services/EmployeeApiService/employee_list_api_service.dart';
import 'package:projectunity/services/login/login_api_service.dart';

@Injectable()
class NetworkRepository {
  final LoginApiService _loginApiService;
  final EmployeeListApiService _employeeListApiService;
  final EmployeeDetailApiService _employeeDetailByID;

  NetworkRepository(this._loginApiService, this._employeeListApiService,
      this._employeeDetailByID);

  Future googleLogin(String googleIdToken, String email) {
    return _loginApiService.login(googleIdToken, email);
  }

  Future<List<Employee>> getEmployeeListFromRepo() {
    return _employeeListApiService.getEmployeeListFromAPI();
  }

  Future<Employee> getEmployeeDetailFromRepo(int id) {
    return _employeeDetailByID.getEmployeeByID(id);
  }
}
