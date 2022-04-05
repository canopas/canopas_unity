import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:projectunity/model/employee.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/services/network_repository.dart';
import 'package:rxdart/rxdart.dart';


@Singleton()
class EmployeeDetailBloc {
  final NetworkRepository _networkRepository;

  EmployeeDetailBloc(this._networkRepository);

  final PublishSubject<ApiResponse<Employee>> _employee =
      PublishSubject<ApiResponse<Employee>>();

  PublishSubject<ApiResponse<Employee>> get employeeDetail => _employee;

  Future getEmployeeDetailByID(int id) async {
    _employee.sink.add(const ApiResponse.loading());
    try {
      Employee employee =
          await _networkRepository.getEmployeeDetailFromRepo(id);
      _employee.sink.add(ApiResponse.completed(data: employee));
    } on Exception catch (error) {
      _employee.sink.add(ApiResponse.error(message: error.toString()));
    }
  }

  void dispose() {
    _employee.close();
  }
}
