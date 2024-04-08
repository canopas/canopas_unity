// Mocks generated by Mockito 5.4.4 from annotations
// in projectunity/test/unit_test/space/join_space/join_space_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:ui' as _i14;

import 'package:cloud_firestore/cloud_firestore.dart' as _i2;
import 'package:firebase_auth/firebase_auth.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i11;
import 'package:projectunity/data/model/account/account.dart' as _i5;
import 'package:projectunity/data/model/employee/employee.dart' as _i3;
import 'package:projectunity/data/model/invitation/invitation.dart' as _i9;
import 'package:projectunity/data/model/leave/leave.dart' as _i19;
import 'package:projectunity/data/model/space/space.dart' as _i12;
import 'package:projectunity/data/provider/device_info.dart' as _i4;
import 'package:projectunity/data/provider/user_state.dart' as _i13;
import 'package:projectunity/data/services/account_service.dart' as _i15;
import 'package:projectunity/data/services/auth_service.dart' as _i17;
import 'package:projectunity/data/services/employee_service.dart' as _i16;
import 'package:projectunity/data/services/invitation_services.dart' as _i7;
import 'package:projectunity/data/services/mail_notification_service.dart'
    as _i18;
import 'package:projectunity/data/services/space_service.dart' as _i10;

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

class _FakeEmployee_1 extends _i1.SmartFake implements _i3.Employee {
  _FakeEmployee_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDeviceInfoProvider_2 extends _i1.SmartFake
    implements _i4.DeviceInfoProvider {
  _FakeDeviceInfoProvider_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAccount_3 extends _i1.SmartFake implements _i5.Account {
  _FakeAccount_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFirebaseAuth_4 extends _i1.SmartFake implements _i6.FirebaseAuth {
  _FakeFirebaseAuth_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [InvitationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockInvitationService extends _i1.Mock implements _i7.InvitationService {
  MockInvitationService() {
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
  _i8.Future<List<_i9.Invitation>> fetchSpaceInvitationsForUserEmail(
          String? email) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchSpaceInvitationsForUserEmail,
          [email],
        ),
        returnValue: _i8.Future<List<_i9.Invitation>>.value(<_i9.Invitation>[]),
      ) as _i8.Future<List<_i9.Invitation>>);

  @override
  _i8.Future<bool> checkMemberInvitationAlreadyExist({
    required String? spaceId,
    required String? email,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #checkMemberInvitationAlreadyExist,
          [],
          {
            #spaceId: spaceId,
            #email: email,
          },
        ),
        returnValue: _i8.Future<bool>.value(false),
      ) as _i8.Future<bool>);

  @override
  _i8.Future<List<_i9.Invitation>> fetchSpaceInvitations(
          {required String? spaceId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchSpaceInvitations,
          [],
          {#spaceId: spaceId},
        ),
        returnValue: _i8.Future<List<_i9.Invitation>>.value(<_i9.Invitation>[]),
      ) as _i8.Future<List<_i9.Invitation>>);

  @override
  _i8.Future<void> addInvitation({
    required String? senderId,
    required String? spaceId,
    required String? receiverEmail,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addInvitation,
          [],
          {
            #senderId: senderId,
            #spaceId: spaceId,
            #receiverEmail: receiverEmail,
          },
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> deleteInvitation({required String? id}) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteInvitation,
          [],
          {#id: id},
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
}

/// A class which mocks [SpaceService].
///
/// See the documentation for Mockito's code generation for more information.
class MockSpaceService extends _i1.Mock implements _i10.SpaceService {
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
  String get generateNewSpaceId => (super.noSuchMethod(
        Invocation.getter(#generateNewSpaceId),
        returnValue: _i11.dummyValue<String>(
          this,
          Invocation.getter(#generateNewSpaceId),
        ),
      ) as String);

  @override
  _i8.Future<_i12.Space?> getSpace(String? spaceId) => (super.noSuchMethod(
        Invocation.method(
          #getSpace,
          [spaceId],
        ),
        returnValue: _i8.Future<_i12.Space?>.value(),
      ) as _i8.Future<_i12.Space?>);

  @override
  _i8.Future<void> createSpace({required _i12.Space? space}) =>
      (super.noSuchMethod(
        Invocation.method(
          #createSpace,
          [],
          {#space: space},
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> updateSpace(_i12.Space? space) => (super.noSuchMethod(
        Invocation.method(
          #updateSpace,
          [space],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> deleteSpace({
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
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<int> getPaidLeaves({required String? spaceId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPaidLeaves,
          [],
          {#spaceId: spaceId},
        ),
        returnValue: _i8.Future<int>.value(0),
      ) as _i8.Future<int>);
}

/// A class which mocks [UserStateNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserStateNotifier extends _i1.Mock implements _i13.UserStateNotifier {
  MockUserStateNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i13.UserState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i13.UserState.authenticated,
      ) as _i13.UserState);

  @override
  String get employeeId => (super.noSuchMethod(
        Invocation.getter(#employeeId),
        returnValue: _i11.dummyValue<String>(
          this,
          Invocation.getter(#employeeId),
        ),
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
  _i8.Future<void> setUser(_i5.Account? user) => (super.noSuchMethod(
        Invocation.method(
          #setUser,
          [user],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> setEmployeeWithSpace({
    required _i12.Space? space,
    required _i3.Employee? spaceUser,
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
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> setEmployee({required _i3.Employee? member}) =>
      (super.noSuchMethod(
        Invocation.method(
          #setEmployee,
          [],
          {#member: member},
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> setSpace({required _i12.Space? space}) =>
      (super.noSuchMethod(
        Invocation.method(
          #setSpace,
          [],
          {#space: space},
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> updateSpace(_i12.Space? space) => (super.noSuchMethod(
        Invocation.method(
          #updateSpace,
          [space],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> removeEmployeeWithSpace() => (super.noSuchMethod(
        Invocation.method(
          #removeEmployeeWithSpace,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> removeAll() => (super.noSuchMethod(
        Invocation.method(
          #removeAll,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  void addListener(_i14.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i14.VoidCallback? listener) => super.noSuchMethod(
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

/// A class which mocks [AccountService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAccountService extends _i1.Mock implements _i15.AccountService {
  MockAccountService() {
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
  _i4.DeviceInfoProvider get deviceInfoProvider => (super.noSuchMethod(
        Invocation.getter(#deviceInfoProvider),
        returnValue: _FakeDeviceInfoProvider_2(
          this,
          Invocation.getter(#deviceInfoProvider),
        ),
      ) as _i4.DeviceInfoProvider);

  @override
  _i8.Future<_i5.Account> getUser(_i6.User? authData) => (super.noSuchMethod(
        Invocation.method(
          #getUser,
          [authData],
        ),
        returnValue: _i8.Future<_i5.Account>.value(_FakeAccount_3(
          this,
          Invocation.method(
            #getUser,
            [authData],
          ),
        )),
      ) as _i8.Future<_i5.Account>);

  @override
  _i8.Future<_i5.Account?> getAppleUser(_i6.User? authData) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAppleUser,
          [authData],
        ),
        returnValue: _i8.Future<_i5.Account?>.value(),
      ) as _i8.Future<_i5.Account?>);

  @override
  _i8.Future<void> setUserAccount(_i5.Account? user) => (super.noSuchMethod(
        Invocation.method(
          #setUserAccount,
          [user],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> updateSpaceOfUser({
    required String? spaceID,
    required String? uid,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateSpaceOfUser,
          [],
          {
            #spaceID: spaceID,
            #uid: uid,
          },
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> deleteSpaceIdFromAccount({
    required String? spaceId,
    required String? uid,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteSpaceIdFromAccount,
          [],
          {
            #spaceId: spaceId,
            #uid: uid,
          },
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> addSpaceIdFromAccount({
    required String? spaceId,
    required String? uid,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addSpaceIdFromAccount,
          [],
          {
            #spaceId: spaceId,
            #uid: uid,
          },
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<List<String>> fetchSpaceIds({required String? uid}) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchSpaceIds,
          [],
          {#uid: uid},
        ),
        returnValue: _i8.Future<List<String>>.value(<String>[]),
      ) as _i8.Future<List<String>>);
}

/// A class which mocks [EmployeeService].
///
/// See the documentation for Mockito's code generation for more information.
class MockEmployeeService extends _i1.Mock implements _i16.EmployeeService {
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
  _i8.Stream<List<_i3.Employee>> employees(String? spaceId) =>
      (super.noSuchMethod(
        Invocation.method(
          #employees,
          [spaceId],
        ),
        returnValue: _i8.Stream<List<_i3.Employee>>.empty(),
      ) as _i8.Stream<List<_i3.Employee>>);

  @override
  _i8.Future<void> addEmployeeBySpaceId({
    required _i3.Employee? employee,
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
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<_i3.Employee?> getEmployeeBySpaceId({
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
        returnValue: _i8.Future<_i3.Employee?>.value(),
      ) as _i8.Future<_i3.Employee?>);

  @override
  _i8.Future<List<_i3.Employee>> getEmployees() => (super.noSuchMethod(
        Invocation.method(
          #getEmployees,
          [],
        ),
        returnValue: _i8.Future<List<_i3.Employee>>.value(<_i3.Employee>[]),
      ) as _i8.Future<List<_i3.Employee>>);

  @override
  _i8.Future<_i3.Employee?> getEmployee(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getEmployee,
          [id],
        ),
        returnValue: _i8.Future<_i3.Employee?>.value(),
      ) as _i8.Future<_i3.Employee?>);

  @override
  _i8.Future<bool> hasUser(String? email) => (super.noSuchMethod(
        Invocation.method(
          #hasUser,
          [email],
        ),
        returnValue: _i8.Future<bool>.value(false),
      ) as _i8.Future<bool>);

  @override
  _i8.Future<void> updateEmployeeDetails({required _i3.Employee? employee}) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateEmployeeDetails,
          [],
          {#employee: employee},
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> changeAccountStatus({
    required String? id,
    required _i3.EmployeeStatus? status,
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
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
}

/// A class which mocks [AuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthService extends _i1.Mock implements _i17.AuthService {
  MockAuthService() {
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
  _i6.FirebaseAuth get firebaseAuth => (super.noSuchMethod(
        Invocation.getter(#firebaseAuth),
        returnValue: _FakeFirebaseAuth_4(
          this,
          Invocation.getter(#firebaseAuth),
        ),
      ) as _i6.FirebaseAuth);

  @override
  _i8.Future<_i6.User?> signInWithGoogle() => (super.noSuchMethod(
        Invocation.method(
          #signInWithGoogle,
          [],
        ),
        returnValue: _i8.Future<_i6.User?>.value(),
      ) as _i8.Future<_i6.User?>);

  @override
  _i8.Future<_i6.User?> signInWithCredentials(
          _i6.AuthCredential? authCredential) =>
      (super.noSuchMethod(
        Invocation.method(
          #signInWithCredentials,
          [authCredential],
        ),
        returnValue: _i8.Future<_i6.User?>.value(),
      ) as _i8.Future<_i6.User?>);

  @override
  _i8.Future<_i6.User?> signInWithApple() => (super.noSuchMethod(
        Invocation.method(
          #signInWithApple,
          [],
        ),
        returnValue: _i8.Future<_i6.User?>.value(),
      ) as _i8.Future<_i6.User?>);

  @override
  _i8.Future<bool> signOut() => (super.noSuchMethod(
        Invocation.method(
          #signOut,
          [],
        ),
        returnValue: _i8.Future<bool>.value(false),
      ) as _i8.Future<bool>);
}

/// A class which mocks [NotificationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotificationService extends _i1.Mock
    implements _i18.NotificationService {
  MockNotificationService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<void> dispose() => (super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> notifyHRForNewLeave({
    required String? name,
    required String? reason,
    required DateTime? startDate,
    required String? duration,
    required DateTime? endDate,
    required String? receiver,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #notifyHRForNewLeave,
          [],
          {
            #name: name,
            #reason: reason,
            #startDate: startDate,
            #duration: duration,
            #endDate: endDate,
            #receiver: receiver,
          },
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> leaveResponse({
    required String? name,
    required DateTime? startDate,
    required DateTime? endDate,
    required _i19.LeaveStatus? status,
    required String? receiver,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #leaveResponse,
          [],
          {
            #name: name,
            #startDate: startDate,
            #endDate: endDate,
            #status: status,
            #receiver: receiver,
          },
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  String getFormatDate({
    required DateTime? startDate,
    required DateTime? endDate,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getFormatDate,
          [],
          {
            #startDate: startDate,
            #endDate: endDate,
          },
        ),
        returnValue: _i11.dummyValue<String>(
          this,
          Invocation.method(
            #getFormatDate,
            [],
            {
              #startDate: startDate,
              #endDate: endDate,
            },
          ),
        ),
      ) as String);

  @override
  _i8.Future<void> sendInviteNotification({
    required String? companyName,
    required String? receiver,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #sendInviteNotification,
          [],
          {
            #companyName: companyName,
            #receiver: receiver,
          },
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> sendSpaceInviteAcceptNotification({
    required String? sender,
    required String? receiver,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #sendSpaceInviteAcceptNotification,
          [],
          {
            #sender: sender,
            #receiver: receiver,
          },
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
}
