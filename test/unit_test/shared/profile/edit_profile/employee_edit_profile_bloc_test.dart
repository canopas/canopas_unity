import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/pref/user_preference.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/storage_service.dart';
import 'package:projectunity/ui/shared/profile/edit_profile/bloc/employee_edit_profile_bloc.dart';
import 'package:projectunity/ui/shared/profile/edit_profile/bloc/employee_edit_profile_event.dart';
import 'package:projectunity/ui/shared/profile/edit_profile/bloc/employee_edit_profile_state.dart';

import 'employee_edit_profile_bloc_test.mocks.dart';

@GenerateMocks([
  EmployeeService,
  UserStateNotifier,
  UserPreference,
  StorageService,
])
void main() {
  late EmployeeService employeeService;
  late UserStateNotifier userStateNotifier;
  late UserPreference preference;
  late StorageService storageService;
  late EmployeeEditProfileBloc editEmployeeDetailsBloc;

  Employee emp = Employee(
      uid: "123",
      role: Role.admin,
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
      userStateNotifier = MockUserStateNotifier();
      preference = MockUserPreference();
      storageService = MockStorageService();
      editEmployeeDetailsBloc = EmployeeEditProfileBloc(employeeService,
          preference, userStateNotifier, storageService);
      when(userStateNotifier.employeeId).thenReturn(emp.uid);
      when(userStateNotifier.employee).thenReturn(emp);
      when(userStateNotifier.currentSpaceId).thenReturn('sid');
      when(userStateNotifier.userUID).thenReturn('123');
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

    test('Emits state with change image', () {
      editEmployeeDetailsBloc.add(ChangeImageEvent('path'));
      expectLater(editEmployeeDetailsBloc.stream,
          emits(const EmployeeEditProfileState(imageURL: 'path')));
    });

    test('Should upload profile on storage if user set profile picture',
        () async {
      editEmployeeDetailsBloc
          .add(ChangeImageEvent('path'));

      const storagePath = 'images/sid/123/profile';
      when(storageService.uploadProfilePic(
              path: storagePath, file: XFile('path')))
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
                status: Status.loading, imageURL: null),
            const EmployeeEditProfileState(
                status: Status.loading, imageURL: 'path'),
            const EmployeeEditProfileState(
                status: Status.success, imageURL: 'path')
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
                status: Status.loading),
            EmployeeEditProfileState(
                dateOfBirth: emp.dateOfBirth!.toDate,
                gender: emp.gender,
                status: Status.success),
          ]));

      await untilCalled(employeeService.updateEmployeeDetails(employee: emp));
      verify(employeeService.updateEmployeeDetails(employee: emp)).called(1);

      await untilCalled(preference.setEmployee(emp));
      verify(preference.setEmployee(emp)).called(1);
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
                status: Status.loading),
            EmployeeEditProfileState(
                dateOfBirth: emp.dateOfBirth!.toDate,
                gender: 1,
                status: Status.error,
                error: firestoreFetchDataError),
          ]));

      await untilCalled(employeeService.updateEmployeeDetails(employee: emp));
      verify(employeeService.updateEmployeeDetails(employee: emp)).called(1);
    });
  });
}
