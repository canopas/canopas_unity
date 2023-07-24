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

  final BehaviorSubject<List<Employee>> _employeeController =
      BehaviorSubject<List<Employee>>();

  StreamSubscription<List<Employee>>? _employeeStreamSubscription;

  EmployeeRepo(this._employeeService, this._userStateNotifier);

  Stream<Employee?> memberDetails(String uid) {
    return _employeeController.stream
        .map((members) => members.firstWhereOrNull((e) => e.uid == uid));
  }

  Stream<Employee?> getCurrentUser(
      {required String spaceID, required String uid}) {
    print('employeeRepo is called');
    return _employeeService.getCurrentUser(spaceId: spaceID, id: uid);
  }

  Stream<List<Employee>> get employees =>
      _employeeController.stream.asBroadcastStream();

  Stream<List<Employee>> get activeEmployees =>
      _employeeController.stream.asyncMap((employees) => employees
          .where((employee) => employee.status == EmployeeStatus.active)
          .toList());

  Future<void> reset() async {
    if (_employeeStreamSubscription != null) {
      await cancelEmpStreamSubscription();
    }
    _employeeStreamSubscription = _employeeService
        .employees(_userStateNotifier.currentSpaceId!)
        .listen((value) {
      _employeeController.add(value);
      print('${_employeeController.value.length}');
    }, onError: (e, s) async {
      _employeeController.addError(e);
      await FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  Future<void> cancelEmpStreamSubscription() async {
    await _employeeStreamSubscription?.cancel();
  }

  @disposeMethod
  Future<void> dispose() async {
    await cancelEmpStreamSubscription();
    await _employeeController.close();
  }
}
