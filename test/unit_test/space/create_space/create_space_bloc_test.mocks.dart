// Mocks generated by Mockito 5.3.2 from annotations
// in projectunity/test/unit_test/space/create_space/create_space_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:ui' as _i8;

import 'package:mockito/mockito.dart' as _i1;
import 'package:projectunity/data/model/employee/employee.dart' as _i3;
import 'package:projectunity/data/model/space/space.dart' as _i2;
import 'package:projectunity/data/model/user/user.dart' as _i7;
import 'package:projectunity/data/provider/user_data.dart' as _i6;
import 'package:projectunity/data/services/space_service.dart' as _i4;

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

class _FakeSpace_0 extends _i1.SmartFake implements _i2.Space {
  _FakeSpace_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEmployee_1 extends _i1.SmartFake implements _i3.Employee {
  _FakeEmployee_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SpaceService].
///
/// See the documentation for Mockito's code generation for more information.
class MockSpaceService extends _i1.Mock implements _i4.SpaceService {
  MockSpaceService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Space> createSpace({
    required String? name,
    required String? domain,
    required int? timeOff,
    required String? ownerId,
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
          },
        ),
        returnValue: _i5.Future<_i2.Space>.value(_FakeSpace_0(
          this,
          Invocation.method(
            #createSpace,
            [],
            {
              #name: name,
              #domain: domain,
              #timeOff: timeOff,
              #ownerId: ownerId,
            },
          ),
        )),
      ) as _i5.Future<_i2.Space>);
  @override
  _i5.Future<void> deleteSpace(String? workspaceId) => (super.noSuchMethod(
        Invocation.method(
          #deleteSpace,
          [workspaceId],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<List<_i2.Space>> getSpacesOfUser(String? uid) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSpacesOfUser,
          [uid],
        ),
        returnValue: _i5.Future<List<_i2.Space>>.value(<_i2.Space>[]),
      ) as _i5.Future<List<_i2.Space>>);
}

/// A class which mocks [UserManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserManager extends _i1.Mock implements _i6.UserManager {
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
  _i3.Employee get employee => (super.noSuchMethod(
        Invocation.getter(#employee),
        returnValue: _FakeEmployee_1(
          this,
          Invocation.getter(#employee),
        ),
      ) as _i3.Employee);
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
  _i5.Future<void> setUser(_i7.User? user) => (super.noSuchMethod(
        Invocation.method(
          #setUser,
          [user],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> setSpace(_i2.Space? space) => (super.noSuchMethod(
        Invocation.method(
          #setSpace,
          [space],
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
