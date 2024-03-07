// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AdminMembersState {
  List<Employee> get activeMembers => throw _privateConstructorUsedError;
  List<Employee> get inactiveMembers => throw _privateConstructorUsedError;
  List<Invitation> get invitation => throw _privateConstructorUsedError;
  List<int> get expanded => throw _privateConstructorUsedError;
  Status get memberFetchStatus => throw _privateConstructorUsedError;
  Status get invitationFetchStatus => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AdminMembersStateCopyWith<AdminMembersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminMembersStateCopyWith<$Res> {
  factory $AdminMembersStateCopyWith(
          AdminMembersState value, $Res Function(AdminMembersState) then) =
      _$AdminMembersStateCopyWithImpl<$Res, AdminMembersState>;
  @useResult
  $Res call(
      {List<Employee> activeMembers,
      List<Employee> inactiveMembers,
      List<Invitation> invitation,
      List<int> expanded,
      Status memberFetchStatus,
      Status invitationFetchStatus,
      String? error});
}

/// @nodoc
class _$AdminMembersStateCopyWithImpl<$Res, $Val extends AdminMembersState>
    implements $AdminMembersStateCopyWith<$Res> {
  _$AdminMembersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeMembers = null,
    Object? inactiveMembers = null,
    Object? invitation = null,
    Object? expanded = null,
    Object? memberFetchStatus = null,
    Object? invitationFetchStatus = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      activeMembers: null == activeMembers
          ? _value.activeMembers
          : activeMembers // ignore: cast_nullable_to_non_nullable
              as List<Employee>,
      inactiveMembers: null == inactiveMembers
          ? _value.inactiveMembers
          : inactiveMembers // ignore: cast_nullable_to_non_nullable
              as List<Employee>,
      invitation: null == invitation
          ? _value.invitation
          : invitation // ignore: cast_nullable_to_non_nullable
              as List<Invitation>,
      expanded: null == expanded
          ? _value.expanded
          : expanded // ignore: cast_nullable_to_non_nullable
              as List<int>,
      memberFetchStatus: null == memberFetchStatus
          ? _value.memberFetchStatus
          : memberFetchStatus // ignore: cast_nullable_to_non_nullable
              as Status,
      invitationFetchStatus: null == invitationFetchStatus
          ? _value.invitationFetchStatus
          : invitationFetchStatus // ignore: cast_nullable_to_non_nullable
              as Status,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminMembersStateImplCopyWith<$Res>
    implements $AdminMembersStateCopyWith<$Res> {
  factory _$$AdminMembersStateImplCopyWith(_$AdminMembersStateImpl value,
          $Res Function(_$AdminMembersStateImpl) then) =
      __$$AdminMembersStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Employee> activeMembers,
      List<Employee> inactiveMembers,
      List<Invitation> invitation,
      List<int> expanded,
      Status memberFetchStatus,
      Status invitationFetchStatus,
      String? error});
}

/// @nodoc
class __$$AdminMembersStateImplCopyWithImpl<$Res>
    extends _$AdminMembersStateCopyWithImpl<$Res, _$AdminMembersStateImpl>
    implements _$$AdminMembersStateImplCopyWith<$Res> {
  __$$AdminMembersStateImplCopyWithImpl(_$AdminMembersStateImpl _value,
      $Res Function(_$AdminMembersStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeMembers = null,
    Object? inactiveMembers = null,
    Object? invitation = null,
    Object? expanded = null,
    Object? memberFetchStatus = null,
    Object? invitationFetchStatus = null,
    Object? error = freezed,
  }) {
    return _then(_$AdminMembersStateImpl(
      activeMembers: null == activeMembers
          ? _value._activeMembers
          : activeMembers // ignore: cast_nullable_to_non_nullable
              as List<Employee>,
      inactiveMembers: null == inactiveMembers
          ? _value._inactiveMembers
          : inactiveMembers // ignore: cast_nullable_to_non_nullable
              as List<Employee>,
      invitation: null == invitation
          ? _value._invitation
          : invitation // ignore: cast_nullable_to_non_nullable
              as List<Invitation>,
      expanded: null == expanded
          ? _value._expanded
          : expanded // ignore: cast_nullable_to_non_nullable
              as List<int>,
      memberFetchStatus: null == memberFetchStatus
          ? _value.memberFetchStatus
          : memberFetchStatus // ignore: cast_nullable_to_non_nullable
              as Status,
      invitationFetchStatus: null == invitationFetchStatus
          ? _value.invitationFetchStatus
          : invitationFetchStatus // ignore: cast_nullable_to_non_nullable
              as Status,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AdminMembersStateImpl implements _AdminMembersState {
  const _$AdminMembersStateImpl(
      {final List<Employee> activeMembers = const [],
      final List<Employee> inactiveMembers = const [],
      final List<Invitation> invitation = const [],
      final List<int> expanded = const [],
      this.memberFetchStatus = Status.initial,
      this.invitationFetchStatus = Status.initial,
      this.error})
      : _activeMembers = activeMembers,
        _inactiveMembers = inactiveMembers,
        _invitation = invitation,
        _expanded = expanded;

  final List<Employee> _activeMembers;
  @override
  @JsonKey()
  List<Employee> get activeMembers {
    if (_activeMembers is EqualUnmodifiableListView) return _activeMembers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeMembers);
  }

  final List<Employee> _inactiveMembers;
  @override
  @JsonKey()
  List<Employee> get inactiveMembers {
    if (_inactiveMembers is EqualUnmodifiableListView) return _inactiveMembers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inactiveMembers);
  }

  final List<Invitation> _invitation;
  @override
  @JsonKey()
  List<Invitation> get invitation {
    if (_invitation is EqualUnmodifiableListView) return _invitation;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_invitation);
  }

  final List<int> _expanded;
  @override
  @JsonKey()
  List<int> get expanded {
    if (_expanded is EqualUnmodifiableListView) return _expanded;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expanded);
  }

  @override
  @JsonKey()
  final Status memberFetchStatus;
  @override
  @JsonKey()
  final Status invitationFetchStatus;
  @override
  final String? error;

  @override
  String toString() {
    return 'AdminMembersState(activeMembers: $activeMembers, inactiveMembers: $inactiveMembers, invitation: $invitation, expanded: $expanded, memberFetchStatus: $memberFetchStatus, invitationFetchStatus: $invitationFetchStatus, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminMembersStateImpl &&
            const DeepCollectionEquality()
                .equals(other._activeMembers, _activeMembers) &&
            const DeepCollectionEquality()
                .equals(other._inactiveMembers, _inactiveMembers) &&
            const DeepCollectionEquality()
                .equals(other._invitation, _invitation) &&
            const DeepCollectionEquality().equals(other._expanded, _expanded) &&
            (identical(other.memberFetchStatus, memberFetchStatus) ||
                other.memberFetchStatus == memberFetchStatus) &&
            (identical(other.invitationFetchStatus, invitationFetchStatus) ||
                other.invitationFetchStatus == invitationFetchStatus) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_activeMembers),
      const DeepCollectionEquality().hash(_inactiveMembers),
      const DeepCollectionEquality().hash(_invitation),
      const DeepCollectionEquality().hash(_expanded),
      memberFetchStatus,
      invitationFetchStatus,
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminMembersStateImplCopyWith<_$AdminMembersStateImpl> get copyWith =>
      __$$AdminMembersStateImplCopyWithImpl<_$AdminMembersStateImpl>(
          this, _$identity);
}

abstract class _AdminMembersState implements AdminMembersState {
  const factory _AdminMembersState(
      {final List<Employee> activeMembers,
      final List<Employee> inactiveMembers,
      final List<Invitation> invitation,
      final List<int> expanded,
      final Status memberFetchStatus,
      final Status invitationFetchStatus,
      final String? error}) = _$AdminMembersStateImpl;

  @override
  List<Employee> get activeMembers;
  @override
  List<Employee> get inactiveMembers;
  @override
  List<Invitation> get invitation;
  @override
  List<int> get expanded;
  @override
  Status get memberFetchStatus;
  @override
  Status get invitationFetchStatus;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$AdminMembersStateImplCopyWith<_$AdminMembersStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
