import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../model/employee/employee.dart';

@Singleton()
class EmployeeService {
  final _userDbCollection = FirebaseFirestore.instance
      .collection("users")
      .withConverter(
          fromFirestore: Employee.fromFirestore,
          toFirestore: (Employee emp, _) => emp.employeeToJson());

  Future<List<Employee>> getEmployees() async {
    final data = await _userDbCollection.get();
    return data.docs.map((doc) => doc.data()).toList();
  }

  Future<Employee?> getEmployee(String id) async {
    final data = await _userDbCollection.doc(id).get();
    return data.data();
  }

  Future<void> addEmployee(Employee employee) async {
    final docId = employee.id;
    await _userDbCollection.doc(docId).set(employee);
  }
}
