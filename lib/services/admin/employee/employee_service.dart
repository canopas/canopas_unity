import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/utils/const/firestore.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/utils/const/role.dart';
import '../../../model/employee/employee.dart';

@Injectable()
class EmployeeService {
  final _userDbCollection = FirebaseFirestore.instance
      .collection(FirestoreConst.userCollection)
      .withConverter(
          fromFirestore: Employee.fromFirestore,
          toFirestore: (Employee emp, _) => emp.employeeToJson());

  Stream<List<Employee>> getEmployeesStream() {
    BehaviorSubject<List<Employee>> employees =
        BehaviorSubject<List<Employee>>();
    _userDbCollection
        .where(FirestoreConst.roleType, isNotEqualTo: kRoleTypeAdmin)
        .snapshots()
        .listen((event) {
      List<Employee> employeeList =
          event.docs.map((employee) => employee.data()).toList();
      employees.sink.add(employeeList);
    });
    return employees;
  }

  Future<List<Employee>> getEmployees() async {
    final data = await _userDbCollection
        .where(FirestoreConst.roleType, isNotEqualTo: kRoleTypeAdmin)
        .get();
    return data.docs.map((employee) => employee.data()).toList();
  }

  Future<Employee?> getEmployee(String id) async {
    final data = await _userDbCollection.doc(id).get();
    return data.data();
  }

  Future<bool> hasUser(String email) async {
    final employeeDbCollection = _userDbCollection
        .where(FirestoreConst.email, isEqualTo: email)
        .limit(1);
    final data = await employeeDbCollection.get();
    return data.docs.isNotEmpty;
  }

  Future<void> addEmployee(Employee employee) async {
    final docId = employee.id;
    await _userDbCollection.doc(docId).set(employee);
  }

  Future<void> deleteEmployee(String id) async {
    DocumentReference employeeDocRef = _userDbCollection.doc(id);
    employeeDocRef
        .collection(FirestoreConst.session)
        .doc(FirestoreConst.session)
        .delete()
        .then((value) async {
      await employeeDocRef.delete();
    });
  }

}
