// Mocks generated by Mockito 5.4.0 from annotations
// in projectunity/test/unit_test/admin/member/list/employee_list_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:ui' as _i9;

import 'package:cloud_firestore/cloud_firestore.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:projectunity/data/model/account/account.dart' as _i7;
import 'package:projectunity/data/model/employee/employee.dart' as _i5;
import 'package:projectunity/data/model/invitation/invitation.dart' as _i11;
import 'package:projectunity/data/model/space/space.dart' as _i8;
import 'package:projectunity/data/provider/user_state.dart' as _i6;
import 'package:projectunity/data/Repo/employee_repo.dart' as _i3;
import 'package:projectunity/data/services/invitation_services.dart' as _i10;

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

/// A class which mocks [EmployeeRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockEmployeeRepo extends _i1.Mock implements _i3.EmployeeRepo {
  MockEmployeeRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Stream<List<_i5.Employee>> get employees => (super.noSuchMethod(
        Invocation.getter(#employees),
        returnValue: _i4.Stream<List<_i5.Employee>>.empty(),
      ) as _i4.Stream<List<_i5.Employee>>);
  @override
  _i4.Stream<List<_i5.Employee>> get activeEmployees => (super.noSuchMethod(
        Invocation.getter(#activeEmployees),
        returnValue: _i4.Stream<List<_i5.Employee>>.empty(),
      ) as _i4.Stream<List<_i5.Employee>>);
  @override
  _i4.Stream<_i5.Employee?> memberDetails(String? uid) => (super.noSuchMethod(
        Invocation.method(
          #memberDetails,
          [uid],
        ),
        returnValue: _i4.Stream<_i5.Employee?>.empty(),
      ) as _i4.Stream<_i5.Employee?>);
  @override
  _i4.Stream<_i5.Employee?> getCurrentUser({required String? uid}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentUser,
          [],
          {#uid: uid},
        ),
        returnValue: _i4.Stream<_i5.Employee?>.empty(),
      ) as _i4.Stream<_i5.Employee?>);
  @override
  _i4.Future<void> reset() => (super.noSuchMethod(
        Invocation.method(
          #reset,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> cancelEmpStreamSubscription() => (super.noSuchMethod(
        Invocation.method(
          #cancel,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> dispose() => (super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [UserStateNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserStateNotifier extends _i1.Mock implements _i6.UserStateNotifier {
  MockUserStateNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.UserState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i6.UserState.authenticated,
      ) as _i6.UserState);
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
  _i4.Future<void> setUser(_i7.Account? user) => (super.noSuchMethod(
        Invocation.method(
          #setUser,
          [user],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> updateCurrentUser(_i5.Employee? user) => (super.noSuchMethod(
        Invocation.method(
          #updateCurrentUser,
          [user],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> updateSpace(_i8.Space? space) => (super.noSuchMethod(
        Invocation.method(
          #updateSpace,
          [space],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> removeEmployeeWithSpace() => (super.noSuchMethod(
        Invocation.method(
          #removeEmployeeWithSpace,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> removeAll() => (super.noSuchMethod(
        Invocation.method(
          #removeAll,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
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

/// A class which mocks [InvitationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockInvitationService extends _i1.Mock implements _i10.InvitationService {
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
  _i4.Future<List<_i11.Invitation>> fetchSpaceInvitationsForUserEmail(
          String? email) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchSpaceInvitationsForUserEmail,
          [email],
        ),
        returnValue:
            _i4.Future<List<_i11.Invitation>>.value(<_i11.Invitation>[]),
      ) as _i4.Future<List<_i11.Invitation>>);
  @override
  _i4.Future<bool> checkMemberInvitationAlreadyExist({
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
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<List<_i11.Invitation>> fetchSpaceInvitations(
          {required String? spaceId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchSpaceInvitations,
          [],
          {#spaceId: spaceId},
        ),
        returnValue:
            _i4.Future<List<_i11.Invitation>>.value(<_i11.Invitation>[]),
      ) as _i4.Future<List<_i11.Invitation>>);
  @override
  _i4.Future<void> addInvitation({
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
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> deleteInvitation({required String? id}) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteInvitation,
          [],
          {#id: id},
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
