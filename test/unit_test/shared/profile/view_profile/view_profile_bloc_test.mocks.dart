// Mocks generated by Mockito 5.4.4 from annotations
// in projectunity/test/unit_test/shared/profile/view_profile/view_profile_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:ui' as _i8;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i4;
import 'package:projectunity/data/model/account/account.dart' as _i6;
import 'package:projectunity/data/model/employee/employee.dart' as _i2;
import 'package:projectunity/data/model/space/space.dart' as _i7;
import 'package:projectunity/data/provider/user_state.dart' as _i3;
import 'package:projectunity/data/repo/employee_repo.dart' as _i9;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
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

/// A class which mocks [UserStateNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserStateNotifier extends _i1.Mock implements _i3.UserStateNotifier {
  MockUserStateNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.UserState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i3.UserState.authenticated,
      ) as _i3.UserState);

  @override
  String get employeeId => (super.noSuchMethod(
        Invocation.getter(#employeeId),
        returnValue: _i4.dummyValue<String>(
          this,
          Invocation.getter(#employeeId),
        ),
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
  _i5.Future<void> setUser(_i6.Account? user) => (super.noSuchMethod(
        Invocation.method(
          #setUser,
          [user],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> setEmployeeWithSpace({
    required _i7.Space? space,
    required _i2.Employee? spaceUser,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #setEmployeeWithSpace,
          [],
          {
            #space: space,
            #spaceUser: spaceUser,
          },
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> setEmployee({required _i2.Employee? member}) =>
      (super.noSuchMethod(
        Invocation.method(
          #setEmployee,
          [],
          {#member: member},
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> setSpace({required _i7.Space? space}) => (super.noSuchMethod(
        Invocation.method(
          #setSpace,
          [],
          {#space: space},
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> updateSpace(_i7.Space? space) => (super.noSuchMethod(
        Invocation.method(
          #updateSpace,
          [space],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> removeEmployeeWithSpace() => (super.noSuchMethod(
        Invocation.method(
          #removeEmployeeWithSpace,
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

/// A class which mocks [EmployeeRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockEmployeeRepo extends _i1.Mock implements _i9.EmployeeRepo {
  MockEmployeeRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Stream<List<_i2.Employee>> get employees => (super.noSuchMethod(
        Invocation.getter(#employees),
        returnValue: _i5.Stream<List<_i2.Employee>>.empty(),
      ) as _i5.Stream<List<_i2.Employee>>);

  @override
  List<_i2.Employee> get allEmployees => (super.noSuchMethod(
        Invocation.getter(#allEmployees),
        returnValue: <_i2.Employee>[],
      ) as List<_i2.Employee>);

  @override
  _i5.Stream<List<_i2.Employee>> get activeEmployees => (super.noSuchMethod(
        Invocation.getter(#activeEmployees),
        returnValue: _i5.Stream<List<_i2.Employee>>.empty(),
      ) as _i5.Stream<List<_i2.Employee>>);

  @override
  _i5.Stream<_i2.Employee?> memberDetails(String? uid) => (super.noSuchMethod(
        Invocation.method(
          #memberDetails,
          [uid],
        ),
        returnValue: _i5.Stream<_i2.Employee?>.empty(),
      ) as _i5.Stream<_i2.Employee?>);

  @override
  _i5.Future<void> reset() => (super.noSuchMethod(
        Invocation.method(
          #reset,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> dispose() => (super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}
