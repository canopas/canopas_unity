import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/utils/const/role.dart';
import '../../model/employee/employee.dart';

@Singleton()
class EmployeeService {
  final _userDbCollection = FirebaseFirestore.instance
      .collection("users")
      .withConverter(
          fromFirestore: Employee.fromFirestore,
          toFirestore: (Employee emp, _) => emp.employeeToJson());

  Stream<List<Employee>> getEmployeesStream() {
    BehaviorSubject<List<Employee>> _employees =
        BehaviorSubject<List<Employee>>();
    _userDbCollection
        .where('role_type', isNotEqualTo: kRoleTypeAdmin)
        .snapshots()
        .listen((event) {
      List<Employee> employeeList =
          event.docs.map((employee) => employee.data()).toList();
      _employees.sink.add(employeeList);
    });
    return _employees;
  }

  Future<List<Employee>> getEmployees() async {
    final data = await _userDbCollection
        .where('role_type', isNotEqualTo: kRoleTypeAdmin)
        .get();
    return data.docs.map((employee) => employee.data()).toList();
  }

  Future<Employee?> getEmployee(String id) async {
    final data = await _userDbCollection.doc(id).get();
    return data.data();
  }

  Future<bool> hasUser(String email) async {
    final _employeeDbCollection =
        _userDbCollection.where('email', isEqualTo: email).limit(1);
    final data = await _employeeDbCollection.get();
    return data.docs.isNotEmpty;
  }

  Future<void> addEmployee(Employee employee) async {
    final docId = employee.id;
    await _userDbCollection.doc(docId).set(employee);
  }

  Future<void> deleteEmployee(String id) async {
    await _userDbCollection.doc(id).delete();
  }
}
