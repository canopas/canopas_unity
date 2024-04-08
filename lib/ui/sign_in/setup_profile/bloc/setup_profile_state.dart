import 'package:freezed_annotation/freezed_annotation.dart';

part 'setup_profile_state.freezed.dart';

@freezed
class SetupProfileState with _$SetupProfileState {
  const factory SetupProfileState({
    @Default("") String name,
    @Default("") String email,
    @Default(false) bool nameError,
    @Default(false) bool emailError,
    @Default(false) bool buttonEnabled,
    @Default(false) bool isSubmitting,
    @Default(false) bool isSuccess,
    String? error,
  }) = _SetupProfileState;
}
