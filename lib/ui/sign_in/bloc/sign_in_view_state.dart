import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:freezed_annotation/freezed_annotation.dart';

part "sign_in_view_state.freezed.dart";

@freezed
abstract class SignInState with _$SignInState {
  const factory SignInState({
    @Default(false) bool appleSignInAvailable,
    @Default(false) bool googleSignInLoading,
    @Default(false) bool appleSignInLoading,
    @Default(false) bool signInSuccess,
    firebase_auth.User? firebaseAuthUser,
    String? error,
  }) = _SignInState;
}
