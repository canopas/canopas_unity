import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:oauth2/oauth2.dart';
import 'package:projectunity/data/services/account_service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../model/account/account.dart';
import '../state_manager/auth/desktop/desktop_auth_manager.dart';

@LazySingleton()
class AuthService {
  final DesktopAuthManager _desktopAuthManager;
  final FirebaseFirestore fireStore;
  final AccountService _accountService;

  final firebase_auth.FirebaseAuth firebaseAuth;

  AuthService(this._desktopAuthManager, this.fireStore, this.firebaseAuth,
      this._accountService);

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

  Future<Account?> signInWithApple() async {
    final rawNounce = generateNonce();
    final nounce = sha256ofString(rawNounce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName
    ], nonce: nounce);

    final oAuthCredential = firebase_auth.OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken, rawNonce: rawNounce);

    final name = appleCredential.givenName;
    final authUser = await signInWithCredentials(oAuthCredential);
    if (name != null) {
      return await setUser(authUser, name: name);
    }
    return await setUser(authUser);
  }

  Future<Account?> setUser(firebase_auth.User? authUser, {String? name}) async {
    if (authUser != null) {
      final Account user = await _accountService.getUser(authUser, name: name);
      return user;
    }
    return null;
  }

  String generateNounce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
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
