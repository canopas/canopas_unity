import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../model/employee/employee.dart';

@Singleton()
class AuthService {
  final _db = FirebaseFirestore.instance.collection("users");

  void updateUserData(Employee user, Session? session) async {
    DocumentReference ref = _db.doc(user.id);

    if (session != null) {
      ref.collection('session').doc().set(session.sessionToJson());
    }
    ref
        .update(user.employeeToJson())
        .then((value) => {print("Successfully updated")})
        .catchError((error) => {print("Error while updating: $error")});
  }

  Future getUserData(String email) async {
    final ref = _db.where('email', isEqualTo: email).limit(1).withConverter(
        fromFirestore: Employee.fromFirestore,
        toFirestore: (Employee emp, _) => emp.employeeToJson());

    Employee? employee;
    await ref.get().then(
      (res) {
        if (res.docs.isEmpty) {
          print("No User found");
          employee = null;
        }
        print("Successfully completed");
        employee = res.docs[0].data();
      },
      onError: (e) {
        print("Error completing: $e");
        employee = null;
      },
    );

    print("Block completed");
    return employee;
  }
}
