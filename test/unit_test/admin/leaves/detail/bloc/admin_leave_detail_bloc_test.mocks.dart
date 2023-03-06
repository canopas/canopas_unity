// Mocks generated by Mockito 5.3.2 from annotations
// in projectunity/test/unit_test/admin/leaves/detail/bloc/admin_leave_detail_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:ui' as _i8;

import 'package:mockito/mockito.dart' as _i1;
import 'package:projectunity/model/employee/employee.dart' as _i2;
import 'package:projectunity/model/leave/leave.dart' as _i5;
import 'package:projectunity/provider/user_data.dart' as _i7;
import 'package:projectunity/services/admin/leave_service.dart' as _i6;
import 'package:projectunity/services/admin/paid_leave_service.dart' as _i9;
import 'package:projectunity/services/user/user_leave_service.dart' as _i3;

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

class _FakeEmployee_0 extends _i1.SmartFake implements _i2.Employee {
  _FakeEmployee_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [UserLeaveService].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserLeaveService extends _i1.Mock implements _i3.UserLeaveService {
  MockUserLeaveService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> applyForLeave(_i5.Leave? leaveRequestData) =>
      (super.noSuchMethod(
        Invocation.method(
          #applyForLeave,
          [leaveRequestData],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<List<_i5.Leave>> getAllLeavesOfUser(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllLeavesOfUser,
          [id],
        ),
        returnValue: _i4.Future<List<_i5.Leave>>.value(<_i5.Leave>[]),
      ) as _i4.Future<List<_i5.Leave>>);
  @override
  _i4.Future<List<_i5.Leave>> getPastLeavesOfUser({
    required String? id,
    required List<_i5.Leave>? previousLeaves,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPastLeavesOfUser,
          [],
          {
            #id: id,
            #previousLeaves: previousLeaves,
          },
        ),
        returnValue: _i4.Future<List<_i5.Leave>>.value(<_i5.Leave>[]),
      ) as _i4.Future<List<_i5.Leave>>);
  @override
  _i4.Future<List<_i5.Leave>> getRequestedLeave(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getRequestedLeave,
          [id],
        ),
        returnValue: _i4.Future<List<_i5.Leave>>.value(<_i5.Leave>[]),
      ) as _i4.Future<List<_i5.Leave>>);
  @override
  _i4.Future<List<_i5.Leave>> getUpcomingLeaves(String? employeeId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUpcomingLeaves,
          [employeeId],
        ),
        returnValue: _i4.Future<List<_i5.Leave>>.value(<_i5.Leave>[]),
      ) as _i4.Future<List<_i5.Leave>>);
  @override
  _i4.Future<void> deleteLeaveRequest(String? leaveId) => (super.noSuchMethod(
        Invocation.method(
          #deleteLeaveRequest,
          [leaveId],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<double> getUserUsedLeaveCount(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getUserUsedLeaveCount,
          [id],
        ),
        returnValue: _i4.Future<double>.value(0.0),
      ) as _i4.Future<double>);
  @override
  _i4.Future<void> deleteAllLeaves(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteAllLeaves,
          [id],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<_i5.Leave?> fetchLeave(String? id) => (super.noSuchMethod(
        Invocation.method(
          #fetchLeave,
          [id],
        ),
        returnValue: _i4.Future<_i5.Leave?>.value(),
      ) as _i4.Future<_i5.Leave?>);
}

/// A class which mocks [AdminLeaveService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAdminLeaveService extends _i1.Mock implements _i6.AdminLeaveService {
  MockAdminLeaveService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Stream<List<_i5.Leave>> get leaves => (super.noSuchMethod(
        Invocation.getter(#leaves),
        returnValue: _i4.Stream<List<_i5.Leave>>.empty(),
      ) as _i4.Stream<List<_i5.Leave>>);
  @override
  void fetchLeaves() => super.noSuchMethod(
        Invocation.method(
          #fetchLeaves,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Future<List<_i5.Leave>> getRecentLeaves() => (super.noSuchMethod(
        Invocation.method(
          #getRecentLeaves,
          [],
        ),
        returnValue: _i4.Future<List<_i5.Leave>>.value(<_i5.Leave>[]),
      ) as _i4.Future<List<_i5.Leave>>);
  @override
  _i4.Future<List<_i5.Leave>> getUpcomingLeaves() => (super.noSuchMethod(
        Invocation.method(
          #getUpcomingLeaves,
          [],
        ),
        returnValue: _i4.Future<List<_i5.Leave>>.value(<_i5.Leave>[]),
      ) as _i4.Future<List<_i5.Leave>>);
  @override
  _i4.Future<void> updateLeaveStatus(
    String? id,
    Map<String, dynamic>? map,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateLeaveStatus,
          [
            id,
            map,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<List<_i5.Leave>> getAllLeaves() => (super.noSuchMethod(
        Invocation.method(
          #getAllLeaves,
          [],
        ),
        returnValue: _i4.Future<List<_i5.Leave>>.value(<_i5.Leave>[]),
      ) as _i4.Future<List<_i5.Leave>>);
  @override
  _i4.Future<List<_i5.Leave>> getAllAbsence({DateTime? date}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllAbsence,
          [],
          {#date: date},
        ),
        returnValue: _i4.Future<List<_i5.Leave>>.value(<_i5.Leave>[]),
      ) as _i4.Future<List<_i5.Leave>>);
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [UserManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserManager extends _i1.Mock implements _i7.UserManager {
  MockUserManager() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get loggedIn => (super.noSuchMethod(
        Invocation.getter(#loggedIn),
        returnValue: false,
      ) as bool);
  @override
  set loggedIn(bool? _loggedIn) => super.noSuchMethod(
        Invocation.setter(
          #loggedIn,
          _loggedIn,
        ),
        returnValueForMissingStub: null,
      );
  @override
  String get userName => (super.noSuchMethod(
        Invocation.getter(#userName),
        returnValue: '',
      ) as String);
  @override
  String get email => (super.noSuchMethod(
        Invocation.getter(#email),
        returnValue: '',
      ) as String);
  @override
  String get employeeId => (super.noSuchMethod(
        Invocation.getter(#employeeId),
        returnValue: '',
      ) as String);
  @override
  _i2.Employee get employee => (super.noSuchMethod(
        Invocation.getter(#employee),
        returnValue: _FakeEmployee_0(
          this,
          Invocation.getter(#employee),
        ),
      ) as _i2.Employee);
  @override
  String get employeeDesignation => (super.noSuchMethod(
        Invocation.getter(#employeeDesignation),
        returnValue: '',
      ) as String);
  @override
  bool get isAdmin => (super.noSuchMethod(
        Invocation.getter(#isAdmin),
        returnValue: false,
      ) as bool);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  void hasLoggedIn() => super.noSuchMethod(
        Invocation.method(
          #hasLoggedIn,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addListener(_i8.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i8.VoidCallback? listener) => super.noSuchMethod(
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

/// A class which mocks [PaidLeaveService].
///
/// See the documentation for Mockito's code generation for more information.
class MockPaidLeaveService extends _i1.Mock implements _i9.PaidLeaveService {
  MockPaidLeaveService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<int> getPaidLeaves() => (super.noSuchMethod(
        Invocation.method(
          #getPaidLeaves,
          [],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
  @override
  _i4.Future<void> updateLeaveCount(int? leaveCount) => (super.noSuchMethod(
        Invocation.method(
          #updateLeaveCount,
          [leaveCount],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
