// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminMembersState {

 List<Employee> get activeMembers; List<Employee> get inactiveMembers; List<Invitation> get invitation; List<int> get expanded; Status get memberFetchStatus; Status get invitationFetchStatus; String? get error;
/// Create a copy of AdminMembersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminMembersStateCopyWith<AdminMembersState> get copyWith => _$AdminMembersStateCopyWithImpl<AdminMembersState>(this as AdminMembersState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminMembersState&&const DeepCollectionEquality().equals(other.activeMembers, activeMembers)&&const DeepCollectionEquality().equals(other.inactiveMembers, inactiveMembers)&&const DeepCollectionEquality().equals(other.invitation, invitation)&&const DeepCollectionEquality().equals(other.expanded, expanded)&&(identical(other.memberFetchStatus, memberFetchStatus) || other.memberFetchStatus == memberFetchStatus)&&(identical(other.invitationFetchStatus, invitationFetchStatus) || other.invitationFetchStatus == invitationFetchStatus)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(activeMembers),const DeepCollectionEquality().hash(inactiveMembers),const DeepCollectionEquality().hash(invitation),const DeepCollectionEquality().hash(expanded),memberFetchStatus,invitationFetchStatus,error);

@override
String toString() {
  return 'AdminMembersState(activeMembers: $activeMembers, inactiveMembers: $inactiveMembers, invitation: $invitation, expanded: $expanded, memberFetchStatus: $memberFetchStatus, invitationFetchStatus: $invitationFetchStatus, error: $error)';
}


}

/// @nodoc
abstract mixin class $AdminMembersStateCopyWith<$Res>  {
  factory $AdminMembersStateCopyWith(AdminMembersState value, $Res Function(AdminMembersState) _then) = _$AdminMembersStateCopyWithImpl;
@useResult
$Res call({
 List<Employee> activeMembers, List<Employee> inactiveMembers, List<Invitation> invitation, List<int> expanded, Status memberFetchStatus, Status invitationFetchStatus, String? error
});




}
/// @nodoc
class _$AdminMembersStateCopyWithImpl<$Res>
    implements $AdminMembersStateCopyWith<$Res> {
  _$AdminMembersStateCopyWithImpl(this._self, this._then);

  final AdminMembersState _self;
  final $Res Function(AdminMembersState) _then;

/// Create a copy of AdminMembersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activeMembers = null,Object? inactiveMembers = null,Object? invitation = null,Object? expanded = null,Object? memberFetchStatus = null,Object? invitationFetchStatus = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
activeMembers: null == activeMembers ? _self.activeMembers : activeMembers // ignore: cast_nullable_to_non_nullable
as List<Employee>,inactiveMembers: null == inactiveMembers ? _self.inactiveMembers : inactiveMembers // ignore: cast_nullable_to_non_nullable
as List<Employee>,invitation: null == invitation ? _self.invitation : invitation // ignore: cast_nullable_to_non_nullable
as List<Invitation>,expanded: null == expanded ? _self.expanded : expanded // ignore: cast_nullable_to_non_nullable
as List<int>,memberFetchStatus: null == memberFetchStatus ? _self.memberFetchStatus : memberFetchStatus // ignore: cast_nullable_to_non_nullable
as Status,invitationFetchStatus: null == invitationFetchStatus ? _self.invitationFetchStatus : invitationFetchStatus // ignore: cast_nullable_to_non_nullable
as Status,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminMembersState].
extension AdminMembersStatePatterns on AdminMembersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminMembersState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminMembersState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminMembersState value)  $default,){
final _that = this;
switch (_that) {
case _AdminMembersState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminMembersState value)?  $default,){
final _that = this;
switch (_that) {
case _AdminMembersState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Employee> activeMembers,  List<Employee> inactiveMembers,  List<Invitation> invitation,  List<int> expanded,  Status memberFetchStatus,  Status invitationFetchStatus,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminMembersState() when $default != null:
return $default(_that.activeMembers,_that.inactiveMembers,_that.invitation,_that.expanded,_that.memberFetchStatus,_that.invitationFetchStatus,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Employee> activeMembers,  List<Employee> inactiveMembers,  List<Invitation> invitation,  List<int> expanded,  Status memberFetchStatus,  Status invitationFetchStatus,  String? error)  $default,) {final _that = this;
switch (_that) {
case _AdminMembersState():
return $default(_that.activeMembers,_that.inactiveMembers,_that.invitation,_that.expanded,_that.memberFetchStatus,_that.invitationFetchStatus,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Employee> activeMembers,  List<Employee> inactiveMembers,  List<Invitation> invitation,  List<int> expanded,  Status memberFetchStatus,  Status invitationFetchStatus,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _AdminMembersState() when $default != null:
return $default(_that.activeMembers,_that.inactiveMembers,_that.invitation,_that.expanded,_that.memberFetchStatus,_that.invitationFetchStatus,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _AdminMembersState implements AdminMembersState {
  const _AdminMembersState({final  List<Employee> activeMembers = const [], final  List<Employee> inactiveMembers = const [], final  List<Invitation> invitation = const [], final  List<int> expanded = const [], this.memberFetchStatus = Status.initial, this.invitationFetchStatus = Status.initial, this.error}): _activeMembers = activeMembers,_inactiveMembers = inactiveMembers,_invitation = invitation,_expanded = expanded;
  

 final  List<Employee> _activeMembers;
@override@JsonKey() List<Employee> get activeMembers {
  if (_activeMembers is EqualUnmodifiableListView) return _activeMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activeMembers);
}

 final  List<Employee> _inactiveMembers;
@override@JsonKey() List<Employee> get inactiveMembers {
  if (_inactiveMembers is EqualUnmodifiableListView) return _inactiveMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_inactiveMembers);
}

 final  List<Invitation> _invitation;
@override@JsonKey() List<Invitation> get invitation {
  if (_invitation is EqualUnmodifiableListView) return _invitation;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_invitation);
}

 final  List<int> _expanded;
@override@JsonKey() List<int> get expanded {
  if (_expanded is EqualUnmodifiableListView) return _expanded;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_expanded);
}

@override@JsonKey() final  Status memberFetchStatus;
@override@JsonKey() final  Status invitationFetchStatus;
@override final  String? error;

/// Create a copy of AdminMembersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminMembersStateCopyWith<_AdminMembersState> get copyWith => __$AdminMembersStateCopyWithImpl<_AdminMembersState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminMembersState&&const DeepCollectionEquality().equals(other._activeMembers, _activeMembers)&&const DeepCollectionEquality().equals(other._inactiveMembers, _inactiveMembers)&&const DeepCollectionEquality().equals(other._invitation, _invitation)&&const DeepCollectionEquality().equals(other._expanded, _expanded)&&(identical(other.memberFetchStatus, memberFetchStatus) || other.memberFetchStatus == memberFetchStatus)&&(identical(other.invitationFetchStatus, invitationFetchStatus) || other.invitationFetchStatus == invitationFetchStatus)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_activeMembers),const DeepCollectionEquality().hash(_inactiveMembers),const DeepCollectionEquality().hash(_invitation),const DeepCollectionEquality().hash(_expanded),memberFetchStatus,invitationFetchStatus,error);

@override
String toString() {
  return 'AdminMembersState(activeMembers: $activeMembers, inactiveMembers: $inactiveMembers, invitation: $invitation, expanded: $expanded, memberFetchStatus: $memberFetchStatus, invitationFetchStatus: $invitationFetchStatus, error: $error)';
}


}

/// @nodoc
abstract mixin class _$AdminMembersStateCopyWith<$Res> implements $AdminMembersStateCopyWith<$Res> {
  factory _$AdminMembersStateCopyWith(_AdminMembersState value, $Res Function(_AdminMembersState) _then) = __$AdminMembersStateCopyWithImpl;
@override @useResult
$Res call({
 List<Employee> activeMembers, List<Employee> inactiveMembers, List<Invitation> invitation, List<int> expanded, Status memberFetchStatus, Status invitationFetchStatus, String? error
});




}
/// @nodoc
class __$AdminMembersStateCopyWithImpl<$Res>
    implements _$AdminMembersStateCopyWith<$Res> {
  __$AdminMembersStateCopyWithImpl(this._self, this._then);

  final _AdminMembersState _self;
  final $Res Function(_AdminMembersState) _then;

/// Create a copy of AdminMembersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activeMembers = null,Object? inactiveMembers = null,Object? invitation = null,Object? expanded = null,Object? memberFetchStatus = null,Object? invitationFetchStatus = null,Object? error = freezed,}) {
  return _then(_AdminMembersState(
activeMembers: null == activeMembers ? _self._activeMembers : activeMembers // ignore: cast_nullable_to_non_nullable
as List<Employee>,inactiveMembers: null == inactiveMembers ? _self._inactiveMembers : inactiveMembers // ignore: cast_nullable_to_non_nullable
as List<Employee>,invitation: null == invitation ? _self._invitation : invitation // ignore: cast_nullable_to_non_nullable
as List<Invitation>,expanded: null == expanded ? _self._expanded : expanded // ignore: cast_nullable_to_non_nullable
as List<int>,memberFetchStatus: null == memberFetchStatus ? _self.memberFetchStatus : memberFetchStatus // ignore: cast_nullable_to_non_nullable
as Status,invitationFetchStatus: null == invitationFetchStatus ? _self.invitationFetchStatus : invitationFetchStatus // ignore: cast_nullable_to_non_nullable
as Status,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
