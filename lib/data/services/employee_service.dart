import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../core/utils/const/firestore.dart';

import '../model/employee/employee.dart';
import '../provider/user_state.dart';

@LazySingleton()
class EmployeeService {
  final UserStateNotifier _userManager;
  final FirebaseFirestore fireStore;

  EmployeeService(this._userManager, this.fireStore);

  CollectionReference<Employee> _membersDbCollection(
          {required String spaceId}) =>
      fireStore
          .collection(FireStoreConst.spacesCollection)
          .doc(spaceId)
          .collection(FireStoreConst.membersCollection)
          .withConverter(
              fromFirestore: Employee.fromFirestore,
              toFirestore: (Employee emp, _) => emp.toJson());

  Stream<List<Employee>> employees(String spaceId) {
    return _membersDbCollection(spaceId: spaceId)
        .snapshots()
        .map((event) => event.docs.map((employee) => employee.data()).toList());
  }

  Future<void> addEmployeeBySpaceId(
      {required Employee employee, required String spaceId}) async {
    final docId = employee.uid;
    await _membersDbCollection(spaceId: spaceId).doc(docId).set(employee);
  }

  Future<Employee?> getEmployeeBySpaceId(
      {required String userId, required String spaceId}) async {
    final data = await _membersDbCollection(spaceId: spaceId).doc(userId).get();
    return data.data();
  }

  Future<List<Employee>> getEmployees() async {
    final data =
        await _membersDbCollection(spaceId: _userManager.currentSpaceId!).get();
    return data.docs.map((employee) => employee.data()).toList();
  }

  Future<Employee?> getEmployee(String id) async {
    final data =
        await _membersDbCollection(spaceId: _userManager.currentSpaceId!)
            .doc(id)
            .get();
    return data.data();
  }

  Future<bool> hasUser(String email) async {
    final data =
        await _membersDbCollection(spaceId: _userManager.currentSpaceId!)
            .where(FireStoreConst.email, isEqualTo: email)
            .count()
            .get();
    return data.count != null? data.count! > 0: false;
  }

  Future<void> updateEmployeeDetails({required Employee employee}) async {
    await _membersDbCollection(spaceId: _userManager.currentSpaceId!)
        .doc(employee.uid)
        .set(employee)
        .onError((error, stackTrace) => throw Exception(error.toString()));
  }

  Future<void> changeAccountStatus(
      {required String id, required EmployeeStatus status}) async {
    _membersDbCollection(spaceId: _userManager.currentSpaceId!)
        .doc(id)
        .update({'status': status.value});
  }
}
