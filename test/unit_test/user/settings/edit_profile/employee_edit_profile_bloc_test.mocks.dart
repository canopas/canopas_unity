// Mocks generated by Mockito 5.4.0 from annotations
// in projectunity/test/unit_test/user/settings/edit_profile/employee_edit_profile_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:io' as _i14;
import 'dart:ui' as _i11;

import 'package:cloud_firestore/cloud_firestore.dart' as _i2;
import 'package:firebase_storage/firebase_storage.dart' as _i4;
import 'package:image_picker/image_picker.dart' as _i15;
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart'
    as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:projectunity/data/model/account/account.dart' as _i9;
import 'package:projectunity/data/model/employee/employee.dart' as _i3;
import 'package:projectunity/data/model/space/space.dart' as _i10;
import 'package:projectunity/data/pref/user_preference.dart' as _i12;
import 'package:projectunity/data/provider/user_data.dart' as _i8;
import 'package:projectunity/data/services/employee_service.dart' as _i6;
import 'package:projectunity/data/services/storage_service.dart' as _i13;

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

class _FakeLostData_3 extends _i1.SmartFake implements _i5.LostData {
  _FakeLostData_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLostDataResponse_4 extends _i1.SmartFake
    implements _i5.LostDataResponse {
  _FakeLostDataResponse_4(
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
class MockEmployeeService extends _i1.Mock implements _i6.EmployeeService {
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
  _i7.Future<void> addEmployeeBySpaceId({
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
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<_i3.Employee?> getEmployeeBySpaceId({
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
        returnValue: _i7.Future<_i3.Employee?>.value(),
      ) as _i7.Future<_i3.Employee?>);
  @override
  _i7.Future<List<_i3.Employee>> getEmployees() => (super.noSuchMethod(
        Invocation.method(
          #getEmployees,
          [],
        ),
        returnValue: _i7.Future<List<_i3.Employee>>.value(<_i3.Employee>[]),
      ) as _i7.Future<List<_i3.Employee>>);
  @override
  _i7.Future<_i3.Employee?> getEmployee(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getEmployee,
          [id],
        ),
        returnValue: _i7.Future<_i3.Employee?>.value(),
      ) as _i7.Future<_i3.Employee?>);
  @override
  _i7.Future<bool> hasUser(String? email) => (super.noSuchMethod(
        Invocation.method(
          #hasUser,
          [email],
        ),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
  @override
  _i7.Future<void> addEmployee(_i3.Employee? employee) => (super.noSuchMethod(
        Invocation.method(
          #addEmployee,
          [employee],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> updateEmployeeDetails({required _i3.Employee? employee}) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateEmployeeDetails,
          [],
          {#employee: employee},
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> changeEmployeeRoleType(
    String? id,
    _i3.Role? role,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #changeEmployeeRoleType,
          [
            id,
            role,
          ],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> deleteEmployee(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteEmployee,
          [id],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
}

/// A class which mocks [UserManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserManager extends _i1.Mock implements _i8.UserManager {
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
  bool get redirect => (super.noSuchMethod(
        Invocation.getter(#redirect),
        returnValue: false,
      ) as bool);
  @override
  set redirect(bool? _redirect) => super.noSuchMethod(
        Invocation.setter(
          #redirect,
          _redirect,
        ),
        returnValueForMissingStub: null,
      );
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
  _i7.Future<void> setUser(_i9.Account? user) => (super.noSuchMethod(
        Invocation.method(
          #setUser,
          [user],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> setSpace({
    required _i10.Space? space,
    required _i3.Employee? spaceUser,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #setSpace,
          [],
          {
            #space: space,
            #spaceUser: spaceUser,
          },
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> updateSpaceDetails(_i10.Space? space) => (super.noSuchMethod(
        Invocation.method(
          #updateSpaceDetails,
          [space],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> removeSpace() => (super.noSuchMethod(
        Invocation.method(
          #removeSpace,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> removeAll() => (super.noSuchMethod(
        Invocation.method(
          #removeAll,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  void hasLoggedIn() => super.noSuchMethod(
        Invocation.method(
          #hasLoggedIn,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addListener(_i11.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i11.VoidCallback? listener) => super.noSuchMethod(
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

/// A class which mocks [UserPreference].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserPreference extends _i1.Mock implements _i12.UserPreference {
  MockUserPreference() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<void> setUser(_i9.Account? user) => (super.noSuchMethod(
        Invocation.method(
          #setUser,
          [user],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> removeUser() => (super.noSuchMethod(
        Invocation.method(
          #removeUser,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> setSpace(_i10.Space? space) => (super.noSuchMethod(
        Invocation.method(
          #setSpace,
          [space],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> removeSpace() => (super.noSuchMethod(
        Invocation.method(
          #removeSpace,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> setSpaceUser(_i3.Employee? user) => (super.noSuchMethod(
        Invocation.method(
          #setSpaceUser,
          [user],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> removeSpaceUser() => (super.noSuchMethod(
        Invocation.method(
          #removeSpaceUser,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> clearAll() => (super.noSuchMethod(
        Invocation.method(
          #clearAll,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
}

/// A class which mocks [StorageService].
///
/// See the documentation for Mockito's code generation for more information.
class MockStorageService extends _i1.Mock implements _i13.StorageService {
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
  _i7.Future<String> uploadProfilePic({
    required String? path,
    required _i14.File? file,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #uploadProfilePic,
          [],
          {
            #path: path,
            #file: file,
          },
        ),
        returnValue: _i7.Future<String>.value(''),
      ) as _i7.Future<String>);
  @override
  _i7.Future<void> deleteProfileImage(String? path) => (super.noSuchMethod(
        Invocation.method(
          #deleteProfileImage,
          [path],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
}

/// A class which mocks [ImagePicker].
///
/// See the documentation for Mockito's code generation for more information.
class MockImagePicker extends _i1.Mock implements _i15.ImagePicker {
  MockImagePicker() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i5.PickedFile?> getImage({
    required _i5.ImageSource? source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    _i5.CameraDevice? preferredCameraDevice = _i5.CameraDevice.rear,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getImage,
          [],
          {
            #source: source,
            #maxWidth: maxWidth,
            #maxHeight: maxHeight,
            #imageQuality: imageQuality,
            #preferredCameraDevice: preferredCameraDevice,
          },
        ),
        returnValue: _i7.Future<_i5.PickedFile?>.value(),
      ) as _i7.Future<_i5.PickedFile?>);
  @override
  _i7.Future<List<_i5.PickedFile>?> getMultiImage({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMultiImage,
          [],
          {
            #maxWidth: maxWidth,
            #maxHeight: maxHeight,
            #imageQuality: imageQuality,
          },
        ),
        returnValue: _i7.Future<List<_i5.PickedFile>?>.value(),
      ) as _i7.Future<List<_i5.PickedFile>?>);
  @override
  _i7.Future<_i5.PickedFile?> getVideo({
    required _i5.ImageSource? source,
    _i5.CameraDevice? preferredCameraDevice = _i5.CameraDevice.rear,
    Duration? maxDuration,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getVideo,
          [],
          {
            #source: source,
            #preferredCameraDevice: preferredCameraDevice,
            #maxDuration: maxDuration,
          },
        ),
        returnValue: _i7.Future<_i5.PickedFile?>.value(),
      ) as _i7.Future<_i5.PickedFile?>);
  @override
  _i7.Future<_i5.LostData> getLostData() => (super.noSuchMethod(
        Invocation.method(
          #getLostData,
          [],
        ),
        returnValue: _i7.Future<_i5.LostData>.value(_FakeLostData_3(
          this,
          Invocation.method(
            #getLostData,
            [],
          ),
        )),
      ) as _i7.Future<_i5.LostData>);
  @override
  _i7.Future<_i5.XFile?> pickImage({
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
        returnValue: _i7.Future<_i5.XFile?>.value(),
      ) as _i7.Future<_i5.XFile?>);
  @override
  _i7.Future<List<_i5.XFile>> pickMultiImage({
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
        returnValue: _i7.Future<List<_i5.XFile>>.value(<_i5.XFile>[]),
      ) as _i7.Future<List<_i5.XFile>>);
  @override
  _i7.Future<_i5.XFile?> pickVideo({
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
        returnValue: _i7.Future<_i5.XFile?>.value(),
      ) as _i7.Future<_i5.XFile?>);
  @override
  _i7.Future<_i5.LostDataResponse> retrieveLostData() => (super.noSuchMethod(
        Invocation.method(
          #retrieveLostData,
          [],
        ),
        returnValue:
            _i7.Future<_i5.LostDataResponse>.value(_FakeLostDataResponse_4(
          this,
          Invocation.method(
            #retrieveLostData,
            [],
          ),
        )),
      ) as _i7.Future<_i5.LostDataResponse>);
}
