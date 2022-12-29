import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/utils/const/firestore.dart';
import 'package:projectunity/event_bus/events.dart';
import 'package:projectunity/ui/admin/employee/list/bloc/employee_list_event.dart';
import '../../../core/utils/const/role.dart';
import '../../../model/employee/employee.dart';

@Singleton()
class EmployeeService {
  final StreamController<List<Employee>> _employeeStreamController = StreamController();
  late StreamSubscription<List<Employee>> _employeeStreamSubscription;

  EmployeeService() {
    _employeeStreamSubscription = _userDbCollection
        .where(FirestoreConst.roleType, isNotEqualTo: kRoleTypeAdmin).snapshots().map((event) {
      return event.docs.map((employee) => employee.data()).toList();}).listen((event) {
      _employeeStreamController.add(event);
    });
  }

  final _userDbCollection = FirebaseFirestore.instance
      .collection(FirestoreConst.userCollection)
      .withConverter(
          fromFirestore: Employee.fromFirestore,
          toFirestore: (Employee emp, _) => emp.toJson());

  Stream<List<Employee>> get getEmployeeStream =>
      _employeeStreamController.stream;

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

  Future<void> changeEmployeeRoleType(String id,int roleType) async {
    Map<String,int> data = {FirestoreConst.roleType:roleType};
    await _userDbCollection.doc(id).update(data);
  }

  Future<void> deleteEmployee(String id) async {
    DocumentReference employeeDocRef = _userDbCollection.doc(id);
    employeeDocRef
        .collection(FirestoreConst.session)
        .doc(FirestoreConst.session)
        .delete()
        .then((value) async {
      await employeeDocRef.delete();
    }).then((value) => eventBus.fire(EmployeeListUpdateEvent()));
  }

  @disposeMethod
  void dispose() {
    _employeeStreamController.close();
    _employeeStreamSubscription.cancel();
  }
}
