import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/pref/user_preference.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/storage_service.dart';
import 'package:projectunity/ui/user/settings/edit_profile/bloc/employee_edit_profile_bloc.dart';
import 'package:projectunity/ui/user/settings/edit_profile/bloc/employee_edit_profile_event.dart';
import 'package:projectunity/ui/user/settings/edit_profile/bloc/employee_edit_profile_state.dart';

import 'employee_edit_profile_bloc_test.mocks.dart';

@GenerateMocks([EmployeeService, UserManager, UserPreference,StorageService,ImagePicker])
void main() {
  late EmployeeService employeeService;
  late UserManager userManager;
  late UserPreference preference;
  late StorageService storageService;
  late ImagePicker imagePicker;
  late EmployeeEditProfileBloc editEmployeeDetailsBloc;

  Employee emp = Employee(
      uid: "123",
      role: 1,
      name: "dummy tester",
      employeeId: "CA-1000",
      email: "dummy.t@canopas.com",
      designation: "Application Tester",
      dateOfJoining: DateTime.now().dateOnly.timeStampToInt,
      level: "SW-L2",
      gender: EmployeeGender.male,
      dateOfBirth: DateTime.now().dateOnly.timeStampToInt,
      address: "california",
      phone: "+1 000000-0000");

  group("admin-edit-employee-details-test", () {
    setUp(() {
      employeeService = MockEmployeeService();
      userManager = MockUserManager();
      preference = MockUserPreference();
      storageService = MockStorageService();
      imagePicker = MockImagePicker();
      editEmployeeDetailsBloc = EmployeeEditProfileBloc(employeeService,
          preference, userManager, storageService, imagePicker);
      when(userManager.employeeId).thenReturn(emp.uid);
      when(userManager.employee).thenReturn(emp);
      when(userManager.currentSpaceId).thenReturn('sid');
      when(userManager.userUID).thenReturn('123');
    });

    test('test initial test', () {
      editEmployeeDetailsBloc.add(EditProfileInitialLoadEvent(
          gender: emp.gender, dateOfBirth: emp.dateOfBirth));
      expect(
          editEmployeeDetailsBloc.stream,
          emits(EmployeeEditProfileState(
              dateOfBirth: emp.dateOfBirth!.toDate, gender: emp.gender)));
    });

    test('test name validation', () {
      editEmployeeDetailsBloc.add(EditProfileNameChangedEvent(name: ""));
      editEmployeeDetailsBloc
          .add(EditProfileNameChangedEvent(name: "Tester Dummy"));
      expect(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            const EmployeeEditProfileState(nameError: true),
            const EmployeeEditProfileState(nameError: false)
          ]));
    });

    test('Emits state with image if user picked image from gallery', () {
      editEmployeeDetailsBloc
          .add(ChangeImageEvent(imageSource: ImageSource.gallery));
      final XFile file = XFile('path');
      when(imagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => file);
      expectLater(editEmployeeDetailsBloc.stream,
          emitsInOrder([EmployeeEditProfileState(imageURL: file.path)]));
    });
    test('Emits state with image if user picked image from camera', () {
      editEmployeeDetailsBloc
          .add(ChangeImageEvent(imageSource: ImageSource.camera));
      final XFile file = XFile('path');
      when(imagePicker.pickImage(source: ImageSource.camera))
          .thenAnswer((_) async => file);
      expectLater(editEmployeeDetailsBloc.stream,
          emitsInOrder([EmployeeEditProfileState(imageURL: file.path)]));
    });
    test('Should upload profile on storage if user set profile picture',
        () async {
      editEmployeeDetailsBloc
          .add(ChangeImageEvent(imageSource: ImageSource.camera));
      final XFile file = XFile('path');
      when(imagePicker.pickImage(source: ImageSource.camera))
          .thenAnswer((_) async => file);

      const storagePath = 'images/sid/123/profile';
      when(storageService.uploadProfilePic(storagePath, File(file.path)))
          .thenAnswer((_) async => 'uid');

      editEmployeeDetailsBloc.add(EditProfileUpdateProfileEvent(
          name: emp.name,
          designation: emp.designation!,
          phoneNumber: emp.phone!,
          address: emp.address!,
          level: emp.level!));

      expectLater(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            const EmployeeEditProfileState(
                status: EmployeeEditProfileStatus.loading, imageURL: null),
            EmployeeEditProfileState(
                status: EmployeeEditProfileStatus.loading, imageURL: file.path),
            EmployeeEditProfileState(
                status: EmployeeEditProfileStatus.success, imageURL: file.path)
          ]));
    });

    test('update Employee details success test', () async {
      editEmployeeDetailsBloc.add(EditProfileInitialLoadEvent(
          gender: emp.gender, dateOfBirth: emp.dateOfBirth));
      editEmployeeDetailsBloc.add(EditProfileUpdateProfileEvent(
          name: emp.name,
          designation: emp.designation!,
          phoneNumber: emp.phone!,
          address: emp.address!,
          level: emp.level!));
      expectLater(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            EmployeeEditProfileState(
                dateOfBirth: emp.dateOfBirth!.toDate, gender: emp.gender),
            EmployeeEditProfileState(
                dateOfBirth: emp.dateOfBirth!.toDate,
                gender: emp.gender,
                status: EmployeeEditProfileStatus.loading),
            EmployeeEditProfileState(
                dateOfBirth: emp.dateOfBirth!.toDate,
                gender: emp.gender,
                status: EmployeeEditProfileStatus.success),
          ]));

      await untilCalled(employeeService.updateEmployeeDetails(employee: emp));
      verify(employeeService.updateEmployeeDetails(employee: emp)).called(1);

      await untilCalled(preference.setSpaceUser(emp));
      verify(preference.setSpaceUser(emp)).called(1);
    });

    test('Emits error state while updating data on firestore', () async {
      editEmployeeDetailsBloc.add(EditProfileInitialLoadEvent(
          gender: emp.gender, dateOfBirth: emp.dateOfBirth));
      when(employeeService.updateEmployeeDetails(employee: emp))
          .thenThrow(Exception("error"));
      editEmployeeDetailsBloc.add(EditProfileUpdateProfileEvent(
          name: emp.name,
          designation: emp.designation!,
          phoneNumber: emp.phone!,
          address: emp.address!,
          level: emp.level!));
      expectLater(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            EmployeeEditProfileState(
                dateOfBirth: emp.dateOfBirth!.toDate, gender: emp.gender),
            EmployeeEditProfileState(
                dateOfBirth: emp.dateOfBirth!.toDate,
                gender: 1,
                status: EmployeeEditProfileStatus.loading),
            EmployeeEditProfileState(
                dateOfBirth: emp.dateOfBirth!.toDate,
                gender: 1,
                status: EmployeeEditProfileStatus.failure,
                error: firestoreFetchDataError),
          ]));

      await untilCalled(employeeService.updateEmployeeDetails(employee: emp));
      verify(employeeService.updateEmployeeDetails(employee: emp)).called(1);
    });
  });
}
