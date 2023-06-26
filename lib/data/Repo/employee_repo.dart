import 'dart:async';

import 'package:injectable/injectable.dart';

import '../model/employee/employee.dart';
import '../services/employee_service.dart';

@Singleton()
class EmployeeRepo{
  final EmployeeService _employeeService;
  final _employeeController = StreamController<List<Employee>>();
  late final StreamSubscription<List<Employee>>? _employeeStreamSubscription;

  EmployeeRepo(this._employeeService){
    _employeeStreamSubscription = _employeeService.employees.listen((value) {
      _employeeController.add(value);
    });
  }

  Stream<List<Employee>> get employees => _employeeController.stream.asBroadcastStream();


  Future<void> disconnect() async {
    await _employeeStreamSubscription?.cancel();
    await _employeeController.close();
  }
}