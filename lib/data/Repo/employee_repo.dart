import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:rxdart/rxdart.dart';
import '../model/employee/employee.dart';
import '../services/employee_service.dart';

@LazySingleton()
class EmployeeRepo {
  final EmployeeService _employeeService;
  final UserStateNotifier _userStateNotifier;
  final BehaviorSubject<List<Employee>> _employeeController =
      BehaviorSubject<List<Employee>>();
  StreamSubscription<List<Employee>>? _employeeStreamSubscription;

  EmployeeRepo(this._employeeService, this._userStateNotifier) {
    _employeeStreamSubscription =
        _employeeService.employees(_userStateNotifier.currentSpaceId!).listen(
      (value) {
        _employeeController.add(value);
      },
    );
  }

  Stream<List<Employee>> get employees =>
      _employeeController.stream.asBroadcastStream();

  Future<void> reset() async {
    await _employeeStreamSubscription?.cancel();
    _employeeStreamSubscription =
        _employeeService.employees(_userStateNotifier.currentSpaceId!).listen(
      (value) {
        _employeeController.add(value);
      },
    );
  }

  Future<void> cancel() async {
    await _employeeStreamSubscription?.cancel();
  }

  @disposeMethod
  Future<void> dispose() async {
    await _employeeStreamSubscription?.cancel();
    await _employeeController.close();
  }
}
