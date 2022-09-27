import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/services/employee/employee_service.dart';
import 'package:rxdart/rxdart.dart';

import '../../../exception/error_const.dart';

@Singleton()
class EmployeeDetailBloc {
  final EmployeeService _service;

  EmployeeDetailBloc(this._service);

  final BehaviorSubject<ApiResponse<Employee>> _employee =
      BehaviorSubject<ApiResponse<Employee>>();

  BehaviorSubject<ApiResponse<Employee>> get employeeDetail => _employee;

  Future<void> getEmployeeDetailByID(String id) async {
    _employee.sink.add(const ApiResponse.loading());
    try {
      Employee? employee = await _service.getEmployee(id);
      if (employee == null) {
        _employee.sink
            .add(const ApiResponse.error(error: firestoreFetchDataError));
      }
      _employee.sink.add(ApiResponse.completed(data: employee!));
    } on Exception catch (error) {
      _employee.sink.add(ApiResponse.error(error: undefinedError));
    }
  }

  void dispose() {
    _employee.close();
  }
}
