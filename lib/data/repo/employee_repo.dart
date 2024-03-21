import 'dart:async';
import 'package:collection/collection.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:rxdart/rxdart.dart';
import '../model/employee/employee.dart';
import '../services/employee_service.dart';

@LazySingleton()
class EmployeeRepo {
  final EmployeeService _employeeService;
  final UserStateNotifier _userStateNotifier;
  final FirebaseCrashlytics _crashlytics;
  late BehaviorSubject<List<Employee>> _employeeController;
  StreamSubscription<List<Employee>>? _employeeStreamSubscription;

  EmployeeRepo(
      this._employeeService, this._userStateNotifier, this._crashlytics) {
    _employeeController = BehaviorSubject<List<Employee>>();
    _employeeStreamSubscription = _employeeService
        .employees(_userStateNotifier.currentSpaceId!)
        .listen((value) {
      _employeeController.add(value);
    }, onError: (e, s) async {
      _employeeController.addError(e);
      await _crashlytics.recordError(e, s);
    });
  }

  Stream<Employee?> memberDetails(String uid) => _employeeController.stream
      .asyncMap((members) => members.firstWhereOrNull((e) => e.uid == uid));

  Stream<List<Employee>> get employees =>
      _employeeController.stream.asBroadcastStream();

  List<Employee> get allEmployees {
    if (_employeeController.hasValue) {
      return _employeeController.value;
    }
    return [];
  }

  Stream<List<Employee>> get activeEmployees =>
      _employeeController.stream.asyncMap((employees) => employees
          .where((employee) => employee.status == EmployeeStatus.active)
          .toList());

  Future<void> reset() async {
    _employeeController = BehaviorSubject<List<Employee>>();
    await _employeeStreamSubscription?.cancel();
    _employeeStreamSubscription = _employeeService
        .employees(_userStateNotifier.currentSpaceId!)
        .listen((value) {
      _employeeController.add(value);
    }, onError: (e, s) async {
      _employeeController.addError(e);
      await _crashlytics.recordError(e, s);
    });
  }

  @disposeMethod
  Future<void> dispose() async {
    await _employeeController.close();
    await _employeeStreamSubscription?.cancel();
  }
}
