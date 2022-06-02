import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../model/Employee/employee.dart';

@Singleton()
class EmployeeService {
  final _db = FirebaseFirestore.instance.collection("users");

  Future<List<Employee>> getEmployees() async {
    final data = await _db
        .withConverter(
            fromFirestore: Employee.fromFirestore,
            toFirestore: (Employee emp, _) => emp.employeeToJson())
        .get();

    return data.docs.map((doc) => doc.data()).toList();
  }

  Future<Employee?> getEmployee(String id) async {
    final data = await _db
        .doc(id)
        .withConverter(
            fromFirestore: Employee.fromFirestore,
            toFirestore: (Employee emp, _) => emp.employeeToJson())
        .get();

    return data.data();
  }
}
