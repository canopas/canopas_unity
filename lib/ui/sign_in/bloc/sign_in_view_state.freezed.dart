// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SignInState {
  dynamic get appleSignInAvailable => throw _privateConstructorUsedError;
  dynamic get googleSignInLoading => throw _privateConstructorUsedError;
  dynamic get appleSignInLoading => throw _privateConstructorUsedError;
  dynamic get signInSuccess => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignInStateCopyWith<SignInState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignInStateCopyWith<$Res> {
  factory $SignInStateCopyWith(
          SignInState value, $Res Function(SignInState) then) =
      _$SignInStateCopyWithImpl<$Res, SignInState>;
  @useResult
  $Res call(
      {dynamic appleSignInAvailable,
      dynamic googleSignInLoading,
      dynamic appleSignInLoading,
      dynamic signInSuccess,
      String? error});
}

/// @nodoc
class _$SignInStateCopyWithImpl<$Res, $Val extends SignInState>
    implements $SignInStateCopyWith<$Res> {
  _$SignInStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appleSignInAvailable = freezed,
    Object? googleSignInLoading = freezed,
    Object? appleSignInLoading = freezed,
    Object? signInSuccess = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      appleSignInAvailable: freezed == appleSignInAvailable
          ? _value.appleSignInAvailable
          : appleSignInAvailable // ignore: cast_nullable_to_non_nullable
              as dynamic,
      googleSignInLoading: freezed == googleSignInLoading
          ? _value.googleSignInLoading
          : googleSignInLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      appleSignInLoading: freezed == appleSignInLoading
          ? _value.appleSignInLoading
          : appleSignInLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      signInSuccess: freezed == signInSuccess
          ? _value.signInSuccess
          : signInSuccess // ignore: cast_nullable_to_non_nullable
              as dynamic,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignInStateImplCopyWith<$Res>
    implements $SignInStateCopyWith<$Res> {
  factory _$$SignInStateImplCopyWith(
          _$SignInStateImpl value, $Res Function(_$SignInStateImpl) then) =
      __$$SignInStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic appleSignInAvailable,
      dynamic googleSignInLoading,
      dynamic appleSignInLoading,
      dynamic signInSuccess,
      String? error});
}

/// @nodoc
class __$$SignInStateImplCopyWithImpl<$Res>
    extends _$SignInStateCopyWithImpl<$Res, _$SignInStateImpl>
    implements _$$SignInStateImplCopyWith<$Res> {
  __$$SignInStateImplCopyWithImpl(
      _$SignInStateImpl _value, $Res Function(_$SignInStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appleSignInAvailable = freezed,
    Object? googleSignInLoading = freezed,
    Object? appleSignInLoading = freezed,
    Object? signInSuccess = freezed,
    Object? error = freezed,
  }) {
    return _then(_$SignInStateImpl(
      appleSignInAvailable: freezed == appleSignInAvailable
          ? _value.appleSignInAvailable!
          : appleSignInAvailable,
      googleSignInLoading: freezed == googleSignInLoading
          ? _value.googleSignInLoading!
          : googleSignInLoading,
      appleSignInLoading: freezed == appleSignInLoading
          ? _value.appleSignInLoading!
          : appleSignInLoading,
      signInSuccess:
          freezed == signInSuccess ? _value.signInSuccess! : signInSuccess,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SignInStateImpl implements _SignInState {
  const _$SignInStateImpl(
      {this.appleSignInAvailable = false,
      this.googleSignInLoading = false,
      this.appleSignInLoading = false,
      this.signInSuccess = false,
      this.error});

  @override
  @JsonKey()
  final dynamic appleSignInAvailable;
  @override
  @JsonKey()
  final dynamic googleSignInLoading;
  @override
  @JsonKey()
  final dynamic appleSignInLoading;
  @override
  @JsonKey()
  final dynamic signInSuccess;
  @override
  final String? error;

  @override
  String toString() {
    return 'SignInState(appleSignInAvailable: $appleSignInAvailable, googleSignInLoading: $googleSignInLoading, appleSignInLoading: $appleSignInLoading, signInSuccess: $signInSuccess, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignInStateImpl &&
            const DeepCollectionEquality()
                .equals(other.appleSignInAvailable, appleSignInAvailable) &&
            const DeepCollectionEquality()
                .equals(other.googleSignInLoading, googleSignInLoading) &&
            const DeepCollectionEquality()
                .equals(other.appleSignInLoading, appleSignInLoading) &&
            const DeepCollectionEquality()
                .equals(other.signInSuccess, signInSuccess) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(appleSignInAvailable),
      const DeepCollectionEquality().hash(googleSignInLoading),
      const DeepCollectionEquality().hash(appleSignInLoading),
      const DeepCollectionEquality().hash(signInSuccess),
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignInStateImplCopyWith<_$SignInStateImpl> get copyWith =>
      __$$SignInStateImplCopyWithImpl<_$SignInStateImpl>(this, _$identity);
}

abstract class _SignInState implements SignInState {
  const factory _SignInState(
      {final dynamic appleSignInAvailable,
      final dynamic googleSignInLoading,
      final dynamic appleSignInLoading,
      final dynamic signInSuccess,
      final String? error}) = _$SignInStateImpl;

  @override
  dynamic get appleSignInAvailable;
  @override
  dynamic get googleSignInLoading;
  @override
  dynamic get appleSignInLoading;
  @override
  dynamic get signInSuccess;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$SignInStateImplCopyWith<_$SignInStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
