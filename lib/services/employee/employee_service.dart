import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../model/employee/employee.dart';

@Singleton()
final userCollection = FirebaseFirestore.instance
    .collection("users")
    .withConverter(
        fromFirestore: Employee.fromFirestore,
        toFirestore: (Employee emp, _) => emp.employeeToJson());

class EmployeeService {
  Future<List<Employee>> getEmployees() async {
    final data = await userCollection.get();
    return data.docs.map((doc) => doc.data()).toList();
  }

  Future<Employee?> getEmployee(String id) async {
    final data = await userCollection.doc(id).get();
    return data.data();
  }

  Future<void> addEmployee(Employee employee) async {
    await userCollection.add(employee).then(
        (value) => userCollection.doc(value.id).update({'uid': value.id}));
  }
}
