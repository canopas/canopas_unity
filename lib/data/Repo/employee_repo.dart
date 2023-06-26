import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../model/employee/employee.dart';
import '../services/employee_service.dart';

@Singleton()
class EmployeeRepo {
  final EmployeeService _employeeService;
  final _employeeController = BehaviorSubject<List<Employee>>();
  late final StreamSubscription<List<Employee>>? _employeeStreamSubscription;

  EmployeeRepo(this._employeeService) {
    _employeeStreamSubscription = _employeeService.employees.listen((value) {
      _employeeController.add(value);
    }, onDone: () {
      print('Emloyee subscription done');
    });
  }

  Stream<List<Employee>> get employees =>
      _employeeController.stream.asBroadcastStream(onCancel: (_) {
        if (_employeeStreamSubscription == null) {
          return;
        }
        _employeeStreamSubscription!.cancel();
        print('employee streamsubscription is cancelled');
        print(_employeeStreamSubscription!.isPaused);
      }, onListen: (_) {
        if (_employeeStreamSubscription != null) {
          if (_employeeStreamSubscription!.isPaused) {
            _employeeStreamSubscription!.resume();
            print('employee streamsubscription is resumed');
          }
        }
        print(_employeeStreamSubscription.toString());
      });

  Future<void> disconnect() async {
    await _employeeStreamSubscription?.cancel();
  }

  @disposeMethod
  Future<void> dispose() async {
    await _employeeController.close();
    print('EmployeeRepo closed');
  }
}
