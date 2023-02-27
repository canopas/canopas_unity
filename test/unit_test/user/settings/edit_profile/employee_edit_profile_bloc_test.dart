import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/pref/user_preference.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/admin/employee_service.dart';
import 'package:projectunity/ui/user/settings/edit_profile/bloc/emloyee_edit_profile_bloc.dart';
import 'package:projectunity/ui/user/settings/edit_profile/bloc/employee_edit_profile_event.dart';
import 'package:projectunity/ui/user/settings/edit_profile/bloc/employee_edit_profile_state.dart';

import 'employee_edit_profile_bloc_test.mocks.dart';

@GenerateMocks([EmployeeService, UserManager, UserPreference])
void main() {
  late EmployeeService employeeService;
  late UserManager userManager;
  late UserPreference preference;
  late EmployeeEditProfileBloc editEmployeeDetailsBloc;

  Employee emp = Employee(
      id: "123",
      roleType: 1,
      name: "dummy tester",
      employeeId: "CA-1000",
      email: "dummy.t@canopas.com",
      designation: "Application Tester",
      dateOfJoining: DateTime.now().dateOnly.timeStampToInt,
      level: "SW-L2",
      gender: EmployeeGender.male,
      dateOfBirth: DateTime.now().dateOnly.timeStampToInt,
      address: "california",
      bloodGroup: "B+",
      phone: "+1 000000-0000");

  group("admin-edit-employee-details-test", () {
    setUp(() {
      employeeService = MockEmployeeService();
      userManager = MockUserManager();
      preference = MockUserPreference();
      editEmployeeDetailsBloc =
          EmployeeEditProfileBloc(employeeService, preference, userManager);
      when(userManager.employeeId).thenReturn(emp.id);
      when(userManager.employee).thenReturn(emp);
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

    test('test designation validation', () {
      editEmployeeDetailsBloc
          .add(EditProfileDesignationChangedEvent(designation: ""));
      editEmployeeDetailsBloc.add(EditProfileDesignationChangedEvent(
          designation: "Application Tester"));
      expect(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            const EmployeeEditProfileState(designationError: true),
            const EmployeeEditProfileState(designationError: false)
          ]));
    });

    test('update Employee details success test', () async {
      editEmployeeDetailsBloc.add(EditProfileInitialLoadEvent(
          gender: emp.gender, dateOfBirth: emp.dateOfBirth));
      editEmployeeDetailsBloc.add(EditProfileUpdateProfileEvent(
          name: emp.name,
          designation: emp.designation,
          phoneNumber: emp.phone!,
          bloodGroup: emp.bloodGroup!,
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
                status: EmployeeProfileState.loading),
            EmployeeEditProfileState(
                dateOfBirth: emp.dateOfBirth!.toDate,
                gender: emp.gender,
                status: EmployeeProfileState.success),
          ]));

      await untilCalled(employeeService.updateEmployeeDetails(employee: emp));
      verify(employeeService.updateEmployeeDetails(employee: emp)).called(1);

      await untilCalled(preference.setCurrentUser(emp));
      verify(preference.setCurrentUser(emp)).called(1);
    });

    test('Emits error state while updating data on firestore', () async {
      editEmployeeDetailsBloc.add(EditProfileInitialLoadEvent(
          gender: emp.gender, dateOfBirth: emp.dateOfBirth));
      when(employeeService.updateEmployeeDetails(employee: emp))
          .thenThrow(Exception("error"));
      editEmployeeDetailsBloc.add(EditProfileUpdateProfileEvent(
          name: emp.name,
          designation: emp.designation,
          phoneNumber: emp.phone!,
          bloodGroup: emp.bloodGroup!,
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
                status: EmployeeProfileState.loading),
            EmployeeEditProfileState(
                dateOfBirth: emp.dateOfBirth!.toDate,
                gender: 1,
                status: EmployeeProfileState.failure,
                error: firestoreFetchDataError),
          ]));

      await untilCalled(employeeService.updateEmployeeDetails(employee: emp));
      verify(employeeService.updateEmployeeDetails(employee: emp)).called(1);
    });
  });
}
