// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'who_is_out_card_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WhoIsOutCardState {
  Status get status => throw _privateConstructorUsedError;
  DateTime get selectedDate => throw _privateConstructorUsedError;
  DateTime get focusDay => throw _privateConstructorUsedError;
  CalendarFormat get calendarFormat => throw _privateConstructorUsedError;
  List<LeaveApplication> get allAbsences => throw _privateConstructorUsedError;
  List<LeaveApplication>? get selectedDayAbsences =>
      throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WhoIsOutCardStateCopyWith<WhoIsOutCardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WhoIsOutCardStateCopyWith<$Res> {
  factory $WhoIsOutCardStateCopyWith(
          WhoIsOutCardState value, $Res Function(WhoIsOutCardState) then) =
      _$WhoIsOutCardStateCopyWithImpl<$Res, WhoIsOutCardState>;
  @useResult
  $Res call(
      {Status status,
      DateTime selectedDate,
      DateTime focusDay,
      CalendarFormat calendarFormat,
      List<LeaveApplication> allAbsences,
      List<LeaveApplication>? selectedDayAbsences,
      String? error});
}

/// @nodoc
class _$WhoIsOutCardStateCopyWithImpl<$Res, $Val extends WhoIsOutCardState>
    implements $WhoIsOutCardStateCopyWith<$Res> {
  _$WhoIsOutCardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? selectedDate = null,
    Object? focusDay = null,
    Object? calendarFormat = null,
    Object? allAbsences = null,
    Object? selectedDayAbsences = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      focusDay: null == focusDay
          ? _value.focusDay
          : focusDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      calendarFormat: null == calendarFormat
          ? _value.calendarFormat
          : calendarFormat // ignore: cast_nullable_to_non_nullable
              as CalendarFormat,
      allAbsences: null == allAbsences
          ? _value.allAbsences
          : allAbsences // ignore: cast_nullable_to_non_nullable
              as List<LeaveApplication>,
      selectedDayAbsences: freezed == selectedDayAbsences
          ? _value.selectedDayAbsences
          : selectedDayAbsences // ignore: cast_nullable_to_non_nullable
              as List<LeaveApplication>?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WhoIsOutCardStateImplCopyWith<$Res>
    implements $WhoIsOutCardStateCopyWith<$Res> {
  factory _$$WhoIsOutCardStateImplCopyWith(_$WhoIsOutCardStateImpl value,
          $Res Function(_$WhoIsOutCardStateImpl) then) =
      __$$WhoIsOutCardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Status status,
      DateTime selectedDate,
      DateTime focusDay,
      CalendarFormat calendarFormat,
      List<LeaveApplication> allAbsences,
      List<LeaveApplication>? selectedDayAbsences,
      String? error});
}

/// @nodoc
class __$$WhoIsOutCardStateImplCopyWithImpl<$Res>
    extends _$WhoIsOutCardStateCopyWithImpl<$Res, _$WhoIsOutCardStateImpl>
    implements _$$WhoIsOutCardStateImplCopyWith<$Res> {
  __$$WhoIsOutCardStateImplCopyWithImpl(_$WhoIsOutCardStateImpl _value,
      $Res Function(_$WhoIsOutCardStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? selectedDate = null,
    Object? focusDay = null,
    Object? calendarFormat = null,
    Object? allAbsences = null,
    Object? selectedDayAbsences = freezed,
    Object? error = freezed,
  }) {
    return _then(_$WhoIsOutCardStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      focusDay: null == focusDay
          ? _value.focusDay
          : focusDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      calendarFormat: null == calendarFormat
          ? _value.calendarFormat
          : calendarFormat // ignore: cast_nullable_to_non_nullable
              as CalendarFormat,
      allAbsences: null == allAbsences
          ? _value._allAbsences
          : allAbsences // ignore: cast_nullable_to_non_nullable
              as List<LeaveApplication>,
      selectedDayAbsences: freezed == selectedDayAbsences
          ? _value._selectedDayAbsences
          : selectedDayAbsences // ignore: cast_nullable_to_non_nullable
              as List<LeaveApplication>?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$WhoIsOutCardStateImpl implements _WhoIsOutCardState {
  const _$WhoIsOutCardStateImpl(
      {this.status = Status.initial,
      required this.selectedDate,
      required this.focusDay,
      this.calendarFormat = CalendarFormat.week,
      final List<LeaveApplication> allAbsences = const [],
      final List<LeaveApplication>? selectedDayAbsences,
      this.error})
      : _allAbsences = allAbsences,
        _selectedDayAbsences = selectedDayAbsences;

  @override
  @JsonKey()
  final Status status;
  @override
  final DateTime selectedDate;
  @override
  final DateTime focusDay;
  @override
  @JsonKey()
  final CalendarFormat calendarFormat;
  final List<LeaveApplication> _allAbsences;
  @override
  @JsonKey()
  List<LeaveApplication> get allAbsences {
    if (_allAbsences is EqualUnmodifiableListView) return _allAbsences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allAbsences);
  }

  final List<LeaveApplication>? _selectedDayAbsences;
  @override
  List<LeaveApplication>? get selectedDayAbsences {
    final value = _selectedDayAbsences;
    if (value == null) return null;
    if (_selectedDayAbsences is EqualUnmodifiableListView)
      return _selectedDayAbsences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? error;

  @override
  String toString() {
    return 'WhoIsOutCardState(status: $status, selectedDate: $selectedDate, focusDay: $focusDay, calendarFormat: $calendarFormat, allAbsences: $allAbsences, selectedDayAbsences: $selectedDayAbsences, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WhoIsOutCardStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.focusDay, focusDay) ||
                other.focusDay == focusDay) &&
            (identical(other.calendarFormat, calendarFormat) ||
                other.calendarFormat == calendarFormat) &&
            const DeepCollectionEquality()
                .equals(other._allAbsences, _allAbsences) &&
            const DeepCollectionEquality()
                .equals(other._selectedDayAbsences, _selectedDayAbsences) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      selectedDate,
      focusDay,
      calendarFormat,
      const DeepCollectionEquality().hash(_allAbsences),
      const DeepCollectionEquality().hash(_selectedDayAbsences),
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WhoIsOutCardStateImplCopyWith<_$WhoIsOutCardStateImpl> get copyWith =>
      __$$WhoIsOutCardStateImplCopyWithImpl<_$WhoIsOutCardStateImpl>(
          this, _$identity);
}

abstract class _WhoIsOutCardState implements WhoIsOutCardState {
  const factory _WhoIsOutCardState(
      {final Status status,
      required final DateTime selectedDate,
      required final DateTime focusDay,
      final CalendarFormat calendarFormat,
      final List<LeaveApplication> allAbsences,
      final List<LeaveApplication>? selectedDayAbsences,
      final String? error}) = _$WhoIsOutCardStateImpl;

  @override
  Status get status;
  @override
  DateTime get selectedDate;
  @override
  DateTime get focusDay;
  @override
  CalendarFormat get calendarFormat;
  @override
  List<LeaveApplication> get allAbsences;
  @override
  List<LeaveApplication>? get selectedDayAbsences;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$WhoIsOutCardStateImplCopyWith<_$WhoIsOutCardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
