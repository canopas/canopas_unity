import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../model/employee/employee.dart';

@Singleton()
class EmployeeService {
  final _collection = FirebaseFirestore.instance
      .collection("users")
      .withConverter(
          fromFirestore: Employee.fromFirestore,
          toFirestore: (Employee emp, _) => emp.employeeToJson());

  Future<List<Employee>> getEmployees() async {
    final data = await _collection.get();
    return data.docs.map((doc) => doc.data()).toList();
  }

  Future<Employee?> getEmployee(String id) async {
    final data = await _collection.doc(id).get();
    return data.data();
  }

  Future<void> addEmployee(Employee employee) async {
    await _collection.add(employee);
  }
}
