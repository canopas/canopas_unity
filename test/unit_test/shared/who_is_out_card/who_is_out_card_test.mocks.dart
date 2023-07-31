// Mocks generated by Mockito 5.4.0 from annotations
// in projectunity/test/unit_test/shared/who_is_out_card/who_is_out_card_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:projectunity/data/model/employee/employee.dart' as _i6;
import 'package:projectunity/data/model/leave/leave.dart' as _i4;
import 'package:projectunity/data/Repo/employee_repo.dart' as _i5;
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
  _i3.Stream<List<_i4.Leave>> userLeavesByYear(
    String? uid,
    int? year,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #userLeavesByYear,
          [
            uid,
            year,
          ],
        ),
        returnValue: _i3.Stream<List<_i4.Leave>>.empty(),
      ) as _i3.Stream<List<_i4.Leave>>);
  @override
  _i3.Stream<List<_i4.Leave>> leaveByMonth(DateTime? date) =>
      (super.noSuchMethod(
        Invocation.method(
          #leaveByMonth,
          [date],
        ),
        returnValue: _i3.Stream<List<_i4.Leave>>.empty(),
      ) as _i3.Stream<List<_i4.Leave>>);
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

/// A class which mocks [EmployeeRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockEmployeeRepo extends _i1.Mock implements _i5.EmployeeRepo {
  MockEmployeeRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Stream<List<_i6.Employee>> get employees => (super.noSuchMethod(
        Invocation.getter(#employees),
        returnValue: _i3.Stream<List<_i6.Employee>>.empty(),
      ) as _i3.Stream<List<_i6.Employee>>);
  @override
  _i3.Stream<List<_i6.Employee>> get activeEmployees => (super.noSuchMethod(
        Invocation.getter(#activeEmployees),
        returnValue: _i3.Stream<List<_i6.Employee>>.empty(),
      ) as _i3.Stream<List<_i6.Employee>>);
  @override
  _i3.Stream<_i6.Employee?> memberDetails(String? uid) => (super.noSuchMethod(
        Invocation.method(
          #memberDetails,
          [uid],
        ),
        returnValue: _i3.Stream<_i6.Employee?>.empty(),
      ) as _i3.Stream<_i6.Employee?>);
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
  _i3.Future<void> dispose() => (super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
