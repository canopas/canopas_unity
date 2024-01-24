// Mocks generated by Mockito 5.4.4 from annotations
// in projectunity/test/unit_test/space/create_space/create_space_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:ui' as _i12;

import 'package:cloud_firestore/cloud_firestore.dart' as _i2;
import 'package:firebase_storage/firebase_storage.dart' as _i4;
import 'package:image_picker/image_picker.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i7;
import 'package:projectunity/data/model/account/account.dart' as _i11;
import 'package:projectunity/data/model/employee/employee.dart' as _i3;
import 'package:projectunity/data/model/space/space.dart' as _i9;
import 'package:projectunity/data/provider/user_state.dart' as _i10;
import 'package:projectunity/data/services/employee_service.dart' as _i13;
import 'package:projectunity/data/services/space_service.dart' as _i6;
import 'package:projectunity/data/services/storage_service.dart' as _i14;

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

class _FakeFirebaseStorage_2 extends _i1.SmartFake
    implements _i4.FirebaseStorage {
  _FakeFirebaseStorage_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLostDataResponse_3 extends _i1.SmartFake
    implements _i5.LostDataResponse {
  _FakeLostDataResponse_3(
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
class MockSpaceService extends _i1.Mock implements _i6.SpaceService {
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
        returnValue: _i7.dummyValue<String>(
          this,
          Invocation.getter(#generateNewSpaceId),
        ),
      ) as String);

  @override
  _i8.Future<_i9.Space?> getSpace(String? spaceId) => (super.noSuchMethod(
        Invocation.method(
          #getSpace,
          [spaceId],
        ),
        returnValue: _i8.Future<_i9.Space?>.value(),
      ) as _i8.Future<_i9.Space?>);

  @override
  _i8.Future<void> createSpace({required _i9.Space? space}) =>
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
  _i8.Future<void> updateSpace(_i9.Space? space) => (super.noSuchMethod(
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
class MockUserStateNotifier extends _i1.Mock implements _i10.UserStateNotifier {
  MockUserStateNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i10.UserState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i10.UserState.authenticated,
      ) as _i10.UserState);

  @override
  String get employeeId => (super.noSuchMethod(
        Invocation.getter(#employeeId),
        returnValue: _i7.dummyValue<String>(
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
  _i8.Future<void> setUser(_i11.Account? user) => (super.noSuchMethod(
        Invocation.method(
          #setUser,
          [user],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> setEmployeeWithSpace({
    required _i9.Space? space,
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
  _i8.Future<void> setSpace({required _i9.Space? space}) => (super.noSuchMethod(
        Invocation.method(
          #setSpace,
          [],
          {#space: space},
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> updateSpace(_i9.Space? space) => (super.noSuchMethod(
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

/// A class which mocks [EmployeeService].
///
/// See the documentation for Mockito's code generation for more information.
class MockEmployeeService extends _i1.Mock implements _i13.EmployeeService {
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

/// A class which mocks [StorageService].
///
/// See the documentation for Mockito's code generation for more information.
class MockStorageService extends _i1.Mock implements _i14.StorageService {
  MockStorageService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.FirebaseStorage get firebaseStorage => (super.noSuchMethod(
        Invocation.getter(#firebaseStorage),
        returnValue: _FakeFirebaseStorage_2(
          this,
          Invocation.getter(#firebaseStorage),
        ),
      ) as _i4.FirebaseStorage);

  @override
  _i8.Future<String> uploadProfilePic({
    required String? path,
    required String? imagePath,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #uploadProfilePic,
          [],
          {
            #path: path,
            #imagePath: imagePath,
          },
        ),
        returnValue: _i8.Future<String>.value(_i7.dummyValue<String>(
          this,
          Invocation.method(
            #uploadProfilePic,
            [],
            {
              #path: path,
              #imagePath: imagePath,
            },
          ),
        )),
      ) as _i8.Future<String>);

  @override
  _i8.Future<void> deleteProfileImage(String? path) => (super.noSuchMethod(
        Invocation.method(
          #deleteProfileImage,
          [path],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<void> deleteStorageFolder(String? path) => (super.noSuchMethod(
        Invocation.method(
          #deleteStorageFolder,
          [path],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
}

/// A class which mocks [ImagePicker].
///
/// See the documentation for Mockito's code generation for more information.
class MockImagePicker extends _i1.Mock implements _i5.ImagePicker {
  MockImagePicker() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i5.XFile?> pickImage({
    required _i5.ImageSource? source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    _i5.CameraDevice? preferredCameraDevice = _i5.CameraDevice.rear,
    bool? requestFullMetadata = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #pickImage,
          [],
          {
            #source: source,
            #maxWidth: maxWidth,
            #maxHeight: maxHeight,
            #imageQuality: imageQuality,
            #preferredCameraDevice: preferredCameraDevice,
            #requestFullMetadata: requestFullMetadata,
          },
        ),
        returnValue: _i8.Future<_i5.XFile?>.value(),
      ) as _i8.Future<_i5.XFile?>);

  @override
  _i8.Future<List<_i5.XFile>> pickMultiImage({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    bool? requestFullMetadata = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #pickMultiImage,
          [],
          {
            #maxWidth: maxWidth,
            #maxHeight: maxHeight,
            #imageQuality: imageQuality,
            #requestFullMetadata: requestFullMetadata,
          },
        ),
        returnValue: _i8.Future<List<_i5.XFile>>.value(<_i5.XFile>[]),
      ) as _i8.Future<List<_i5.XFile>>);

  @override
  _i8.Future<_i5.XFile?> pickMedia({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    bool? requestFullMetadata = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #pickMedia,
          [],
          {
            #maxWidth: maxWidth,
            #maxHeight: maxHeight,
            #imageQuality: imageQuality,
            #requestFullMetadata: requestFullMetadata,
          },
        ),
        returnValue: _i8.Future<_i5.XFile?>.value(),
      ) as _i8.Future<_i5.XFile?>);

  @override
  _i8.Future<List<_i5.XFile>> pickMultipleMedia({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    bool? requestFullMetadata = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #pickMultipleMedia,
          [],
          {
            #maxWidth: maxWidth,
            #maxHeight: maxHeight,
            #imageQuality: imageQuality,
            #requestFullMetadata: requestFullMetadata,
          },
        ),
        returnValue: _i8.Future<List<_i5.XFile>>.value(<_i5.XFile>[]),
      ) as _i8.Future<List<_i5.XFile>>);

  @override
  _i8.Future<_i5.XFile?> pickVideo({
    required _i5.ImageSource? source,
    _i5.CameraDevice? preferredCameraDevice = _i5.CameraDevice.rear,
    Duration? maxDuration,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #pickVideo,
          [],
          {
            #source: source,
            #preferredCameraDevice: preferredCameraDevice,
            #maxDuration: maxDuration,
          },
        ),
        returnValue: _i8.Future<_i5.XFile?>.value(),
      ) as _i8.Future<_i5.XFile?>);

  @override
  _i8.Future<_i5.LostDataResponse> retrieveLostData() => (super.noSuchMethod(
        Invocation.method(
          #retrieveLostData,
          [],
        ),
        returnValue:
            _i8.Future<_i5.LostDataResponse>.value(_FakeLostDataResponse_3(
          this,
          Invocation.method(
            #retrieveLostData,
            [],
          ),
        )),
      ) as _i8.Future<_i5.LostDataResponse>);

  @override
  bool supportsImageSource(_i5.ImageSource? source) => (super.noSuchMethod(
        Invocation.method(
          #supportsImageSource,
          [source],
        ),
        returnValue: false,
      ) as bool);
}
