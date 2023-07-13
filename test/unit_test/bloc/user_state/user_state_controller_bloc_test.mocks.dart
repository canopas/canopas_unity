// Mocks generated by Mockito 5.4.0 from annotations
// in projectunity/test/unit_test/bloc/user_state/user_state_controller_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:ui' as _i10;

import 'package:cloud_firestore/cloud_firestore.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:projectunity/data/model/account/account.dart' as _i9;
import 'package:projectunity/data/model/employee/employee.dart' as _i6;
import 'package:projectunity/data/model/space/space.dart' as _i3;
import 'package:projectunity/data/provider/user_state.dart' as _i8;
import 'package:projectunity/data/services/employee_service.dart' as _i4;
import 'package:projectunity/data/services/space_service.dart' as _i7;

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

class _FakeSpace_1 extends _i1.SmartFake implements _i3.Space {
  _FakeSpace_1(
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
class MockEmployeeService extends _i1.Mock implements _i4.EmployeeService {
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
  _i5.Stream<List<_i6.Employee>> employees(String? spaceId) =>
      (super.noSuchMethod(
        Invocation.method(
          #employees,
          [spaceId],
        ),
        returnValue: _i5.Stream<List<_i6.Employee>>.empty(),
      ) as _i5.Stream<List<_i6.Employee>>);

  @override
  _i5.Future<void> addEmployeeBySpaceId({
    required _i6.Employee? employee,
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
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<_i6.Employee?> getEmployeeBySpaceId({
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
        returnValue: _i5.Future<_i6.Employee?>.value(),
      ) as _i5.Future<_i6.Employee?>);

  @override
  _i5.Future<List<_i6.Employee>> getEmployees() => (super.noSuchMethod(
        Invocation.method(
          #getEmployees,
          [],
        ),
        returnValue: _i5.Future<List<_i6.Employee>>.value(<_i6.Employee>[]),
      ) as _i5.Future<List<_i6.Employee>>);

  @override
  _i5.Future<_i6.Employee?> getEmployee(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getEmployee,
          [id],
        ),
        returnValue: _i5.Future<_i6.Employee?>.value(),
      ) as _i5.Future<_i6.Employee?>);

  @override
  _i5.Future<bool> hasUser(String? email) => (super.noSuchMethod(
        Invocation.method(
          #hasUser,
          [email],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);

  @override
  _i5.Future<void> addEmployee(_i6.Employee? employee) => (super.noSuchMethod(
        Invocation.method(
          #addEmployee,
          [employee],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> updateEmployeeDetails({required _i6.Employee? employee}) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateEmployeeDetails,
          [],
          {#employee: employee},
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> changeEmployeeRoleType(
    String? id,
    _i6.Role? role,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #changeEmployeeRoleType,
          [
            id,
            role,
          ],
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

  @override
  _i5.Future<void> changeAccountStatus({
    required String? id,
    required _i6.EmployeeStatus? status,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #changeAccountStatus,
          [],
          {
            #id: id,
            #status: status,
          },
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}

/// A class which mocks [SpaceService].
///
/// See the documentation for Mockito's code generation for more information.
class MockSpaceService extends _i1.Mock implements _i7.SpaceService {
  MockSpaceService() {
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
  _i5.Future<_i3.Space?> getSpace(String? spaceId) => (super.noSuchMethod(
        Invocation.method(
          #getSpace,
          [spaceId],
        ),
        returnValue: _i5.Future<_i3.Space?>.value(),
      ) as _i5.Future<_i3.Space?>);

  @override
  _i5.Future<_i3.Space> createSpace({
    String? logo,
    required String? name,
    String? domain,
    required int? timeOff,
    required String? ownerId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #createSpace,
          [],
          {
            #logo: logo,
            #name: name,
            #domain: domain,
            #timeOff: timeOff,
            #ownerId: ownerId,
          },
        ),
        returnValue: _i5.Future<_i3.Space>.value(_FakeSpace_1(
          this,
          Invocation.method(
            #createSpace,
            [],
            {
              #logo: logo,
              #name: name,
              #domain: domain,
              #timeOff: timeOff,
              #ownerId: ownerId,
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
  _i5.Future<void> deleteSpace({
    required String? spaceId,
    required List<String>? owners,
    required String? uid,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteSpace,
          [],
          {
            #spaceId: spaceId,
            #owners: owners,
            #uid: uid,
          },
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

/// A class which mocks [UserStateNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserStateNotifier extends _i1.Mock implements _i8.UserStateNotifier {
  MockUserStateNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.UserState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i8.UserState.authenticated,
      ) as _i8.UserState);
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
  _i5.Future<void> setUser(_i9.Account? user) => (super.noSuchMethod(
        Invocation.method(
          #setUser,
          [user],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> resetStreamSubscription() => (super.noSuchMethod(
        Invocation.method(
          #resetStreamSubscription,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> updateCurrentUser(_i6.Employee? user) => (super.noSuchMethod(
        Invocation.method(
          #updateCurrentUser,
          [user],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

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
  void addListener(_i10.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i10.VoidCallback? listener) => super.noSuchMethod(
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
