// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'celebrations_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CelebrationsState {

 Status get status; bool get showAllBdays; bool get showAllAnniversaries; List<Event> get birthdays; List<Event> get anniversaries; String? get error;
/// Create a copy of CelebrationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CelebrationsStateCopyWith<CelebrationsState> get copyWith => _$CelebrationsStateCopyWithImpl<CelebrationsState>(this as CelebrationsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CelebrationsState&&(identical(other.status, status) || other.status == status)&&(identical(other.showAllBdays, showAllBdays) || other.showAllBdays == showAllBdays)&&(identical(other.showAllAnniversaries, showAllAnniversaries) || other.showAllAnniversaries == showAllAnniversaries)&&const DeepCollectionEquality().equals(other.birthdays, birthdays)&&const DeepCollectionEquality().equals(other.anniversaries, anniversaries)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,showAllBdays,showAllAnniversaries,const DeepCollectionEquality().hash(birthdays),const DeepCollectionEquality().hash(anniversaries),error);

@override
String toString() {
  return 'CelebrationsState(status: $status, showAllBdays: $showAllBdays, showAllAnniversaries: $showAllAnniversaries, birthdays: $birthdays, anniversaries: $anniversaries, error: $error)';
}


}

/// @nodoc
abstract mixin class $CelebrationsStateCopyWith<$Res>  {
  factory $CelebrationsStateCopyWith(CelebrationsState value, $Res Function(CelebrationsState) _then) = _$CelebrationsStateCopyWithImpl;
@useResult
$Res call({
 Status status, bool showAllBdays, bool showAllAnniversaries, List<Event> birthdays, List<Event> anniversaries, String? error
});




}
/// @nodoc
class _$CelebrationsStateCopyWithImpl<$Res>
    implements $CelebrationsStateCopyWith<$Res> {
  _$CelebrationsStateCopyWithImpl(this._self, this._then);

  final CelebrationsState _self;
  final $Res Function(CelebrationsState) _then;

/// Create a copy of CelebrationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? showAllBdays = null,Object? showAllAnniversaries = null,Object? birthdays = null,Object? anniversaries = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,showAllBdays: null == showAllBdays ? _self.showAllBdays : showAllBdays // ignore: cast_nullable_to_non_nullable
as bool,showAllAnniversaries: null == showAllAnniversaries ? _self.showAllAnniversaries : showAllAnniversaries // ignore: cast_nullable_to_non_nullable
as bool,birthdays: null == birthdays ? _self.birthdays : birthdays // ignore: cast_nullable_to_non_nullable
as List<Event>,anniversaries: null == anniversaries ? _self.anniversaries : anniversaries // ignore: cast_nullable_to_non_nullable
as List<Event>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CelebrationsState].
extension CelebrationsStatePatterns on CelebrationsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CelebrationsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CelebrationsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CelebrationsState value)  $default,){
final _that = this;
switch (_that) {
case _CelebrationsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CelebrationsState value)?  $default,){
final _that = this;
switch (_that) {
case _CelebrationsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Status status,  bool showAllBdays,  bool showAllAnniversaries,  List<Event> birthdays,  List<Event> anniversaries,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CelebrationsState() when $default != null:
return $default(_that.status,_that.showAllBdays,_that.showAllAnniversaries,_that.birthdays,_that.anniversaries,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Status status,  bool showAllBdays,  bool showAllAnniversaries,  List<Event> birthdays,  List<Event> anniversaries,  String? error)  $default,) {final _that = this;
switch (_that) {
case _CelebrationsState():
return $default(_that.status,_that.showAllBdays,_that.showAllAnniversaries,_that.birthdays,_that.anniversaries,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Status status,  bool showAllBdays,  bool showAllAnniversaries,  List<Event> birthdays,  List<Event> anniversaries,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _CelebrationsState() when $default != null:
return $default(_that.status,_that.showAllBdays,_that.showAllAnniversaries,_that.birthdays,_that.anniversaries,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _CelebrationsState implements CelebrationsState {
  const _CelebrationsState({this.status = Status.initial, this.showAllBdays = false, this.showAllAnniversaries = false, final  List<Event> birthdays = const [], final  List<Event> anniversaries = const [], this.error}): _birthdays = birthdays,_anniversaries = anniversaries;
  

@override@JsonKey() final  Status status;
@override@JsonKey() final  bool showAllBdays;
@override@JsonKey() final  bool showAllAnniversaries;
 final  List<Event> _birthdays;
@override@JsonKey() List<Event> get birthdays {
  if (_birthdays is EqualUnmodifiableListView) return _birthdays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_birthdays);
}

 final  List<Event> _anniversaries;
@override@JsonKey() List<Event> get anniversaries {
  if (_anniversaries is EqualUnmodifiableListView) return _anniversaries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_anniversaries);
}

@override final  String? error;

/// Create a copy of CelebrationsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CelebrationsStateCopyWith<_CelebrationsState> get copyWith => __$CelebrationsStateCopyWithImpl<_CelebrationsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CelebrationsState&&(identical(other.status, status) || other.status == status)&&(identical(other.showAllBdays, showAllBdays) || other.showAllBdays == showAllBdays)&&(identical(other.showAllAnniversaries, showAllAnniversaries) || other.showAllAnniversaries == showAllAnniversaries)&&const DeepCollectionEquality().equals(other._birthdays, _birthdays)&&const DeepCollectionEquality().equals(other._anniversaries, _anniversaries)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,showAllBdays,showAllAnniversaries,const DeepCollectionEquality().hash(_birthdays),const DeepCollectionEquality().hash(_anniversaries),error);

@override
String toString() {
  return 'CelebrationsState(status: $status, showAllBdays: $showAllBdays, showAllAnniversaries: $showAllAnniversaries, birthdays: $birthdays, anniversaries: $anniversaries, error: $error)';
}


}

/// @nodoc
abstract mixin class _$CelebrationsStateCopyWith<$Res> implements $CelebrationsStateCopyWith<$Res> {
  factory _$CelebrationsStateCopyWith(_CelebrationsState value, $Res Function(_CelebrationsState) _then) = __$CelebrationsStateCopyWithImpl;
@override @useResult
$Res call({
 Status status, bool showAllBdays, bool showAllAnniversaries, List<Event> birthdays, List<Event> anniversaries, String? error
});




}
/// @nodoc
class __$CelebrationsStateCopyWithImpl<$Res>
    implements _$CelebrationsStateCopyWith<$Res> {
  __$CelebrationsStateCopyWithImpl(this._self, this._then);

  final _CelebrationsState _self;
  final $Res Function(_CelebrationsState) _then;

/// Create a copy of CelebrationsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? showAllBdays = null,Object? showAllAnniversaries = null,Object? birthdays = null,Object? anniversaries = null,Object? error = freezed,}) {
  return _then(_CelebrationsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,showAllBdays: null == showAllBdays ? _self.showAllBdays : showAllBdays // ignore: cast_nullable_to_non_nullable
as bool,showAllAnniversaries: null == showAllAnniversaries ? _self.showAllAnniversaries : showAllAnniversaries // ignore: cast_nullable_to_non_nullable
as bool,birthdays: null == birthdays ? _self._birthdays : birthdays // ignore: cast_nullable_to_non_nullable
as List<Event>,anniversaries: null == anniversaries ? _self._anniversaries : anniversaries // ignore: cast_nullable_to_non_nullable
as List<Event>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
