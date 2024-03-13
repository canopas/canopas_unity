// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'celebrations_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CelebrationsState {
  Status get status => throw _privateConstructorUsedError;
  DateTime get currentWeek => throw _privateConstructorUsedError;
  bool get showAllBdays => throw _privateConstructorUsedError;
  bool get showAllAnniversaries => throw _privateConstructorUsedError;
  List<Event> get birthdays => throw _privateConstructorUsedError;
  List<Event> get anniversaries => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CelebrationsStateCopyWith<CelebrationsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CelebrationsStateCopyWith<$Res> {
  factory $CelebrationsStateCopyWith(
          CelebrationsState value, $Res Function(CelebrationsState) then) =
      _$CelebrationsStateCopyWithImpl<$Res, CelebrationsState>;
  @useResult
  $Res call(
      {Status status,
      DateTime currentWeek,
      bool showAllBdays,
      bool showAllAnniversaries,
      List<Event> birthdays,
      List<Event> anniversaries,
      String? error});
}

/// @nodoc
class _$CelebrationsStateCopyWithImpl<$Res, $Val extends CelebrationsState>
    implements $CelebrationsStateCopyWith<$Res> {
  _$CelebrationsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? currentWeek = null,
    Object? showAllBdays = null,
    Object? showAllAnniversaries = null,
    Object? birthdays = null,
    Object? anniversaries = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      currentWeek: null == currentWeek
          ? _value.currentWeek
          : currentWeek // ignore: cast_nullable_to_non_nullable
              as DateTime,
      showAllBdays: null == showAllBdays
          ? _value.showAllBdays
          : showAllBdays // ignore: cast_nullable_to_non_nullable
              as bool,
      showAllAnniversaries: null == showAllAnniversaries
          ? _value.showAllAnniversaries
          : showAllAnniversaries // ignore: cast_nullable_to_non_nullable
              as bool,
      birthdays: null == birthdays
          ? _value.birthdays
          : birthdays // ignore: cast_nullable_to_non_nullable
              as List<Event>,
      anniversaries: null == anniversaries
          ? _value.anniversaries
          : anniversaries // ignore: cast_nullable_to_non_nullable
              as List<Event>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CelebrationsStateImplCopyWith<$Res>
    implements $CelebrationsStateCopyWith<$Res> {
  factory _$$CelebrationsStateImplCopyWith(_$CelebrationsStateImpl value,
          $Res Function(_$CelebrationsStateImpl) then) =
      __$$CelebrationsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Status status,
      DateTime currentWeek,
      bool showAllBdays,
      bool showAllAnniversaries,
      List<Event> birthdays,
      List<Event> anniversaries,
      String? error});
}

/// @nodoc
class __$$CelebrationsStateImplCopyWithImpl<$Res>
    extends _$CelebrationsStateCopyWithImpl<$Res, _$CelebrationsStateImpl>
    implements _$$CelebrationsStateImplCopyWith<$Res> {
  __$$CelebrationsStateImplCopyWithImpl(_$CelebrationsStateImpl _value,
      $Res Function(_$CelebrationsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? currentWeek = null,
    Object? showAllBdays = null,
    Object? showAllAnniversaries = null,
    Object? birthdays = null,
    Object? anniversaries = null,
    Object? error = freezed,
  }) {
    return _then(_$CelebrationsStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      currentWeek: null == currentWeek
          ? _value.currentWeek
          : currentWeek // ignore: cast_nullable_to_non_nullable
              as DateTime,
      showAllBdays: null == showAllBdays
          ? _value.showAllBdays
          : showAllBdays // ignore: cast_nullable_to_non_nullable
              as bool,
      showAllAnniversaries: null == showAllAnniversaries
          ? _value.showAllAnniversaries
          : showAllAnniversaries // ignore: cast_nullable_to_non_nullable
              as bool,
      birthdays: null == birthdays
          ? _value._birthdays
          : birthdays // ignore: cast_nullable_to_non_nullable
              as List<Event>,
      anniversaries: null == anniversaries
          ? _value._anniversaries
          : anniversaries // ignore: cast_nullable_to_non_nullable
              as List<Event>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CelebrationsStateImpl implements _CelebrationsState {
  const _$CelebrationsStateImpl(
      {this.status = Status.initial,
      required this.currentWeek,
      this.showAllBdays = false,
      this.showAllAnniversaries = false,
      final List<Event> birthdays = const [],
      final List<Event> anniversaries = const [],
      this.error})
      : _birthdays = birthdays,
        _anniversaries = anniversaries;

  @override
  @JsonKey()
  final Status status;
  @override
  final DateTime currentWeek;
  @override
  @JsonKey()
  final bool showAllBdays;
  @override
  @JsonKey()
  final bool showAllAnniversaries;
  final List<Event> _birthdays;
  @override
  @JsonKey()
  List<Event> get birthdays {
    if (_birthdays is EqualUnmodifiableListView) return _birthdays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_birthdays);
  }

  final List<Event> _anniversaries;
  @override
  @JsonKey()
  List<Event> get anniversaries {
    if (_anniversaries is EqualUnmodifiableListView) return _anniversaries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_anniversaries);
  }

  @override
  final String? error;

  @override
  String toString() {
    return 'CelebrationsState(status: $status, currentWeek: $currentWeek, showAllBdays: $showAllBdays, showAllAnniversaries: $showAllAnniversaries, birthdays: $birthdays, anniversaries: $anniversaries, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CelebrationsStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentWeek, currentWeek) ||
                other.currentWeek == currentWeek) &&
            (identical(other.showAllBdays, showAllBdays) ||
                other.showAllBdays == showAllBdays) &&
            (identical(other.showAllAnniversaries, showAllAnniversaries) ||
                other.showAllAnniversaries == showAllAnniversaries) &&
            const DeepCollectionEquality()
                .equals(other._birthdays, _birthdays) &&
            const DeepCollectionEquality()
                .equals(other._anniversaries, _anniversaries) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      currentWeek,
      showAllBdays,
      showAllAnniversaries,
      const DeepCollectionEquality().hash(_birthdays),
      const DeepCollectionEquality().hash(_anniversaries),
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CelebrationsStateImplCopyWith<_$CelebrationsStateImpl> get copyWith =>
      __$$CelebrationsStateImplCopyWithImpl<_$CelebrationsStateImpl>(
          this, _$identity);
}

abstract class _CelebrationsState implements CelebrationsState {
  const factory _CelebrationsState(
      {final Status status,
      required final DateTime currentWeek,
      final bool showAllBdays,
      final bool showAllAnniversaries,
      final List<Event> birthdays,
      final List<Event> anniversaries,
      final String? error}) = _$CelebrationsStateImpl;

  @override
  Status get status;
  @override
  DateTime get currentWeek;
  @override
  bool get showAllBdays;
  @override
  bool get showAllAnniversaries;
  @override
  List<Event> get birthdays;
  @override
  List<Event> get anniversaries;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$CelebrationsStateImplCopyWith<_$CelebrationsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
