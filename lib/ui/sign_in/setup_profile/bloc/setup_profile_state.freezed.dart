// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setup_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SetupProfileState {
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  bool get nameError => throw _privateConstructorUsedError;
  bool get emailError => throw _privateConstructorUsedError;
  bool get buttonEnabled => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SetupProfileStateCopyWith<SetupProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SetupProfileStateCopyWith<$Res> {
  factory $SetupProfileStateCopyWith(
          SetupProfileState value, $Res Function(SetupProfileState) then) =
      _$SetupProfileStateCopyWithImpl<$Res, SetupProfileState>;
  @useResult
  $Res call(
      {String name,
      String email,
      bool nameError,
      bool emailError,
      bool buttonEnabled,
      bool isSubmitting,
      bool isSuccess,
      String? error});
}

/// @nodoc
class _$SetupProfileStateCopyWithImpl<$Res, $Val extends SetupProfileState>
    implements $SetupProfileStateCopyWith<$Res> {
  _$SetupProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? nameError = null,
    Object? emailError = null,
    Object? buttonEnabled = null,
    Object? isSubmitting = null,
    Object? isSuccess = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      nameError: null == nameError
          ? _value.nameError
          : nameError // ignore: cast_nullable_to_non_nullable
              as bool,
      emailError: null == emailError
          ? _value.emailError
          : emailError // ignore: cast_nullable_to_non_nullable
              as bool,
      buttonEnabled: null == buttonEnabled
          ? _value.buttonEnabled
          : buttonEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SetupProfileStateImplCopyWith<$Res>
    implements $SetupProfileStateCopyWith<$Res> {
  factory _$$SetupProfileStateImplCopyWith(_$SetupProfileStateImpl value,
          $Res Function(_$SetupProfileStateImpl) then) =
      __$$SetupProfileStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String email,
      bool nameError,
      bool emailError,
      bool buttonEnabled,
      bool isSubmitting,
      bool isSuccess,
      String? error});
}

/// @nodoc
class __$$SetupProfileStateImplCopyWithImpl<$Res>
    extends _$SetupProfileStateCopyWithImpl<$Res, _$SetupProfileStateImpl>
    implements _$$SetupProfileStateImplCopyWith<$Res> {
  __$$SetupProfileStateImplCopyWithImpl(_$SetupProfileStateImpl _value,
      $Res Function(_$SetupProfileStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? nameError = null,
    Object? emailError = null,
    Object? buttonEnabled = null,
    Object? isSubmitting = null,
    Object? isSuccess = null,
    Object? error = freezed,
  }) {
    return _then(_$SetupProfileStateImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      nameError: null == nameError
          ? _value.nameError
          : nameError // ignore: cast_nullable_to_non_nullable
              as bool,
      emailError: null == emailError
          ? _value.emailError
          : emailError // ignore: cast_nullable_to_non_nullable
              as bool,
      buttonEnabled: null == buttonEnabled
          ? _value.buttonEnabled
          : buttonEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SetupProfileStateImpl implements _SetupProfileState {
  const _$SetupProfileStateImpl(
      {this.name = "",
      this.email = "",
      this.nameError = false,
      this.emailError = false,
      this.buttonEnabled = false,
      this.isSubmitting = false,
      this.isSuccess = false,
      this.error});

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final bool nameError;
  @override
  @JsonKey()
  final bool emailError;
  @override
  @JsonKey()
  final bool buttonEnabled;
  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  @JsonKey()
  final bool isSuccess;
  @override
  final String? error;

  @override
  String toString() {
    return 'SetupProfileState(name: $name, email: $email, nameError: $nameError, emailError: $emailError, buttonEnabled: $buttonEnabled, isSubmitting: $isSubmitting, isSuccess: $isSuccess, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetupProfileStateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.nameError, nameError) ||
                other.nameError == nameError) &&
            (identical(other.emailError, emailError) ||
                other.emailError == emailError) &&
            (identical(other.buttonEnabled, buttonEnabled) ||
                other.buttonEnabled == buttonEnabled) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, email, nameError,
      emailError, buttonEnabled, isSubmitting, isSuccess, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetupProfileStateImplCopyWith<_$SetupProfileStateImpl> get copyWith =>
      __$$SetupProfileStateImplCopyWithImpl<_$SetupProfileStateImpl>(
          this, _$identity);
}

abstract class _SetupProfileState implements SetupProfileState {
  const factory _SetupProfileState(
      {final String name,
      final String email,
      final bool nameError,
      final bool emailError,
      final bool buttonEnabled,
      final bool isSubmitting,
      final bool isSuccess,
      final String? error}) = _$SetupProfileStateImpl;

  @override
  String get name;
  @override
  String get email;
  @override
  bool get nameError;
  @override
  bool get emailError;
  @override
  bool get buttonEnabled;
  @override
  bool get isSubmitting;
  @override
  bool get isSuccess;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$SetupProfileStateImplCopyWith<_$SetupProfileStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
