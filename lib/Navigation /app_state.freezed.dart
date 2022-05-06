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

  EmployeeDetail employeeDetail({required int id}) {
    return EmployeeDetail(
      id: id,
    );
  }

  Leave leave() {
    return const Leave();
  }

  UserAllLeave userAllLeave() {
    return const UserAllLeave();
  }

  UserUpcomingLeave userUpcomingLeave() {
    return const UserUpcomingLeave();
  }

  LeaveRequest leaveRequest() {
    return const LeaveRequest();
  }

  Settings settings() {
    return const Settings();
  }
}

/// @nodoc
const $AppState = _$AppStateTearOff();

/// @nodoc
mixin _$AppState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() home,
    required TResult Function(int id) employeeDetail,
    required TResult Function() leave,
    required TResult Function() userAllLeave,
    required TResult Function() userUpcomingLeave,
    required TResult Function() leaveRequest,
    required TResult Function() settings,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int id)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? userAllLeave,
    TResult Function()? userUpcomingLeave,
    TResult Function()? leaveRequest,
    TResult Function()? settings,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int id)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? userAllLeave,
    TResult Function()? userUpcomingLeave,
    TResult Function()? leaveRequest,
    TResult Function()? settings,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Home value) home,
    required TResult Function(EmployeeDetail value) employeeDetail,
    required TResult Function(Leave value) leave,
    required TResult Function(UserAllLeave value) userAllLeave,
    required TResult Function(UserUpcomingLeave value) userUpcomingLeave,
    required TResult Function(LeaveRequest value) leaveRequest,
    required TResult Function(Settings value) settings,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(UserAllLeave value)? userAllLeave,
    TResult Function(UserUpcomingLeave value)? userUpcomingLeave,
    TResult Function(LeaveRequest value)? leaveRequest,
    TResult Function(Settings value)? settings,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(UserAllLeave value)? userAllLeave,
    TResult Function(UserUpcomingLeave value)? userUpcomingLeave,
    TResult Function(LeaveRequest value)? leaveRequest,
    TResult Function(Settings value)? settings,
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
    required TResult Function(int id) employeeDetail,
    required TResult Function() leave,
    required TResult Function() userAllLeave,
    required TResult Function() userUpcomingLeave,
    required TResult Function() leaveRequest,
    required TResult Function() settings,
  }) {
    return home();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int id)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? userAllLeave,
    TResult Function()? userUpcomingLeave,
    TResult Function()? leaveRequest,
    TResult Function()? settings,
  }) {
    return home?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int id)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? userAllLeave,
    TResult Function()? userUpcomingLeave,
    TResult Function()? leaveRequest,
    TResult Function()? settings,
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
    required TResult Function(UserAllLeave value) userAllLeave,
    required TResult Function(UserUpcomingLeave value) userUpcomingLeave,
    required TResult Function(LeaveRequest value) leaveRequest,
    required TResult Function(Settings value) settings,
  }) {
    return home(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(UserAllLeave value)? userAllLeave,
    TResult Function(UserUpcomingLeave value)? userUpcomingLeave,
    TResult Function(LeaveRequest value)? leaveRequest,
    TResult Function(Settings value)? settings,
  }) {
    return home?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(UserAllLeave value)? userAllLeave,
    TResult Function(UserUpcomingLeave value)? userUpcomingLeave,
    TResult Function(LeaveRequest value)? leaveRequest,
    TResult Function(Settings value)? settings,
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

  $Res call({int id});
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
    Object? id = freezed,
  }) {
    return _then(EmployeeDetail(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$EmployeeDetail implements EmployeeDetail {
  const _$EmployeeDetail({required this.id});

  @override
  final int id;

  @override
  String toString() {
    return 'AppState.employeeDetail(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EmployeeDetail &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(id));

  @JsonKey(ignore: true)
  @override
  $EmployeeDetailCopyWith<EmployeeDetail> get copyWith =>
      _$EmployeeDetailCopyWithImpl<EmployeeDetail>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() home,
    required TResult Function(int id) employeeDetail,
    required TResult Function() leave,
    required TResult Function() userAllLeave,
    required TResult Function() userUpcomingLeave,
    required TResult Function() leaveRequest,
    required TResult Function() settings,
  }) {
    return employeeDetail(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int id)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? userAllLeave,
    TResult Function()? userUpcomingLeave,
    TResult Function()? leaveRequest,
    TResult Function()? settings,
  }) {
    return employeeDetail?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int id)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? userAllLeave,
    TResult Function()? userUpcomingLeave,
    TResult Function()? leaveRequest,
    TResult Function()? settings,
    required TResult orElse(),
  }) {
    if (employeeDetail != null) {
      return employeeDetail(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Home value) home,
    required TResult Function(EmployeeDetail value) employeeDetail,
    required TResult Function(Leave value) leave,
    required TResult Function(UserAllLeave value) userAllLeave,
    required TResult Function(UserUpcomingLeave value) userUpcomingLeave,
    required TResult Function(LeaveRequest value) leaveRequest,
    required TResult Function(Settings value) settings,
  }) {
    return employeeDetail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(UserAllLeave value)? userAllLeave,
    TResult Function(UserUpcomingLeave value)? userUpcomingLeave,
    TResult Function(LeaveRequest value)? leaveRequest,
    TResult Function(Settings value)? settings,
  }) {
    return employeeDetail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(UserAllLeave value)? userAllLeave,
    TResult Function(UserUpcomingLeave value)? userUpcomingLeave,
    TResult Function(LeaveRequest value)? leaveRequest,
    TResult Function(Settings value)? settings,
    required TResult orElse(),
  }) {
    if (employeeDetail != null) {
      return employeeDetail(this);
    }
    return orElse();
  }
}

abstract class EmployeeDetail implements AppState {
  const factory EmployeeDetail({required int id}) = _$EmployeeDetail;

  int get id;

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
    required TResult Function(int id) employeeDetail,
    required TResult Function() leave,
    required TResult Function() userAllLeave,
    required TResult Function() userUpcomingLeave,
    required TResult Function() leaveRequest,
    required TResult Function() settings,
  }) {
    return leave();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int id)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? userAllLeave,
    TResult Function()? userUpcomingLeave,
    TResult Function()? leaveRequest,
    TResult Function()? settings,
  }) {
    return leave?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int id)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? userAllLeave,
    TResult Function()? userUpcomingLeave,
    TResult Function()? leaveRequest,
    TResult Function()? settings,
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
    required TResult Function(UserAllLeave value) userAllLeave,
    required TResult Function(UserUpcomingLeave value) userUpcomingLeave,
    required TResult Function(LeaveRequest value) leaveRequest,
    required TResult Function(Settings value) settings,
  }) {
    return leave(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(UserAllLeave value)? userAllLeave,
    TResult Function(UserUpcomingLeave value)? userUpcomingLeave,
    TResult Function(LeaveRequest value)? leaveRequest,
    TResult Function(Settings value)? settings,
  }) {
    return leave?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(UserAllLeave value)? userAllLeave,
    TResult Function(UserUpcomingLeave value)? userUpcomingLeave,
    TResult Function(LeaveRequest value)? leaveRequest,
    TResult Function(Settings value)? settings,
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
abstract class $UserAllLeaveCopyWith<$Res> {
  factory $UserAllLeaveCopyWith(
          UserAllLeave value, $Res Function(UserAllLeave) then) =
      _$UserAllLeaveCopyWithImpl<$Res>;
}

/// @nodoc
class _$UserAllLeaveCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements $UserAllLeaveCopyWith<$Res> {
  _$UserAllLeaveCopyWithImpl(
      UserAllLeave _value, $Res Function(UserAllLeave) _then)
      : super(_value, (v) => _then(v as UserAllLeave));

  @override
  UserAllLeave get _value => super._value as UserAllLeave;
}

/// @nodoc

class _$UserAllLeave implements UserAllLeave {
  const _$UserAllLeave();

  @override
  String toString() {
    return 'AppState.userAllLeave()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UserAllLeave);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() home,
    required TResult Function(int id) employeeDetail,
    required TResult Function() leave,
    required TResult Function() userAllLeave,
    required TResult Function() userUpcomingLeave,
    required TResult Function() leaveRequest,
    required TResult Function() settings,
  }) {
    return userAllLeave();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int id)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? userAllLeave,
    TResult Function()? userUpcomingLeave,
    TResult Function()? leaveRequest,
    TResult Function()? settings,
  }) {
    return userAllLeave?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int id)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? userAllLeave,
    TResult Function()? userUpcomingLeave,
    TResult Function()? leaveRequest,
    TResult Function()? settings,
    required TResult orElse(),
  }) {
    if (userAllLeave != null) {
      return userAllLeave();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Home value) home,
    required TResult Function(EmployeeDetail value) employeeDetail,
    required TResult Function(Leave value) leave,
    required TResult Function(UserAllLeave value) userAllLeave,
    required TResult Function(UserUpcomingLeave value) userUpcomingLeave,
    required TResult Function(LeaveRequest value) leaveRequest,
    required TResult Function(Settings value) settings,
  }) {
    return userAllLeave(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(UserAllLeave value)? userAllLeave,
    TResult Function(UserUpcomingLeave value)? userUpcomingLeave,
    TResult Function(LeaveRequest value)? leaveRequest,
    TResult Function(Settings value)? settings,
  }) {
    return userAllLeave?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(UserAllLeave value)? userAllLeave,
    TResult Function(UserUpcomingLeave value)? userUpcomingLeave,
    TResult Function(LeaveRequest value)? leaveRequest,
    TResult Function(Settings value)? settings,
    required TResult orElse(),
  }) {
    if (userAllLeave != null) {
      return userAllLeave(this);
    }
    return orElse();
  }
}

abstract class UserAllLeave implements AppState {
  const factory UserAllLeave() = _$UserAllLeave;
}

/// @nodoc
abstract class $UserUpcomingLeaveCopyWith<$Res> {
  factory $UserUpcomingLeaveCopyWith(
          UserUpcomingLeave value, $Res Function(UserUpcomingLeave) then) =
      _$UserUpcomingLeaveCopyWithImpl<$Res>;
}

/// @nodoc
class _$UserUpcomingLeaveCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements $UserUpcomingLeaveCopyWith<$Res> {
  _$UserUpcomingLeaveCopyWithImpl(
      UserUpcomingLeave _value, $Res Function(UserUpcomingLeave) _then)
      : super(_value, (v) => _then(v as UserUpcomingLeave));

  @override
  UserUpcomingLeave get _value => super._value as UserUpcomingLeave;
}

/// @nodoc

class _$UserUpcomingLeave implements UserUpcomingLeave {
  const _$UserUpcomingLeave();

  @override
  String toString() {
    return 'AppState.userUpcomingLeave()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UserUpcomingLeave);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() home,
    required TResult Function(int id) employeeDetail,
    required TResult Function() leave,
    required TResult Function() userAllLeave,
    required TResult Function() userUpcomingLeave,
    required TResult Function() leaveRequest,
    required TResult Function() settings,
  }) {
    return userUpcomingLeave();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int id)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? userAllLeave,
    TResult Function()? userUpcomingLeave,
    TResult Function()? leaveRequest,
    TResult Function()? settings,
  }) {
    return userUpcomingLeave?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int id)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? userAllLeave,
    TResult Function()? userUpcomingLeave,
    TResult Function()? leaveRequest,
    TResult Function()? settings,
    required TResult orElse(),
  }) {
    if (userUpcomingLeave != null) {
      return userUpcomingLeave();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Home value) home,
    required TResult Function(EmployeeDetail value) employeeDetail,
    required TResult Function(Leave value) leave,
    required TResult Function(UserAllLeave value) userAllLeave,
    required TResult Function(UserUpcomingLeave value) userUpcomingLeave,
    required TResult Function(LeaveRequest value) leaveRequest,
    required TResult Function(Settings value) settings,
  }) {
    return userUpcomingLeave(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(UserAllLeave value)? userAllLeave,
    TResult Function(UserUpcomingLeave value)? userUpcomingLeave,
    TResult Function(LeaveRequest value)? leaveRequest,
    TResult Function(Settings value)? settings,
  }) {
    return userUpcomingLeave?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(UserAllLeave value)? userAllLeave,
    TResult Function(UserUpcomingLeave value)? userUpcomingLeave,
    TResult Function(LeaveRequest value)? leaveRequest,
    TResult Function(Settings value)? settings,
    required TResult orElse(),
  }) {
    if (userUpcomingLeave != null) {
      return userUpcomingLeave(this);
    }
    return orElse();
  }
}

abstract class UserUpcomingLeave implements AppState {
  const factory UserUpcomingLeave() = _$UserUpcomingLeave;
}

/// @nodoc
abstract class $LeaveRequestCopyWith<$Res> {
  factory $LeaveRequestCopyWith(
          LeaveRequest value, $Res Function(LeaveRequest) then) =
      _$LeaveRequestCopyWithImpl<$Res>;
}

/// @nodoc
class _$LeaveRequestCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements $LeaveRequestCopyWith<$Res> {
  _$LeaveRequestCopyWithImpl(
      LeaveRequest _value, $Res Function(LeaveRequest) _then)
      : super(_value, (v) => _then(v as LeaveRequest));

  @override
  LeaveRequest get _value => super._value as LeaveRequest;
}

/// @nodoc

class _$LeaveRequest implements LeaveRequest {
  const _$LeaveRequest();

  @override
  String toString() {
    return 'AppState.leaveRequest()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LeaveRequest);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() home,
    required TResult Function(int id) employeeDetail,
    required TResult Function() leave,
    required TResult Function() userAllLeave,
    required TResult Function() userUpcomingLeave,
    required TResult Function() leaveRequest,
    required TResult Function() settings,
  }) {
    return leaveRequest();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int id)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? userAllLeave,
    TResult Function()? userUpcomingLeave,
    TResult Function()? leaveRequest,
    TResult Function()? settings,
  }) {
    return leaveRequest?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int id)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? userAllLeave,
    TResult Function()? userUpcomingLeave,
    TResult Function()? leaveRequest,
    TResult Function()? settings,
    required TResult orElse(),
  }) {
    if (leaveRequest != null) {
      return leaveRequest();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Home value) home,
    required TResult Function(EmployeeDetail value) employeeDetail,
    required TResult Function(Leave value) leave,
    required TResult Function(UserAllLeave value) userAllLeave,
    required TResult Function(UserUpcomingLeave value) userUpcomingLeave,
    required TResult Function(LeaveRequest value) leaveRequest,
    required TResult Function(Settings value) settings,
  }) {
    return leaveRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(UserAllLeave value)? userAllLeave,
    TResult Function(UserUpcomingLeave value)? userUpcomingLeave,
    TResult Function(LeaveRequest value)? leaveRequest,
    TResult Function(Settings value)? settings,
  }) {
    return leaveRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(UserAllLeave value)? userAllLeave,
    TResult Function(UserUpcomingLeave value)? userUpcomingLeave,
    TResult Function(LeaveRequest value)? leaveRequest,
    TResult Function(Settings value)? settings,
    required TResult orElse(),
  }) {
    if (leaveRequest != null) {
      return leaveRequest(this);
    }
    return orElse();
  }
}

abstract class LeaveRequest implements AppState {
  const factory LeaveRequest() = _$LeaveRequest;
}

/// @nodoc
abstract class $SettingsCopyWith<$Res> {
  factory $SettingsCopyWith(Settings value, $Res Function(Settings) then) =
      _$SettingsCopyWithImpl<$Res>;
}

/// @nodoc
class _$SettingsCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements $SettingsCopyWith<$Res> {
  _$SettingsCopyWithImpl(Settings _value, $Res Function(Settings) _then)
      : super(_value, (v) => _then(v as Settings));

  @override
  Settings get _value => super._value as Settings;
}

/// @nodoc

class _$Settings implements Settings {
  const _$Settings();

  @override
  String toString() {
    return 'AppState.settings()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Settings);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() home,
    required TResult Function(int id) employeeDetail,
    required TResult Function() leave,
    required TResult Function() userAllLeave,
    required TResult Function() userUpcomingLeave,
    required TResult Function() leaveRequest,
    required TResult Function() settings,
  }) {
    return settings();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int id)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? userAllLeave,
    TResult Function()? userUpcomingLeave,
    TResult Function()? leaveRequest,
    TResult Function()? settings,
  }) {
    return settings?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    TResult Function(int id)? employeeDetail,
    TResult Function()? leave,
    TResult Function()? userAllLeave,
    TResult Function()? userUpcomingLeave,
    TResult Function()? leaveRequest,
    TResult Function()? settings,
    required TResult orElse(),
  }) {
    if (settings != null) {
      return settings();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Home value) home,
    required TResult Function(EmployeeDetail value) employeeDetail,
    required TResult Function(Leave value) leave,
    required TResult Function(UserAllLeave value) userAllLeave,
    required TResult Function(UserUpcomingLeave value) userUpcomingLeave,
    required TResult Function(LeaveRequest value) leaveRequest,
    required TResult Function(Settings value) settings,
  }) {
    return settings(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(UserAllLeave value)? userAllLeave,
    TResult Function(UserUpcomingLeave value)? userUpcomingLeave,
    TResult Function(LeaveRequest value)? leaveRequest,
    TResult Function(Settings value)? settings,
  }) {
    return settings?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Home value)? home,
    TResult Function(EmployeeDetail value)? employeeDetail,
    TResult Function(Leave value)? leave,
    TResult Function(UserAllLeave value)? userAllLeave,
    TResult Function(UserUpcomingLeave value)? userUpcomingLeave,
    TResult Function(LeaveRequest value)? leaveRequest,
    TResult Function(Settings value)? settings,
    required TResult orElse(),
  }) {
    if (settings != null) {
      return settings(this);
    }
    return orElse();
  }
}

abstract class Settings implements AppState {
  const factory Settings() = _$Settings;
}
