// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'who_is_out_card_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WhoIsOutCardState {

 Status get status; DateTime get selectedDate; DateTime get focusDay; CalendarFormat get calendarFormat; List<LeaveApplication> get allAbsences; List<LeaveApplication>? get selectedDayAbsences; String? get error;
/// Create a copy of WhoIsOutCardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WhoIsOutCardStateCopyWith<WhoIsOutCardState> get copyWith => _$WhoIsOutCardStateCopyWithImpl<WhoIsOutCardState>(this as WhoIsOutCardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WhoIsOutCardState&&(identical(other.status, status) || other.status == status)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.focusDay, focusDay) || other.focusDay == focusDay)&&(identical(other.calendarFormat, calendarFormat) || other.calendarFormat == calendarFormat)&&const DeepCollectionEquality().equals(other.allAbsences, allAbsences)&&const DeepCollectionEquality().equals(other.selectedDayAbsences, selectedDayAbsences)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,selectedDate,focusDay,calendarFormat,const DeepCollectionEquality().hash(allAbsences),const DeepCollectionEquality().hash(selectedDayAbsences),error);

@override
String toString() {
  return 'WhoIsOutCardState(status: $status, selectedDate: $selectedDate, focusDay: $focusDay, calendarFormat: $calendarFormat, allAbsences: $allAbsences, selectedDayAbsences: $selectedDayAbsences, error: $error)';
}


}

/// @nodoc
abstract mixin class $WhoIsOutCardStateCopyWith<$Res>  {
  factory $WhoIsOutCardStateCopyWith(WhoIsOutCardState value, $Res Function(WhoIsOutCardState) _then) = _$WhoIsOutCardStateCopyWithImpl;
@useResult
$Res call({
 Status status, DateTime selectedDate, DateTime focusDay, CalendarFormat calendarFormat, List<LeaveApplication> allAbsences, List<LeaveApplication>? selectedDayAbsences, String? error
});




}
/// @nodoc
class _$WhoIsOutCardStateCopyWithImpl<$Res>
    implements $WhoIsOutCardStateCopyWith<$Res> {
  _$WhoIsOutCardStateCopyWithImpl(this._self, this._then);

  final WhoIsOutCardState _self;
  final $Res Function(WhoIsOutCardState) _then;

/// Create a copy of WhoIsOutCardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? selectedDate = null,Object? focusDay = null,Object? calendarFormat = null,Object? allAbsences = null,Object? selectedDayAbsences = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,selectedDate: null == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime,focusDay: null == focusDay ? _self.focusDay : focusDay // ignore: cast_nullable_to_non_nullable
as DateTime,calendarFormat: null == calendarFormat ? _self.calendarFormat : calendarFormat // ignore: cast_nullable_to_non_nullable
as CalendarFormat,allAbsences: null == allAbsences ? _self.allAbsences : allAbsences // ignore: cast_nullable_to_non_nullable
as List<LeaveApplication>,selectedDayAbsences: freezed == selectedDayAbsences ? _self.selectedDayAbsences : selectedDayAbsences // ignore: cast_nullable_to_non_nullable
as List<LeaveApplication>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WhoIsOutCardState].
extension WhoIsOutCardStatePatterns on WhoIsOutCardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WhoIsOutCardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WhoIsOutCardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WhoIsOutCardState value)  $default,){
final _that = this;
switch (_that) {
case _WhoIsOutCardState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WhoIsOutCardState value)?  $default,){
final _that = this;
switch (_that) {
case _WhoIsOutCardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Status status,  DateTime selectedDate,  DateTime focusDay,  CalendarFormat calendarFormat,  List<LeaveApplication> allAbsences,  List<LeaveApplication>? selectedDayAbsences,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WhoIsOutCardState() when $default != null:
return $default(_that.status,_that.selectedDate,_that.focusDay,_that.calendarFormat,_that.allAbsences,_that.selectedDayAbsences,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Status status,  DateTime selectedDate,  DateTime focusDay,  CalendarFormat calendarFormat,  List<LeaveApplication> allAbsences,  List<LeaveApplication>? selectedDayAbsences,  String? error)  $default,) {final _that = this;
switch (_that) {
case _WhoIsOutCardState():
return $default(_that.status,_that.selectedDate,_that.focusDay,_that.calendarFormat,_that.allAbsences,_that.selectedDayAbsences,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Status status,  DateTime selectedDate,  DateTime focusDay,  CalendarFormat calendarFormat,  List<LeaveApplication> allAbsences,  List<LeaveApplication>? selectedDayAbsences,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _WhoIsOutCardState() when $default != null:
return $default(_that.status,_that.selectedDate,_that.focusDay,_that.calendarFormat,_that.allAbsences,_that.selectedDayAbsences,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _WhoIsOutCardState implements WhoIsOutCardState {
  const _WhoIsOutCardState({this.status = Status.initial, required this.selectedDate, required this.focusDay, this.calendarFormat = CalendarFormat.week, final  List<LeaveApplication> allAbsences = const [], final  List<LeaveApplication>? selectedDayAbsences, this.error}): _allAbsences = allAbsences,_selectedDayAbsences = selectedDayAbsences;
  

@override@JsonKey() final  Status status;
@override final  DateTime selectedDate;
@override final  DateTime focusDay;
@override@JsonKey() final  CalendarFormat calendarFormat;
 final  List<LeaveApplication> _allAbsences;
@override@JsonKey() List<LeaveApplication> get allAbsences {
  if (_allAbsences is EqualUnmodifiableListView) return _allAbsences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allAbsences);
}

 final  List<LeaveApplication>? _selectedDayAbsences;
@override List<LeaveApplication>? get selectedDayAbsences {
  final value = _selectedDayAbsences;
  if (value == null) return null;
  if (_selectedDayAbsences is EqualUnmodifiableListView) return _selectedDayAbsences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? error;

/// Create a copy of WhoIsOutCardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WhoIsOutCardStateCopyWith<_WhoIsOutCardState> get copyWith => __$WhoIsOutCardStateCopyWithImpl<_WhoIsOutCardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WhoIsOutCardState&&(identical(other.status, status) || other.status == status)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.focusDay, focusDay) || other.focusDay == focusDay)&&(identical(other.calendarFormat, calendarFormat) || other.calendarFormat == calendarFormat)&&const DeepCollectionEquality().equals(other._allAbsences, _allAbsences)&&const DeepCollectionEquality().equals(other._selectedDayAbsences, _selectedDayAbsences)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,selectedDate,focusDay,calendarFormat,const DeepCollectionEquality().hash(_allAbsences),const DeepCollectionEquality().hash(_selectedDayAbsences),error);

@override
String toString() {
  return 'WhoIsOutCardState(status: $status, selectedDate: $selectedDate, focusDay: $focusDay, calendarFormat: $calendarFormat, allAbsences: $allAbsences, selectedDayAbsences: $selectedDayAbsences, error: $error)';
}


}

/// @nodoc
abstract mixin class _$WhoIsOutCardStateCopyWith<$Res> implements $WhoIsOutCardStateCopyWith<$Res> {
  factory _$WhoIsOutCardStateCopyWith(_WhoIsOutCardState value, $Res Function(_WhoIsOutCardState) _then) = __$WhoIsOutCardStateCopyWithImpl;
@override @useResult
$Res call({
 Status status, DateTime selectedDate, DateTime focusDay, CalendarFormat calendarFormat, List<LeaveApplication> allAbsences, List<LeaveApplication>? selectedDayAbsences, String? error
});




}
/// @nodoc
class __$WhoIsOutCardStateCopyWithImpl<$Res>
    implements _$WhoIsOutCardStateCopyWith<$Res> {
  __$WhoIsOutCardStateCopyWithImpl(this._self, this._then);

  final _WhoIsOutCardState _self;
  final $Res Function(_WhoIsOutCardState) _then;

/// Create a copy of WhoIsOutCardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? selectedDate = null,Object? focusDay = null,Object? calendarFormat = null,Object? allAbsences = null,Object? selectedDayAbsences = freezed,Object? error = freezed,}) {
  return _then(_WhoIsOutCardState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,selectedDate: null == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime,focusDay: null == focusDay ? _self.focusDay : focusDay // ignore: cast_nullable_to_non_nullable
as DateTime,calendarFormat: null == calendarFormat ? _self.calendarFormat : calendarFormat // ignore: cast_nullable_to_non_nullable
as CalendarFormat,allAbsences: null == allAbsences ? _self._allAbsences : allAbsences // ignore: cast_nullable_to_non_nullable
as List<LeaveApplication>,selectedDayAbsences: freezed == selectedDayAbsences ? _self._selectedDayAbsences : selectedDayAbsences // ignore: cast_nullable_to_non_nullable
as List<LeaveApplication>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
