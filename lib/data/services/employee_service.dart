import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../core/utils/const/firestore.dart';
import '../event_bus/events.dart';
import '../model/employee/employee.dart';
import '../provider/user_data.dart';

@LazySingleton()
class EmployeeService {
  final UserManager _userManager;
  final FirebaseFirestore fireStore;

  EmployeeService(this._userManager,this.fireStore);

  CollectionReference<Employee> _membersDbCollection() =>
      fireStore
          .collection(FireStoreConst.spacesCollection)
          .doc(_userManager.currentSpaceId)
          .collection(FireStoreConst.membersCollection)
          .withConverter(
              fromFirestore: Employee.fromFirestore,
              toFirestore: (Employee emp, _) => emp.toJson());

  Future<void> addEmployeeBySpaceId(
      {required Employee employee, required String spaceId}) async {
    final docId = employee.uid;
    await _membersDbCollection().doc(docId).set(employee);
  }

  Future<Employee?> getEmployeeBySpaceId(
      {required String userId, required String spaceId}) async {
    final data = await _membersDbCollection().doc(userId).get();
    return data.data();
  }

  Future<List<Employee>> getEmployees() async {
    final data =
        await _membersDbCollection().get();
    return data.docs.map((employee) => employee.data()).toList();
  }

  Future<Employee?> getEmployee(String id) async {
    final data =
        await _membersDbCollection()
            .doc(id)
            .get();
    return data.data();
  }

  Future<bool> hasUser(String email) async {
    final employeeDbCollection =
        _membersDbCollection()
            .where(FireStoreConst.email, isEqualTo: email)
            .limit(1);
    final data = await employeeDbCollection.get();
    return data.docs.isNotEmpty;
  }

  Future<void> addEmployee(Employee employee) async {
    final docId = employee.uid;
    await _membersDbCollection()
        .doc(docId)
        .set(employee);
  }

  Future<void> updateEmployeeDetails({required Employee employee}) async {
    await _membersDbCollection()
        .doc(employee.uid)
        .update(employee.toJson())
        .onError((error, stackTrace) => throw Exception(error.toString()));
  }


  Future<void> changeEmployeeRoleType(String id, int roleType) async {
    Map<String, int> data = {FireStoreConst.roleType: roleType};
    await _membersDbCollection()
        .doc(id)
        .update(data)
        .then((value) => eventBus.fire(EmployeeListUpdateEvent()));
  }

  Future<void> deleteEmployee(String id) async {
    DocumentReference employeeDocRef =
        _membersDbCollection().doc(id);
    employeeDocRef
        .collection(FireStoreConst.session)
        .doc(FireStoreConst.session)
        .delete()
        .then((value) async {
      await employeeDocRef.delete();
    }).then((value) => eventBus.fire(EmployeeListUpdateEvent()));
  }
}
