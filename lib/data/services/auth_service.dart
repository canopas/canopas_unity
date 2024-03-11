import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:oauth2/oauth2.dart';
import 'package:projectunity/data/services/account_service.dart';
import '../state_manager/auth/desktop/desktop_auth_manager.dart';

@LazySingleton()
class AuthService {
  final DesktopAuthManager _desktopAuthManager;
  final FirebaseFirestore fireStore;

  final firebase_auth.FirebaseAuth firebaseAuth;

  AuthService(this._desktopAuthManager, this.fireStore, this.firebaseAuth);

  Future<firebase_auth.User?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    firebase_auth.User? user;
    if (kIsWeb) {
      try {
        firebase_auth.GoogleAuthProvider googleAuthProvider =
            firebase_auth.GoogleAuthProvider();
        firebaseAuth.setPersistence(firebase_auth.Persistence.LOCAL);
        firebase_auth.UserCredential credential =
            await firebaseAuth.signInWithPopup(googleAuthProvider);
        user = credential.user;
        return user;
      } catch (e) {
        rethrow;
      }
    } else if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      try {
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

          user = await signInWithCredentials(credential);
          await googleSignIn.signOut();
        }
      } catch (e) {
        rethrow;
      }
    } else if (defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux) {
      try {
        Credentials credentials = await _desktopAuthManager.login();

        firebase_auth.AuthCredential authCredential =
            firebase_auth.GoogleAuthProvider.credential(
                idToken: credentials.idToken,
                accessToken: credentials.accessToken);

        user = await signInWithCredentials(authCredential);

        await _desktopAuthManager.signOutFromGoogle(credentials.accessToken);
      } on Exception {
        rethrow;
      }
    }
    return user;
  }

  Future<firebase_auth.User?> signInWithCredentials(
    firebase_auth.AuthCredential authCredential,
  ) async {
    firebase_auth.User? user;
    try {
      final firebase_auth.UserCredential userCredential =
          await firebaseAuth.signInWithCredential(authCredential);
      user = userCredential.user;
    } on Exception {
      rethrow;
    }
    return user;
  }

  Future<firebase_auth.User?> signInWithApple() async {
    final firebase_auth.UserCredential? credential;

    firebase_auth.AppleAuthProvider appleProvider =
        firebase_auth.AppleAuthProvider();
    if (kIsWeb) {
      credential = await firebase_auth.FirebaseAuth.instance
          .signInWithPopup(appleProvider);
    } else {
      credential = await firebase_auth.FirebaseAuth.instance
          .signInWithProvider(appleProvider);
    }

    return credential.user;
  }

  Future<bool> signOut() async {
    try {
      await firebaseAuth.signOut();
      return true;
    } on Exception {
      return false;
    }
  }
}
