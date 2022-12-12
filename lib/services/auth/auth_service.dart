import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../core/utils/const/firestore.dart';
import '../../exception/custom_exception.dart';
import '../../exception/error_const.dart';
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

      ref.update(user.toJson());
    }
  }

  Future<Employee?> getUserData(String email) async {
    final employeeDbCollection = _db
        .where(FirestoreConst.email, isEqualTo: email)
        .limit(1)
        .withConverter(
            fromFirestore: Employee.fromFirestore,
            toFirestore: (Employee emp, _) => emp.toJson());
    Employee? employee;

    final data = await employeeDbCollection.get();
    if (data.docs.isEmpty) {
      employee = null;
    } else {
      employee = data.docs[0].data();
    }
    return employee;
  }

  Future<User?> signInWithGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseAuthException {
        throw CustomException(firesbaseAuthError);
      }
    }
    return user;
  }

  Future<bool> signOutWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      final FirebaseAuth auth = FirebaseAuth.instance;
      await googleSignIn.signOut();
      await auth.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

}