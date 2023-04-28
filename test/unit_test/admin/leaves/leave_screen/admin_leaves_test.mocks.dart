// Mocks generated by Mockito 5.4.0 from annotations
// in projectunity/test/unit_test/admin/leaves/leave_screen/admin_leaves_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:cloud_firestore/cloud_firestore.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:projectunity/data/model/employee/employee.dart' as _i5;
import 'package:projectunity/data/model/leave/leave.dart' as _i7;
import 'package:projectunity/data/services/employee_service.dart' as _i3;
import 'package:projectunity/data/services/leave_service.dart' as _i6;

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

class _FakeFirebaseFirestore_0 extends _i1.SmartFake
    implements _i2.FirebaseFirestore {
  _FakeFirebaseFirestore_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [EmployeeService].
///
/// See the documentation for Mockito's code generation for more information.
class MockEmployeeService extends _i1.Mock implements _i3.EmployeeService {
  MockEmployeeService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.FirebaseFirestore get fireStore => (super.noSuchMethod(
        Invocation.getter(#fireStore),
        returnValue: _FakeFirebaseFirestore_0(
          this,
          Invocation.getter(#fireStore),
        ),
      ) as _i2.FirebaseFirestore);
  @override
  _i4.Future<void> addEmployeeBySpaceId({
    required _i5.Employee? employee,
    required String? spaceId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addEmployeeBySpaceId,
          [],
          {
            #employee: employee,
            #spaceId: spaceId,
          },
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<_i5.Employee?> getEmployeeBySpaceId({
    required String? userId,
    required String? spaceId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getEmployeeBySpaceId,
          [],
          {
            #userId: userId,
            #spaceId: spaceId,
          },
        ),
        returnValue: _i4.Future<_i5.Employee?>.value(),
      ) as _i4.Future<_i5.Employee?>);
  @override
  _i4.Future<List<_i5.Employee>> getEmployees() => (super.noSuchMethod(
        Invocation.method(
          #getEmployees,
          [],
        ),
        returnValue: _i4.Future<List<_i5.Employee>>.value(<_i5.Employee>[]),
      ) as _i4.Future<List<_i5.Employee>>);
  @override
  _i4.Future<_i5.Employee?> getEmployee(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getEmployee,
          [id],
        ),
        returnValue: _i4.Future<_i5.Employee?>.value(),
      ) as _i4.Future<_i5.Employee?>);
  @override
  _i4.Future<bool> hasUser(String? email) => (super.noSuchMethod(
        Invocation.method(
          #hasUser,
          [email],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<void> addEmployee(_i5.Employee? employee) => (super.noSuchMethod(
        Invocation.method(
          #addEmployee,
          [employee],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> updateEmployeeDetails({required _i5.Employee? employee}) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateEmployeeDetails,
          [],
          {#employee: employee},
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> changeEmployeeRoleType(
    String? id,
    _i5.Role? role,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #changeEmployeeRoleType,
          [
            id,
            role,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> deleteEmployee(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteEmployee,
          [id],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [LeaveService].
///
/// See the documentation for Mockito's code generation for more information.
class MockLeaveService extends _i1.Mock implements _i6.LeaveService {
  MockLeaveService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.FirebaseFirestore get fireStore => (super.noSuchMethod(
        Invocation.getter(#fireStore),
        returnValue: _FakeFirebaseFirestore_0(
          this,
          Invocation.getter(#fireStore),
        ),
      ) as _i2.FirebaseFirestore);
  @override
  set fireStore(_i2.FirebaseFirestore? _fireStore) => super.noSuchMethod(
        Invocation.setter(
          #fireStore,
          _fireStore,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Future<List<_i7.Leave>> getLeaveRequestOfUsers() => (super.noSuchMethod(
        Invocation.method(
          #getLeaveRequestOfUsers,
          [],
        ),
        returnValue: _i4.Future<List<_i7.Leave>>.value(<_i7.Leave>[]),
      ) as _i4.Future<List<_i7.Leave>>);
  @override
  _i4.Future<bool> checkLeaveAlreadyApplied({
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
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<List<_i7.Leave>> getRecentLeaves() => (super.noSuchMethod(
        Invocation.method(
          #getRecentLeaves,
          [],
        ),
        returnValue: _i4.Future<List<_i7.Leave>>.value(<_i7.Leave>[]),
      ) as _i4.Future<List<_i7.Leave>>);
  @override
  _i4.Future<List<_i7.Leave>> getUpcomingLeaves() => (super.noSuchMethod(
        Invocation.method(
          #getUpcomingLeaves,
          [],
        ),
        returnValue: _i4.Future<List<_i7.Leave>>.value(<_i7.Leave>[]),
      ) as _i4.Future<List<_i7.Leave>>);
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
  _i4.Future<List<_i7.Leave>> getAllLeaves() => (super.noSuchMethod(
        Invocation.method(
          #getAllLeaves,
          [],
        ),
        returnValue: _i4.Future<List<_i7.Leave>>.value(<_i7.Leave>[]),
      ) as _i4.Future<List<_i7.Leave>>);
  @override
  _i4.Future<List<_i7.Leave>> getAllAbsence({DateTime? date}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllAbsence,
          [],
          {#date: date},
        ),
        returnValue: _i4.Future<List<_i7.Leave>>.value(<_i7.Leave>[]),
      ) as _i4.Future<List<_i7.Leave>>);
  @override
  _i4.Future<void> applyForLeave(_i7.Leave? leaveRequestData) =>
      (super.noSuchMethod(
        Invocation.method(
          #applyForLeave,
          [leaveRequestData],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<List<_i7.Leave>> getAllLeavesOfUser(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllLeavesOfUser,
          [id],
        ),
        returnValue: _i4.Future<List<_i7.Leave>>.value(<_i7.Leave>[]),
      ) as _i4.Future<List<_i7.Leave>>);
  @override
  _i4.Future<List<_i7.Leave>> getRecentLeavesOfUser(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getRecentLeavesOfUser,
          [id],
        ),
        returnValue: _i4.Future<List<_i7.Leave>>.value(<_i7.Leave>[]),
      ) as _i4.Future<List<_i7.Leave>>);
  @override
  _i4.Future<List<_i7.Leave>> getPastLeavesOfUser(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPastLeavesOfUser,
          [id],
        ),
        returnValue: _i4.Future<List<_i7.Leave>>.value(<_i7.Leave>[]),
      ) as _i4.Future<List<_i7.Leave>>);
  @override
  _i4.Future<List<_i7.Leave>> getRequestedLeave(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getRequestedLeave,
          [id],
        ),
        returnValue: _i4.Future<List<_i7.Leave>>.value(<_i7.Leave>[]),
      ) as _i4.Future<List<_i7.Leave>>);
  @override
  _i4.Future<List<_i7.Leave>> getUpcomingLeavesOfUser(String? employeeId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUpcomingLeavesOfUser,
          [employeeId],
        ),
        returnValue: _i4.Future<List<_i7.Leave>>.value(<_i7.Leave>[]),
      ) as _i4.Future<List<_i7.Leave>>);
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
  _i4.Future<double> getUserUsedLeaves(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getUserUsedLeaves,
          [id],
        ),
        returnValue: _i4.Future<double>.value(0.0),
      ) as _i4.Future<double>);
  @override
  _i4.Future<void> deleteAllLeavesOfUser(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteAllLeavesOfUser,
          [id],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<_i7.Leave?> fetchLeave(String? id) => (super.noSuchMethod(
        Invocation.method(
          #fetchLeave,
          [id],
        ),
        returnValue: _i4.Future<_i7.Leave?>.value(),
      ) as _i4.Future<_i7.Leave?>);
}
