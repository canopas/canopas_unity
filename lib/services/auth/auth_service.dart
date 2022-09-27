import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../model/employee/employee.dart';

@Singleton()
class AuthService {
  final _db = FirebaseFirestore.instance.collection("users");

  void updateUserData(Employee user, Session? session) async {
    DocumentReference ref = _db.doc(user.id);

    if (session != null) {
      ref.collection('session').doc().set(session.sessionToJson());

      ref.update(user.employeeToJson());
    }
  }

  Future<Employee> getUserData(String email) async {
    final _employeeDbCollection = _db
        .where('email', isEqualTo: email)
        .limit(1)
        .withConverter(
            fromFirestore: Employee.fromFirestore,
            toFirestore: (Employee emp, _) => emp.employeeToJson());
    Employee? employee;

    final data = await _employeeDbCollection.get();
    if (data.docs.isEmpty) {
      employee = null;
    }
    employee = data.docs[0].data();

    return employee;
  }
}