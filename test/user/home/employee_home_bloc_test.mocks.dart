// Mocks generated by Mockito 5.3.2 from annotations
// in projectunity/test/user/home/employee_home_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:ui' as _i12;

import 'package:mockito/mockito.dart' as _i1;
import 'package:projectunity/model/employee/employee.dart' as _i2;
import 'package:projectunity/model/leave/leave.dart' as _i6;
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart' as _i3;
import 'package:projectunity/navigation/navigation_stack_manager.dart' as _i11;
import 'package:projectunity/provider/user_data.dart' as _i7;
import 'package:projectunity/services/admin/employee/employee_service.dart'
    as _i9;
import 'package:projectunity/services/admin/paid_leave/paid_leave_service.dart'
    as _i8;
import 'package:projectunity/services/admin/requests/admin_leave_service.dart'
    as _i10;
import 'package:projectunity/services/leave/user_leave_service.dart' as _i4;

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

class _FakeNavStackItem_1 extends _i1.SmartFake implements _i3.NavStackItem {
  _FakeNavStackItem_1(
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
class MockUserLeaveService extends _i1.Mock implements _i4.UserLeaveService {
  MockUserLeaveService() {
    _i1.throwOnMissingStub(this);
  }

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
  _i5.Future<List<_i6.Leave>> getRequestedLeave(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getRequestedLeave,
          [id],
        ),
        returnValue: _i5.Future<List<_i6.Leave>>.value(<_i6.Leave>[]),
      ) as _i5.Future<List<_i6.Leave>>);

  @override
  _i5.Future<List<_i6.Leave>> getUpcomingLeaves(String? employeeId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUpcomingLeaves,
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
  _i5.Future<double> getUserUsedLeaveCount(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getUserUsedLeaveCount,
          [id],
        ),
        returnValue: _i5.Future<double>.value(0.0),
      ) as _i5.Future<double>);

  @override
  _i5.Future<void> deleteAllLeaves(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteAllLeaves,
          [id],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}

/// A class which mocks [UserManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserManager extends _i1.Mock implements _i7.UserManager {
  MockUserManager() {
    _i1.throwOnMissingStub(this);
  }

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
  String get userName => (super.noSuchMethod(
        Invocation.getter(#userName),
        returnValue: '',
      ) as String);

  @override
  bool get isUserLoggedIn => (super.noSuchMethod(
        Invocation.getter(#isUserLoggedIn),
        returnValue: false,
      ) as bool);

  @override
  bool get isOnBoardCompleted => (super.noSuchMethod(
        Invocation.getter(#isOnBoardCompleted),
        returnValue: false,
      ) as bool);

  @override
  bool get isAdmin => (super.noSuchMethod(
        Invocation.getter(#isAdmin),
        returnValue: false,
      ) as bool);
}

/// A class which mocks [PaidLeaveService].
///
/// See the documentation for Mockito's code generation for more information.
class MockPaidLeaveService extends _i1.Mock implements _i8.PaidLeaveService {
  MockPaidLeaveService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<int> getPaidLeaves() => (super.noSuchMethod(
        Invocation.method(
          #getPaidLeaves,
          [],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);

  @override
  _i5.Stream<int> getPadLeavesAsStream() => (super.noSuchMethod(
        Invocation.method(
          #getPadLeavesAsStream,
          [],
        ),
        returnValue: _i5.Stream<int>.empty(),
      ) as _i5.Stream<int>);

  @override
  _i5.Future<void> updateLeaveCount(int? leaveCount) => (super.noSuchMethod(
        Invocation.method(
          #updateLeaveCount,
          [leaveCount],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}

/// A class which mocks [EmployeeService].
///
/// See the documentation for Mockito's code generation for more information.
class MockEmployeeService extends _i1.Mock implements _i9.EmployeeService {
  MockEmployeeService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Stream<List<_i2.Employee>> getEmployeesStream() => (super.noSuchMethod(
        Invocation.method(
          #getEmployeesStream,
          [],
        ),
        returnValue: _i5.Stream<List<_i2.Employee>>.empty(),
      ) as _i5.Stream<List<_i2.Employee>>);

  @override
  _i5.Future<List<_i2.Employee>> getEmployees() => (super.noSuchMethod(
        Invocation.method(
          #getEmployees,
          [],
        ),
        returnValue: _i5.Future<List<_i2.Employee>>.value(<_i2.Employee>[]),
      ) as _i5.Future<List<_i2.Employee>>);

  @override
  _i5.Future<_i2.Employee?> getEmployee(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getEmployee,
          [id],
        ),
        returnValue: _i5.Future<_i2.Employee?>.value(),
      ) as _i5.Future<_i2.Employee?>);

  @override
  _i5.Future<bool> hasUser(String? email) => (super.noSuchMethod(
        Invocation.method(
          #hasUser,
          [email],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);

  @override
  _i5.Future<void> addEmployee(_i2.Employee? employee) => (super.noSuchMethod(
        Invocation.method(
          #addEmployee,
          [employee],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> deleteEmployee(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteEmployee,
          [id],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}

/// A class which mocks [AdminLeaveService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAdminLeaveService extends _i1.Mock implements _i10.AdminLeaveService {
  MockAdminLeaveService() {
    _i1.throwOnMissingStub(this);
  }

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
  _i5.Stream<List<_i6.Leave>> getAllRequests() => (super.noSuchMethod(
        Invocation.method(
          #getAllRequests,
          [],
        ),
        returnValue: _i5.Stream<List<_i6.Leave>>.empty(),
      ) as _i5.Stream<List<_i6.Leave>>);

  @override
  _i5.Future<List<_i6.Leave>> getAllAbsence() => (super.noSuchMethod(
        Invocation.method(
          #getAllAbsence,
          [],
        ),
        returnValue: _i5.Future<List<_i6.Leave>>.value(<_i6.Leave>[]),
      ) as _i5.Future<List<_i6.Leave>>);
}

/// A class which mocks [NavigationStackManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockNavigationStackManager extends _i1.Mock
    implements _i11.NavigationStackManager {
  MockNavigationStackManager() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i3.NavStackItem> get pages => (super.noSuchMethod(
        Invocation.getter(#pages),
        returnValue: <_i3.NavStackItem>[],
      ) as List<_i3.NavStackItem>);

  @override
  _i3.NavStackItem get currentState => (super.noSuchMethod(
        Invocation.getter(#currentState),
        returnValue: _FakeNavStackItem_1(
          this,
          Invocation.getter(#currentState),
        ),
      ) as _i3.NavStackItem);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  void updateStack(List<_i3.NavStackItem>? newItems) => super.noSuchMethod(
        Invocation.method(
          #updateStack,
          [newItems],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void push(_i3.NavStackItem? item) => super.noSuchMethod(
        Invocation.method(
          #push,
          [item],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void clearAndPush(_i3.NavStackItem? item) => super.noSuchMethod(
        Invocation.method(
          #clearAndPush,
          [item],
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
  void addListener(_i12.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i12.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
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
