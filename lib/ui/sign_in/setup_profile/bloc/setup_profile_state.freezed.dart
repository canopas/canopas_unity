// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setup_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SetupProfileState {

 String get name; String get email; bool get nameError; bool get emailError; bool get buttonEnabled; bool get isSubmitting; bool get isSuccess; String? get error;
/// Create a copy of SetupProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetupProfileStateCopyWith<SetupProfileState> get copyWith => _$SetupProfileStateCopyWithImpl<SetupProfileState>(this as SetupProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupProfileState&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.nameError, nameError) || other.nameError == nameError)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.buttonEnabled, buttonEnabled) || other.buttonEnabled == buttonEnabled)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,name,email,nameError,emailError,buttonEnabled,isSubmitting,isSuccess,error);

@override
String toString() {
  return 'SetupProfileState(name: $name, email: $email, nameError: $nameError, emailError: $emailError, buttonEnabled: $buttonEnabled, isSubmitting: $isSubmitting, isSuccess: $isSuccess, error: $error)';
}


}

/// @nodoc
abstract mixin class $SetupProfileStateCopyWith<$Res>  {
  factory $SetupProfileStateCopyWith(SetupProfileState value, $Res Function(SetupProfileState) _then) = _$SetupProfileStateCopyWithImpl;
@useResult
$Res call({
 String name, String email, bool nameError, bool emailError, bool buttonEnabled, bool isSubmitting, bool isSuccess, String? error
});




}
/// @nodoc
class _$SetupProfileStateCopyWithImpl<$Res>
    implements $SetupProfileStateCopyWith<$Res> {
  _$SetupProfileStateCopyWithImpl(this._self, this._then);

  final SetupProfileState _self;
  final $Res Function(SetupProfileState) _then;

/// Create a copy of SetupProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? email = null,Object? nameError = null,Object? emailError = null,Object? buttonEnabled = null,Object? isSubmitting = null,Object? isSuccess = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,nameError: null == nameError ? _self.nameError : nameError // ignore: cast_nullable_to_non_nullable
as bool,emailError: null == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as bool,buttonEnabled: null == buttonEnabled ? _self.buttonEnabled : buttonEnabled // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SetupProfileState].
extension SetupProfileStatePatterns on SetupProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetupProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetupProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetupProfileState value)  $default,){
final _that = this;
switch (_that) {
case _SetupProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetupProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _SetupProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String email,  bool nameError,  bool emailError,  bool buttonEnabled,  bool isSubmitting,  bool isSuccess,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetupProfileState() when $default != null:
return $default(_that.name,_that.email,_that.nameError,_that.emailError,_that.buttonEnabled,_that.isSubmitting,_that.isSuccess,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String email,  bool nameError,  bool emailError,  bool buttonEnabled,  bool isSubmitting,  bool isSuccess,  String? error)  $default,) {final _that = this;
switch (_that) {
case _SetupProfileState():
return $default(_that.name,_that.email,_that.nameError,_that.emailError,_that.buttonEnabled,_that.isSubmitting,_that.isSuccess,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String email,  bool nameError,  bool emailError,  bool buttonEnabled,  bool isSubmitting,  bool isSuccess,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _SetupProfileState() when $default != null:
return $default(_that.name,_that.email,_that.nameError,_that.emailError,_that.buttonEnabled,_that.isSubmitting,_that.isSuccess,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _SetupProfileState implements SetupProfileState {
  const _SetupProfileState({this.name = "", this.email = "", this.nameError = false, this.emailError = false, this.buttonEnabled = false, this.isSubmitting = false, this.isSuccess = false, this.error});
  

@override@JsonKey() final  String name;
@override@JsonKey() final  String email;
@override@JsonKey() final  bool nameError;
@override@JsonKey() final  bool emailError;
@override@JsonKey() final  bool buttonEnabled;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool isSuccess;
@override final  String? error;

/// Create a copy of SetupProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetupProfileStateCopyWith<_SetupProfileState> get copyWith => __$SetupProfileStateCopyWithImpl<_SetupProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetupProfileState&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.nameError, nameError) || other.nameError == nameError)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.buttonEnabled, buttonEnabled) || other.buttonEnabled == buttonEnabled)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,name,email,nameError,emailError,buttonEnabled,isSubmitting,isSuccess,error);

@override
String toString() {
  return 'SetupProfileState(name: $name, email: $email, nameError: $nameError, emailError: $emailError, buttonEnabled: $buttonEnabled, isSubmitting: $isSubmitting, isSuccess: $isSuccess, error: $error)';
}


}

/// @nodoc
abstract mixin class _$SetupProfileStateCopyWith<$Res> implements $SetupProfileStateCopyWith<$Res> {
  factory _$SetupProfileStateCopyWith(_SetupProfileState value, $Res Function(_SetupProfileState) _then) = __$SetupProfileStateCopyWithImpl;
@override @useResult
$Res call({
 String name, String email, bool nameError, bool emailError, bool buttonEnabled, bool isSubmitting, bool isSuccess, String? error
});




}
/// @nodoc
class __$SetupProfileStateCopyWithImpl<$Res>
    implements _$SetupProfileStateCopyWith<$Res> {
  __$SetupProfileStateCopyWithImpl(this._self, this._then);

  final _SetupProfileState _self;
  final $Res Function(_SetupProfileState) _then;

/// Create a copy of SetupProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,Object? nameError = null,Object? emailError = null,Object? buttonEnabled = null,Object? isSubmitting = null,Object? isSuccess = null,Object? error = freezed,}) {
  return _then(_SetupProfileState(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,nameError: null == nameError ? _self.nameError : nameError // ignore: cast_nullable_to_non_nullable
as bool,emailError: null == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as bool,buttonEnabled: null == buttonEnabled ? _self.buttonEnabled : buttonEnabled // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
