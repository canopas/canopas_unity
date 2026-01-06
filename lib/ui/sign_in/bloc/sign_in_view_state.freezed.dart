// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignInState {

 bool get appleSignInAvailable; bool get googleSignInLoading; bool get appleSignInLoading; bool get signInSuccess; firebase_auth.User? get firebaseAuthUser; String? get error;
/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInStateCopyWith<SignInState> get copyWith => _$SignInStateCopyWithImpl<SignInState>(this as SignInState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInState&&(identical(other.appleSignInAvailable, appleSignInAvailable) || other.appleSignInAvailable == appleSignInAvailable)&&(identical(other.googleSignInLoading, googleSignInLoading) || other.googleSignInLoading == googleSignInLoading)&&(identical(other.appleSignInLoading, appleSignInLoading) || other.appleSignInLoading == appleSignInLoading)&&(identical(other.signInSuccess, signInSuccess) || other.signInSuccess == signInSuccess)&&(identical(other.firebaseAuthUser, firebaseAuthUser) || other.firebaseAuthUser == firebaseAuthUser)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,appleSignInAvailable,googleSignInLoading,appleSignInLoading,signInSuccess,firebaseAuthUser,error);

@override
String toString() {
  return 'SignInState(appleSignInAvailable: $appleSignInAvailable, googleSignInLoading: $googleSignInLoading, appleSignInLoading: $appleSignInLoading, signInSuccess: $signInSuccess, firebaseAuthUser: $firebaseAuthUser, error: $error)';
}


}

/// @nodoc
abstract mixin class $SignInStateCopyWith<$Res>  {
  factory $SignInStateCopyWith(SignInState value, $Res Function(SignInState) _then) = _$SignInStateCopyWithImpl;
@useResult
$Res call({
 bool appleSignInAvailable, bool googleSignInLoading, bool appleSignInLoading, bool signInSuccess, firebase_auth.User? firebaseAuthUser, String? error
});




}
/// @nodoc
class _$SignInStateCopyWithImpl<$Res>
    implements $SignInStateCopyWith<$Res> {
  _$SignInStateCopyWithImpl(this._self, this._then);

  final SignInState _self;
  final $Res Function(SignInState) _then;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appleSignInAvailable = null,Object? googleSignInLoading = null,Object? appleSignInLoading = null,Object? signInSuccess = null,Object? firebaseAuthUser = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
appleSignInAvailable: null == appleSignInAvailable ? _self.appleSignInAvailable : appleSignInAvailable // ignore: cast_nullable_to_non_nullable
as bool,googleSignInLoading: null == googleSignInLoading ? _self.googleSignInLoading : googleSignInLoading // ignore: cast_nullable_to_non_nullable
as bool,appleSignInLoading: null == appleSignInLoading ? _self.appleSignInLoading : appleSignInLoading // ignore: cast_nullable_to_non_nullable
as bool,signInSuccess: null == signInSuccess ? _self.signInSuccess : signInSuccess // ignore: cast_nullable_to_non_nullable
as bool,firebaseAuthUser: freezed == firebaseAuthUser ? _self.firebaseAuthUser : firebaseAuthUser // ignore: cast_nullable_to_non_nullable
as firebase_auth.User?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SignInState].
extension SignInStatePatterns on SignInState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignInState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignInState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignInState value)  $default,){
final _that = this;
switch (_that) {
case _SignInState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignInState value)?  $default,){
final _that = this;
switch (_that) {
case _SignInState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool appleSignInAvailable,  bool googleSignInLoading,  bool appleSignInLoading,  bool signInSuccess,  firebase_auth.User? firebaseAuthUser,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignInState() when $default != null:
return $default(_that.appleSignInAvailable,_that.googleSignInLoading,_that.appleSignInLoading,_that.signInSuccess,_that.firebaseAuthUser,_that.error);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool appleSignInAvailable,  bool googleSignInLoading,  bool appleSignInLoading,  bool signInSuccess,  firebase_auth.User? firebaseAuthUser,  String? error)  $default,) {final _that = this;
switch (_that) {
case _SignInState():
return $default(_that.appleSignInAvailable,_that.googleSignInLoading,_that.appleSignInLoading,_that.signInSuccess,_that.firebaseAuthUser,_that.error);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool appleSignInAvailable,  bool googleSignInLoading,  bool appleSignInLoading,  bool signInSuccess,  firebase_auth.User? firebaseAuthUser,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _SignInState() when $default != null:
return $default(_that.appleSignInAvailable,_that.googleSignInLoading,_that.appleSignInLoading,_that.signInSuccess,_that.firebaseAuthUser,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _SignInState implements SignInState {
  const _SignInState({this.appleSignInAvailable = false, this.googleSignInLoading = false, this.appleSignInLoading = false, this.signInSuccess = false, this.firebaseAuthUser, this.error});
  

@override@JsonKey() final  bool appleSignInAvailable;
@override@JsonKey() final  bool googleSignInLoading;
@override@JsonKey() final  bool appleSignInLoading;
@override@JsonKey() final  bool signInSuccess;
@override final  firebase_auth.User? firebaseAuthUser;
@override final  String? error;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInStateCopyWith<_SignInState> get copyWith => __$SignInStateCopyWithImpl<_SignInState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInState&&(identical(other.appleSignInAvailable, appleSignInAvailable) || other.appleSignInAvailable == appleSignInAvailable)&&(identical(other.googleSignInLoading, googleSignInLoading) || other.googleSignInLoading == googleSignInLoading)&&(identical(other.appleSignInLoading, appleSignInLoading) || other.appleSignInLoading == appleSignInLoading)&&(identical(other.signInSuccess, signInSuccess) || other.signInSuccess == signInSuccess)&&(identical(other.firebaseAuthUser, firebaseAuthUser) || other.firebaseAuthUser == firebaseAuthUser)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,appleSignInAvailable,googleSignInLoading,appleSignInLoading,signInSuccess,firebaseAuthUser,error);

@override
String toString() {
  return 'SignInState(appleSignInAvailable: $appleSignInAvailable, googleSignInLoading: $googleSignInLoading, appleSignInLoading: $appleSignInLoading, signInSuccess: $signInSuccess, firebaseAuthUser: $firebaseAuthUser, error: $error)';
}


}

/// @nodoc
abstract mixin class _$SignInStateCopyWith<$Res> implements $SignInStateCopyWith<$Res> {
  factory _$SignInStateCopyWith(_SignInState value, $Res Function(_SignInState) _then) = __$SignInStateCopyWithImpl;
@override @useResult
$Res call({
 bool appleSignInAvailable, bool googleSignInLoading, bool appleSignInLoading, bool signInSuccess, firebase_auth.User? firebaseAuthUser, String? error
});




}
/// @nodoc
class __$SignInStateCopyWithImpl<$Res>
    implements _$SignInStateCopyWith<$Res> {
  __$SignInStateCopyWithImpl(this._self, this._then);

  final _SignInState _self;
  final $Res Function(_SignInState) _then;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appleSignInAvailable = null,Object? googleSignInLoading = null,Object? appleSignInLoading = null,Object? signInSuccess = null,Object? firebaseAuthUser = freezed,Object? error = freezed,}) {
  return _then(_SignInState(
appleSignInAvailable: null == appleSignInAvailable ? _self.appleSignInAvailable : appleSignInAvailable // ignore: cast_nullable_to_non_nullable
as bool,googleSignInLoading: null == googleSignInLoading ? _self.googleSignInLoading : googleSignInLoading // ignore: cast_nullable_to_non_nullable
as bool,appleSignInLoading: null == appleSignInLoading ? _self.appleSignInLoading : appleSignInLoading // ignore: cast_nullable_to_non_nullable
as bool,signInSuccess: null == signInSuccess ? _self.signInSuccess : signInSuccess // ignore: cast_nullable_to_non_nullable
as bool,firebaseAuthUser: freezed == firebaseAuthUser ? _self.firebaseAuthUser : firebaseAuthUser // ignore: cast_nullable_to_non_nullable
as firebase_auth.User?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
