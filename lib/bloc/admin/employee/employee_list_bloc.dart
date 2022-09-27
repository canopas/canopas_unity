import 'package:injectable/injectable.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../../services/employee/employee_service.dart';

@Singleton()
class EmployeeListBloc {
  final EmployeeService _employeeService;

  EmployeeListBloc(this._employeeService);

  final BehaviorSubject<ApiResponse<List<Employee>>> _employeeList =
      BehaviorSubject<ApiResponse<List<Employee>>>();

  BehaviorSubject<ApiResponse<List<Employee>>> get allEmployee => _employeeList;

 Future<void> getEmployeeList() async {
    _employeeList.sink.add(const ApiResponse.loading());
    try {
      List<Employee> list = await _employeeService.getEmployees();
      _employeeList.sink.add(ApiResponse.completed(data: list));
    } on Exception catch (error) {
      _employeeList.sink
          .add(const ApiResponse.error(error: firestoreFetchDataError));
    }
  }

  void dispose() {
    _employeeList.close();
  }
}
