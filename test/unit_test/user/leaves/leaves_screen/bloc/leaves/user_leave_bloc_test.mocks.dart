// Mocks generated by Mockito 5.4.0 from annotations
// in projectunity/test/unit_test/user/leaves/leaves_screen/bloc/leaves/user_leave_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;
import 'dart:ui' as _i9;

import 'package:mockito/mockito.dart' as _i1;
import 'package:projectunity/data/model/account/account.dart' as _i6;
import 'package:projectunity/data/model/employee/employee.dart' as _i8;
import 'package:projectunity/data/model/leave/leave.dart' as _i4;
import 'package:projectunity/data/model/space/space.dart' as _i7;
import 'package:projectunity/data/provider/user_state.dart' as _i5;
import 'package:projectunity/data/Repo/leave_repo.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [LeaveRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockLeaveRepo extends _i1.Mock implements _i2.LeaveRepo {
  MockLeaveRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Stream<List<_i4.Leave>> get leaves => (super.noSuchMethod(
        Invocation.getter(#leaves),
        returnValue: _i3.Stream<List<_i4.Leave>>.empty(),
      ) as _i3.Stream<List<_i4.Leave>>);
  @override
  _i3.Stream<List<_i4.Leave>> get pendingLeaves => (super.noSuchMethod(
        Invocation.getter(#pendingLeaves),
        returnValue: _i3.Stream<List<_i4.Leave>>.empty(),
      ) as _i3.Stream<List<_i4.Leave>>);
  @override
  _i3.Stream<List<_i4.Leave>> absence(DateTime? date) => (super.noSuchMethod(
        Invocation.method(
          #absence,
          [date],
        ),
        returnValue: _i3.Stream<List<_i4.Leave>>.empty(),
      ) as _i3.Stream<List<_i4.Leave>>);
  @override
  _i3.Future<void> reset() => (super.noSuchMethod(
        Invocation.method(
          #reset,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Stream<List<_i4.Leave>> userLeaveRequest(String? uid) =>
      (super.noSuchMethod(
        Invocation.method(
          #userLeaveRequest,
          [uid],
        ),
        returnValue: _i3.Stream<List<_i4.Leave>>.empty(),
      ) as _i3.Stream<List<_i4.Leave>>);
  @override
  _i3.Stream<List<_i4.Leave>> userLeaves(String? uid) => (super.noSuchMethod(
        Invocation.method(
          #userLeaves,
          [uid],
        ),
        returnValue: _i3.Stream<List<_i4.Leave>>.empty(),
      ) as _i3.Stream<List<_i4.Leave>>);
  @override
  _i3.Future<void> cancel() => (super.noSuchMethod(
        Invocation.method(
          #cancel,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> dispose() => (super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}

/// A class which mocks [UserStateNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserStateNotifier extends _i1.Mock implements _i5.UserStateNotifier {
  MockUserStateNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.UserState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i5.UserState.authenticated,
      ) as _i5.UserState);
  @override
  String get employeeId => (super.noSuchMethod(
        Invocation.getter(#employeeId),
        returnValue: '',
      ) as String);
  @override
  bool get isAdmin => (super.noSuchMethod(
        Invocation.getter(#isAdmin),
        returnValue: false,
      ) as bool);
  @override
  bool get isEmployee => (super.noSuchMethod(
        Invocation.getter(#isEmployee),
        returnValue: false,
      ) as bool);
  @override
  bool get isSpaceOwner => (super.noSuchMethod(
        Invocation.getter(#isSpaceOwner),
        returnValue: false,
      ) as bool);
  @override
  bool get isHR => (super.noSuchMethod(
        Invocation.getter(#isHR),
        returnValue: false,
      ) as bool);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  void getUserStatus() => super.noSuchMethod(
        Invocation.method(
          #getUserStatus,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.Future<void> setUser(_i6.Account? user) => (super.noSuchMethod(
        Invocation.method(
          #setUser,
          [user],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> setEmployeeWithSpace({
    required _i7.Space? space,
    required _i8.Employee? spaceUser,
    bool? redirect = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #setEmployeeWithSpace,
          [],
          {
            #space: space,
            #spaceUser: spaceUser,
            #redirect: redirect,
          },
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> resetStreamSubscription() => (super.noSuchMethod(
        Invocation.method(
          #resetStreamSubscription,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> updateCurrentUser(_i8.Employee? user) => (super.noSuchMethod(
        Invocation.method(
          #updateCurrentUser,
          [user],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> updateSpace(_i7.Space? space) => (super.noSuchMethod(
        Invocation.method(
          #updateSpace,
          [space],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> removeEmployeeWithSpace() => (super.noSuchMethod(
        Invocation.method(
          #removeEmployeeWithSpace,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> removeAll() => (super.noSuchMethod(
        Invocation.method(
          #removeAll,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  void addListener(_i9.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i9.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
