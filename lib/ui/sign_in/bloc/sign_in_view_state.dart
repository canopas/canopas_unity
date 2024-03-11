import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "sign_in_view_state.freezed.dart";

@freezed
class SignInState with _$SignInState {
  const factory SignInState(
      {@Default(false) appleSignInAvailable,
      @Default(false) googleSignInLoading,
      @Default(false) appleSignInLoading,
      @Default(false) signInSuccess,
      String? error}) = _SignInState;
}
