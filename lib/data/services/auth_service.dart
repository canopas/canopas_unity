import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:oauth2/oauth2.dart';
import '../core/exception/custom_exception.dart';
import '../core/exception/error_const.dart';
import '../core/utils/const/firestore.dart';
import '../model/user/user.dart';
import '../stateManager/auth/desktop/desktop_auth_manager.dart';

///Its provide authentication services like google sign in, google sign out
///and provide authenticated user from firebase fire-store database.
@Singleton()
class AuthService {
  final DesktopAuthManager _desktopAuthManager;

  AuthService(this._desktopAuthManager);

  final _usersDb = FirebaseFirestore.instance
      .collection(FireStoreConst.accountCollection)
      .withConverter(
          fromFirestore: User.fromFireStore,
          toFirestore: (User user, _) => user.toJson());

  ///Return user data from database by auth user data. its create new user in database if user is not exist in database.
  Future<User> getUser(firebase_auth.User authData) async {
    final userData = await _usersDb
        .where(FireStoreConst.uid, isEqualTo: authData.uid)
        .limit(1)
        .get();
    final User user;
    if (userData.docs.isEmpty) {
      await _usersDb
          .doc(authData.uid)
          .set(User(uid: authData.uid, email: authData.email!));
      final newUserData = await _usersDb
          .where(FireStoreConst.uid, isEqualTo: authData.uid)
          .limit(1)
          .get();
      user = newUserData.docs[0].data();
    } else {
      user = userData.docs[0].data();
    }
    return user;
  }

  ///Return user auth data using firebase auth services and google sign in services.
  Future<firebase_auth.User?> signInWithGoogle() async {
    firebase_auth.User? user;
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      Credentials credentials = await _desktopAuthManager.login();

      firebase_auth.AuthCredential authCredential =
          firebase_auth.GoogleAuthProvider.credential(
              idToken: credentials.idToken,
              accessToken: credentials.accessToken);

      user = await _signInWithCredentials(authCredential);

      await _desktopAuthManager.signOutFromGoogle(credentials.accessToken);
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final firebase_auth.AuthCredential credential =
            firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        user = await _signInWithCredentials(credential);
      }
      await googleSignIn.signOut();
    }
    return user;
  }

  Future<firebase_auth.User?> _signInWithCredentials(
      firebase_auth.AuthCredential authCredential) async {
    final firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? user;
    try {
      final firebase_auth.UserCredential userCredential =
          await auth.signInWithCredential(authCredential);
      user = userCredential.user;
    } on firebase_auth.FirebaseAuthException {
      throw CustomException(firesbaseAuthError);
    }
    return user;
  }

  ///Sign out user form firebase auth services
  Future<bool> signOutWithGoogle() async {
    try {
      await firebase_auth.FirebaseAuth.instance.signOut();
      return true;
    } on Exception {
      return false;
    }
  }
}
