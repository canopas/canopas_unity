import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../core/utils/const/firestore.dart';
import '../event_bus/events.dart';
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
            .limit(1)
            .get();
    return data.docs.isNotEmpty;
  }

  Future<void> addEmployee(Employee employee) async {
    final docId = employee.uid;
    await _membersDbCollection(spaceId: _userManager.currentSpaceId!)
        .doc(docId)
        .set(employee);
  }

  Future<void> updateEmployeeDetails({required Employee employee}) async {
    await _membersDbCollection(spaceId: _userManager.currentSpaceId!)
        .doc(employee.uid)
        .set(employee)
        .onError((error, stackTrace) => throw Exception(error.toString()));
  }

  Future<void> changeEmployeeRoleType(String id, Role role) async {
    Map<String, int> data = {FireStoreConst.roleType: role.value};
    await _membersDbCollection(spaceId: _userManager.currentSpaceId!)
        .doc(id)
        .update(data)
        .then((value) => eventBus.fire(EmployeeListUpdateEvent()));
  }

  Future<void> deleteEmployee(String id) async {
    DocumentReference employeeDocRef =
        _membersDbCollection(spaceId: _userManager.currentSpaceId!).doc(id);
    await employeeDocRef
        .delete()
        .then((value) => eventBus.fire(EmployeeListUpdateEvent()));
  }

  Future<void> changeAccountStatus(
      {required String id, required EmployeeStatus status}) async {
    _membersDbCollection(spaceId: _userManager.currentSpaceId!)
        .doc(id)
        .update({'status': status.value});
  }
}
