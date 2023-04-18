// Mocks generated by Mockito 5.3.2 from annotations
// in projectunity/test/unit_test/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:ui' as _i9;

import 'package:mockito/mockito.dart' as _i1;
import 'package:projectunity/data/model/employee/employee.dart' as _i2;
import 'package:projectunity/data/model/leave/leave.dart' as _i6;
import 'package:projectunity/data/model/space/space.dart' as _i3;
import 'package:projectunity/data/model/user/user.dart' as _i8;
import 'package:projectunity/data/provider/user_data.dart' as _i7;
import 'package:projectunity/data/services/leave_service.dart' as _i4;
import 'package:projectunity/data/services/space_service.dart' as _i10;

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

class _FakeSpace_1 extends _i1.SmartFake implements _i3.Space {
  _FakeSpace_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LeaveService].
///
/// See the documentation for Mockito's code generation for more information.
class MockLeaveService extends _i1.Mock implements _i4.LeaveService {
  MockLeaveService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i6.Leave>> getLeaveRequestOfUsers() => (super.noSuchMethod(
        Invocation.method(
          #getLeaveRequestOfUsers,
          [],
        ),
        returnValue: _i5.Future<List<_i6.Leave>>.value(<_i6.Leave>[]),
      ) as _i5.Future<List<_i6.Leave>>);
  @override
  _i5.Future<bool> checkLeaveAlreadyApplied({
    required String? userId,
    required Map<DateTime, int>? dateDuration,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #checkLeaveAlreadyApplied,
          [],
          {
            #userId: userId,
            #dateDuration: dateDuration,
          },
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i5.Future<List<_i6.Leave>> getRecentLeaves() => (super.noSuchMethod(
        Invocation.method(
          #getRecentLeaves,
          [],
        ),
        returnValue: _i5.Future<List<_i6.Leave>>.value(<_i6.Leave>[]),
      ) as _i5.Future<List<_i6.Leave>>);
  @override
  _i5.Future<List<_i6.Leave>> getUpcomingLeaves() => (super.noSuchMethod(
        Invocation.method(
          #getUpcomingLeaves,
          [],
        ),
        returnValue: _i5.Future<List<_i6.Leave>>.value(<_i6.Leave>[]),
      ) as _i5.Future<List<_i6.Leave>>);
  @override
  _i5.Future<void> updateLeaveStatus(
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
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<List<_i6.Leave>> getAllLeaves() => (super.noSuchMethod(
        Invocation.method(
          #getAllLeaves,
          [],
        ),
        returnValue: _i5.Future<List<_i6.Leave>>.value(<_i6.Leave>[]),
      ) as _i5.Future<List<_i6.Leave>>);
  @override
  _i5.Future<List<_i6.Leave>> getAllAbsence({DateTime? date}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllAbsence,
          [],
          {#date: date},
        ),
        returnValue: _i5.Future<List<_i6.Leave>>.value(<_i6.Leave>[]),
      ) as _i5.Future<List<_i6.Leave>>);
  @override
  _i5.Future<void> applyForLeave(_i6.Leave? leaveRequestData) =>
      (super.noSuchMethod(
        Invocation.method(
          #applyForLeave,
          [leaveRequestData],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<List<_i6.Leave>> getAllLeavesOfUser(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllLeavesOfUser,
          [id],
        ),
        returnValue: _i5.Future<List<_i6.Leave>>.value(<_i6.Leave>[]),
      ) as _i5.Future<List<_i6.Leave>>);
  @override
  _i5.Future<List<_i6.Leave>> getRecentLeavesOfUser(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getRecentLeavesOfUser,
          [id],
        ),
        returnValue: _i5.Future<List<_i6.Leave>>.value(<_i6.Leave>[]),
      ) as _i5.Future<List<_i6.Leave>>);
  @override
  _i5.Future<List<_i6.Leave>> getPastLeavesOfUser(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPastLeavesOfUser,
          [id],
        ),
        returnValue: _i5.Future<List<_i6.Leave>>.value(<_i6.Leave>[]),
      ) as _i5.Future<List<_i6.Leave>>);
  @override
  _i5.Future<List<_i6.Leave>> getRequestedLeave(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getRequestedLeave,
          [id],
        ),
        returnValue: _i5.Future<List<_i6.Leave>>.value(<_i6.Leave>[]),
      ) as _i5.Future<List<_i6.Leave>>);
  @override
  _i5.Future<List<_i6.Leave>> getUpcomingLeavesOfUser(String? employeeId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUpcomingLeavesOfUser,
          [employeeId],
        ),
        returnValue: _i5.Future<List<_i6.Leave>>.value(<_i6.Leave>[]),
      ) as _i5.Future<List<_i6.Leave>>);
  @override
  _i5.Future<void> deleteLeaveRequest(String? leaveId) => (super.noSuchMethod(
        Invocation.method(
          #deleteLeaveRequest,
          [leaveId],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<double> getUserUsedLeaves(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getUserUsedLeaves,
          [id],
        ),
        returnValue: _i5.Future<double>.value(0.0),
      ) as _i5.Future<double>);
  @override
  _i5.Future<void> deleteAllLeavesOfUser(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteAllLeavesOfUser,
          [id],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<_i6.Leave?> fetchLeave(String? id) => (super.noSuchMethod(
        Invocation.method(
          #fetchLeave,
          [id],
        ),
        returnValue: _i5.Future<_i6.Leave?>.value(),
      ) as _i5.Future<_i6.Leave?>);
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
  bool get spaceSelected => (super.noSuchMethod(
        Invocation.getter(#spaceSelected),
        returnValue: false,
      ) as bool);
  @override
  set spaceSelected(bool? _spaceSelected) => super.noSuchMethod(
        Invocation.setter(
          #spaceSelected,
          _spaceSelected,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get spaceUserExist => (super.noSuchMethod(
        Invocation.getter(#spaceUserExist),
        returnValue: false,
      ) as bool);
  @override
  set spaceUserExist(bool? _spaceUserExist) => super.noSuchMethod(
        Invocation.setter(
          #spaceUserExist,
          _spaceUserExist,
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
  _i5.Future<void> setUser(_i8.User? user) => (super.noSuchMethod(
        Invocation.method(
          #setUser,
          [user],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> setSpace({
    required _i3.Space? space,
    required _i2.Employee? admin,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #setSpace,
          [],
          {
            #space: space,
            #admin: admin,
          },
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> updateSpaceDetails(_i3.Space? space) => (super.noSuchMethod(
        Invocation.method(
          #updateSpaceDetails,
          [space],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> removeSpace() => (super.noSuchMethod(
        Invocation.method(
          #removeSpace,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> removeAll() => (super.noSuchMethod(
        Invocation.method(
          #removeAll,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  void hasLoggedIn() => super.noSuchMethod(
        Invocation.method(
          #hasLoggedIn,
          [],
        ),
        returnValueForMissingStub: null,
      );
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

/// A class which mocks [SpaceService].
///
/// See the documentation for Mockito's code generation for more information.
class MockSpaceService extends _i1.Mock implements _i10.SpaceService {
  MockSpaceService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.Space?> getSpace(String? spaceId) => (super.noSuchMethod(
        Invocation.method(
          #getSpace,
          [spaceId],
        ),
        returnValue: _i5.Future<_i3.Space?>.value(),
      ) as _i5.Future<_i3.Space?>);
  @override
  _i5.Future<_i3.Space> createSpace({
    required String? name,
    required String? domain,
    required int? timeOff,
    required String? ownerId,
    required String? ownerEmail,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #createSpace,
          [],
          {
            #name: name,
            #domain: domain,
            #timeOff: timeOff,
            #ownerId: ownerId,
            #ownerEmail: ownerEmail,
          },
        ),
        returnValue: _i5.Future<_i3.Space>.value(_FakeSpace_1(
          this,
          Invocation.method(
            #createSpace,
            [],
            {
              #name: name,
              #domain: domain,
              #timeOff: timeOff,
              #ownerId: ownerId,
              #ownerEmail: ownerEmail,
            },
          ),
        )),
      ) as _i5.Future<_i3.Space>);
  @override
  _i5.Future<void> updateSpace(_i3.Space? space) => (super.noSuchMethod(
        Invocation.method(
          #updateSpace,
          [space],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> deleteSpace(
    String? workspaceId,
    List<String>? owners,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteSpace,
          [
            workspaceId,
            owners,
          ],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<List<_i3.Space>> getSpacesOfUser(String? uid) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSpacesOfUser,
          [uid],
        ),
        returnValue: _i5.Future<List<_i3.Space>>.value(<_i3.Space>[]),
      ) as _i5.Future<List<_i3.Space>>);
  @override
  _i5.Future<int> getPaidLeaves({required String? spaceId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPaidLeaves,
          [],
          {#spaceId: spaceId},
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);
  @override
  _i5.Future<void> updateLeaveCount({
    required String? spaceId,
    required int? paidLeaveCount,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateLeaveCount,
          [],
          {
            #spaceId: spaceId,
            #paidLeaveCount: paidLeaveCount,
          },
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}
