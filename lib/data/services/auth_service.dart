import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:oauth2/oauth2.dart';
import '../core/exception/custom_exception.dart';
import '../core/exception/error_const.dart';
import '../core/utils/const/firestore.dart';
import '../model/employee/employee.dart';
import '../pref/user_preference.dart';
import '../stateManager/auth/desktop/desktop_auth_manager.dart';

@Singleton()
class AuthService {
  final _db =
      FirebaseFirestore.instance.collection(FirestoreConst.userCollection);
  final DesktopAuthManager _desktopAuthManager;
  final UserPreference _userPreference;

  AuthService(this._desktopAuthManager, this._userPreference);

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
    User? user;
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      Credentials credentials = await _desktopAuthManager.login();
      _userPreference.setToken(credentials.accessToken);
      AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: credentials.idToken, accessToken: credentials.accessToken);
      user = await _signInWithCredentials(authCredential);
    } else {
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
        user = await _signInWithCredentials(credential);
      }
    }
    return user;
  }

  Future<User?> _signInWithCredentials(AuthCredential authCredential) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      final UserCredential userCredential =
          await auth.signInWithCredential(authCredential);
      user = userCredential.user;
    } on FirebaseAuthException {
      throw CustomException(firesbaseAuthError);
    }
    return user;
  }

  Future<bool> signOutWithGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
        String token = _userPreference.getToken()!;
        await _desktopAuthManager.signOutFromGoogle(token);
      } else {
        GoogleSignIn googleSignIn = GoogleSignIn();
        await googleSignIn.signOut();
      }
      await auth.signOut();
      return true;
    } on Exception {
      return false;
    }
  }
}
