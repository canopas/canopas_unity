// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AppStateTearOff {
  const _$AppStateTearOff();

  Home home() {
    return const Home();
  }

  EmployeeDetail employeeDetail({required int employeeId}) {
    return EmployeeDetail(
      employeeId: employeeId,
    );
  }

  Leave leave() {
    return const Leave();
  }

  LeaveRequestForm leaveRequestForm() {
    return const LeaveRequestForm();
  }

  Setting setting() {
    return const Setting();
  }
}

/// @nodoc
const $AppState = _$AppStateTearOff();

/// @nodoc
mixin _$AppState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() home,
    required TResult Function(int employeeId) employeeDetail,
    required TResult Function() leave,
    required TResult Function() leaveRequestForm,
    required TResult Function() setting,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int employeeId)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? leaveRequestForm,
    TResult Function()? setting,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int employeeId)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? leaveRequestForm,
    TResult Function()? setting,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Home value) home,
    required TResult Function(EmployeeDetail value) employeeDetail,
    required TResult Function(Leave value) leave,
    required TResult Function(LeaveRequestForm value) leaveRequestForm,
    required TResult Function(Setting value) setting,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(LeaveRequestForm value)? leaveRequestForm,
    TResult Function(Setting value)? setting,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(LeaveRequestForm value)? leaveRequestForm,
    TResult Function(Setting value)? setting,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res> implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  final AppState _value;
  // ignore: unused_field
  final $Res Function(AppState) _then;
}

/// @nodoc
abstract class $HomeCopyWith<$Res> {
  factory $HomeCopyWith(Home value, $Res Function(Home) then) =
      _$HomeCopyWithImpl<$Res>;
}

/// @nodoc
class _$HomeCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements $HomeCopyWith<$Res> {
  _$HomeCopyWithImpl(Home _value, $Res Function(Home) _then)
      : super(_value, (v) => _then(v as Home));

  @override
  Home get _value => super._value as Home;
}

/// @nodoc

class _$Home implements Home {
  const _$Home();

  @override
  String toString() {
    return 'AppState.home()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Home);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() home,
    required TResult Function(int employeeId) employeeDetail,
    required TResult Function() leave,
    required TResult Function() leaveRequestForm,
    required TResult Function() setting,
  }) {
    return home();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int employeeId)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? leaveRequestForm,
    TResult Function()? setting,
  }) {
    return home?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int employeeId)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? leaveRequestForm,
    TResult Function()? setting,
    required TResult orElse(),
  }) {
    if (home != null) {
      return home();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Home value) home,
    required TResult Function(EmployeeDetail value) employeeDetail,
    required TResult Function(Leave value) leave,
    required TResult Function(LeaveRequestForm value) leaveRequestForm,
    required TResult Function(Setting value) setting,
  }) {
    return home(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(LeaveRequestForm value)? leaveRequestForm,
    TResult Function(Setting value)? setting,
  }) {
    return home?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(LeaveRequestForm value)? leaveRequestForm,
    TResult Function(Setting value)? setting,
    required TResult orElse(),
  }) {
    if (home != null) {
      return home(this);
    }
    return orElse();
  }
}

abstract class Home implements AppState {
  const factory Home() = _$Home;
}

/// @nodoc
abstract class $EmployeeDetailCopyWith<$Res> {
  factory $EmployeeDetailCopyWith(
          EmployeeDetail value, $Res Function(EmployeeDetail) then) =
      _$EmployeeDetailCopyWithImpl<$Res>;
  $Res call({int employeeId});
}

/// @nodoc
class _$EmployeeDetailCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements $EmployeeDetailCopyWith<$Res> {
  _$EmployeeDetailCopyWithImpl(
      EmployeeDetail _value, $Res Function(EmployeeDetail) _then)
      : super(_value, (v) => _then(v as EmployeeDetail));

  @override
  EmployeeDetail get _value => super._value as EmployeeDetail;

  @override
  $Res call({
    Object? employeeId = freezed,
  }) {
    return _then(EmployeeDetail(
      employeeId: employeeId == freezed
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$EmployeeDetail implements EmployeeDetail {
  const _$EmployeeDetail({required this.employeeId});

  @override
  final int employeeId;

  @override
  String toString() {
    return 'AppState.employeeDetail(employeeId: $employeeId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EmployeeDetail &&
            const DeepCollectionEquality()
                .equals(other.employeeId, employeeId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(employeeId));

  @JsonKey(ignore: true)
  @override
  $EmployeeDetailCopyWith<EmployeeDetail> get copyWith =>
      _$EmployeeDetailCopyWithImpl<EmployeeDetail>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() home,
    required TResult Function(int employeeId) employeeDetail,
    required TResult Function() leave,
    required TResult Function() leaveRequestForm,
    required TResult Function() setting,
  }) {
    return employeeDetail(employeeId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int employeeId)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? leaveRequestForm,
    TResult Function()? setting,
  }) {
    return employeeDetail?.call(employeeId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int employeeId)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? leaveRequestForm,
    TResult Function()? setting,
    required TResult orElse(),
  }) {
    if (employeeDetail != null) {
      return employeeDetail(employeeId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Home value) home,
    required TResult Function(EmployeeDetail value) employeeDetail,
    required TResult Function(Leave value) leave,
    required TResult Function(LeaveRequestForm value) leaveRequestForm,
    required TResult Function(Setting value) setting,
  }) {
    return employeeDetail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(LeaveRequestForm value)? leaveRequestForm,
    TResult Function(Setting value)? setting,
  }) {
    return employeeDetail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(LeaveRequestForm value)? leaveRequestForm,
    TResult Function(Setting value)? setting,
    required TResult orElse(),
  }) {
    if (employeeDetail != null) {
      return employeeDetail(this);
    }
    return orElse();
  }
}

abstract class EmployeeDetail implements AppState {
  const factory EmployeeDetail({required int employeeId}) = _$EmployeeDetail;

  int get employeeId;
  @JsonKey(ignore: true)
  $EmployeeDetailCopyWith<EmployeeDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveCopyWith<$Res> {
  factory $LeaveCopyWith(Leave value, $Res Function(Leave) then) =
      _$LeaveCopyWithImpl<$Res>;
}

/// @nodoc
class _$LeaveCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements $LeaveCopyWith<$Res> {
  _$LeaveCopyWithImpl(Leave _value, $Res Function(Leave) _then)
      : super(_value, (v) => _then(v as Leave));

  @override
  Leave get _value => super._value as Leave;
}

/// @nodoc

class _$Leave implements Leave {
  const _$Leave();

  @override
  String toString() {
    return 'AppState.leave()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Leave);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() home,
    required TResult Function(int employeeId) employeeDetail,
    required TResult Function() leave,
    required TResult Function() leaveRequestForm,
    required TResult Function() setting,
  }) {
    return leave();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int employeeId)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? leaveRequestForm,
    TResult Function()? setting,
  }) {
    return leave?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int employeeId)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? leaveRequestForm,
    TResult Function()? setting,
    required TResult orElse(),
  }) {
    if (leave != null) {
      return leave();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Home value) home,
    required TResult Function(EmployeeDetail value) employeeDetail,
    required TResult Function(Leave value) leave,
    required TResult Function(LeaveRequestForm value) leaveRequestForm,
    required TResult Function(Setting value) setting,
  }) {
    return leave(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(LeaveRequestForm value)? leaveRequestForm,
    TResult Function(Setting value)? setting,
  }) {
    return leave?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(LeaveRequestForm value)? leaveRequestForm,
    TResult Function(Setting value)? setting,
    required TResult orElse(),
  }) {
    if (leave != null) {
      return leave(this);
    }
    return orElse();
  }
}

abstract class Leave implements AppState {
  const factory Leave() = _$Leave;
}

/// @nodoc
abstract class $LeaveRequestFormCopyWith<$Res> {
  factory $LeaveRequestFormCopyWith(
          LeaveRequestForm value, $Res Function(LeaveRequestForm) then) =
      _$LeaveRequestFormCopyWithImpl<$Res>;
}

/// @nodoc
class _$LeaveRequestFormCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements $LeaveRequestFormCopyWith<$Res> {
  _$LeaveRequestFormCopyWithImpl(
      LeaveRequestForm _value, $Res Function(LeaveRequestForm) _then)
      : super(_value, (v) => _then(v as LeaveRequestForm));

  @override
  LeaveRequestForm get _value => super._value as LeaveRequestForm;
}

/// @nodoc

class _$LeaveRequestForm implements LeaveRequestForm {
  const _$LeaveRequestForm();

  @override
  String toString() {
    return 'AppState.leaveRequestForm()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LeaveRequestForm);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() home,
    required TResult Function(int employeeId) employeeDetail,
    required TResult Function() leave,
    required TResult Function() leaveRequestForm,
    required TResult Function() setting,
  }) {
    return leaveRequestForm();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int employeeId)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? leaveRequestForm,
    TResult Function()? setting,
  }) {
    return leaveRequestForm?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int employeeId)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? leaveRequestForm,
    TResult Function()? setting,
    required TResult orElse(),
  }) {
    if (leaveRequestForm != null) {
      return leaveRequestForm();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Home value) home,
    required TResult Function(EmployeeDetail value) employeeDetail,
    required TResult Function(Leave value) leave,
    required TResult Function(LeaveRequestForm value) leaveRequestForm,
    required TResult Function(Setting value) setting,
  }) {
    return leaveRequestForm(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(LeaveRequestForm value)? leaveRequestForm,
    TResult Function(Setting value)? setting,
  }) {
    return leaveRequestForm?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(LeaveRequestForm value)? leaveRequestForm,
    TResult Function(Setting value)? setting,
    required TResult orElse(),
  }) {
    if (leaveRequestForm != null) {
      return leaveRequestForm(this);
    }
    return orElse();
  }
}

abstract class LeaveRequestForm implements AppState {
  const factory LeaveRequestForm() = _$LeaveRequestForm;
}

/// @nodoc
abstract class $SettingCopyWith<$Res> {
  factory $SettingCopyWith(Setting value, $Res Function(Setting) then) =
      _$SettingCopyWithImpl<$Res>;
}

/// @nodoc
class _$SettingCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements $SettingCopyWith<$Res> {
  _$SettingCopyWithImpl(Setting _value, $Res Function(Setting) _then)
      : super(_value, (v) => _then(v as Setting));

  @override
  Setting get _value => super._value as Setting;
}

/// @nodoc

class _$Setting implements Setting {
  const _$Setting();

  @override
  String toString() {
    return 'AppState.setting()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Setting);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() home,
    required TResult Function(int employeeId) employeeDetail,
    required TResult Function() leave,
    required TResult Function() leaveRequestForm,
    required TResult Function() setting,
  }) {
    return setting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int employeeId)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? leaveRequestForm,
    TResult Function()? setting,
  }) {
    return setting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int employeeId)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? leaveRequestForm,
    TResult Function()? setting,
    required TResult orElse(),
  }) {
    if (setting != null) {
      return setting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Home value) home,
    required TResult Function(EmployeeDetail value) employeeDetail,
    required TResult Function(Leave value) leave,
    required TResult Function(LeaveRequestForm value) leaveRequestForm,
    required TResult Function(Setting value) setting,
  }) {
    return setting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(LeaveRequestForm value)? leaveRequestForm,
    TResult Function(Setting value)? setting,
  }) {
    return setting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(LeaveRequestForm value)? leaveRequestForm,
    TResult Function(Setting value)? setting,
    required TResult orElse(),
  }) {
    if (setting != null) {
      return setting(this);
    }
    return orElse();
  }
}

abstract class Setting implements AppState {
  const factory Setting() = _$Setting;
}
