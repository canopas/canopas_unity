import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../core/utils/const/firestore.dart';
import '../../model/employee/employee.dart';

@Singleton()
class AuthService {
  final _db =
      FirebaseFirestore.instance.collection(FirestoreConst.userCollection);

  void updateUserData(Employee user, Session? session) async {
    DocumentReference ref = _db.doc(user.id);

    if (session != null) {
      ref
          .collection(FirestoreConst.session)
          .doc(FirestoreConst.session)
          .set(session.sessionToJson());

      ref.update(user.employeeToJson());
    }
  }

  Future<Employee?> getUserData(String email) async {
    final employeeDbCollection = _db
        .where(FirestoreConst.email, isEqualTo: email)
        .limit(1)
        .withConverter(
            fromFirestore: Employee.fromFirestore,
            toFirestore: (Employee emp, _) => emp.employeeToJson());
    Employee? employee;

    final data = await employeeDbCollection.get();
    if (data.docs.isEmpty) {
      employee = null;
    } else {
      employee = data.docs[0].data();
    }
    return employee;
  }
}