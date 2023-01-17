import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/pref/user_preference.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/admin/employee_service.dart';
import 'package:projectunity/ui/user/edit_employee_details/bloc/edit_employee_details_employee_bloc.dart';
import 'package:projectunity/ui/user/edit_employee_details/bloc/edit_employee_details_employee_event.dart';
import 'package:projectunity/ui/user/edit_employee_details/bloc/edit_employee_details_employee_state.dart';

import 'edit_employee_details_view_test.mocks.dart';

@GenerateMocks([EmployeeService, UserManager, UserPreference])
void main() {
  late EmployeeService employeeService;
  late UserManager userManager;
  late UserPreference preference;
  late EmployeeEditEmployeeDetailsBloc editEmployeeDetailsBloc;

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
      editEmployeeDetailsBloc = EmployeeEditEmployeeDetailsBloc(
          employeeService, preference, userManager);
      when(userManager.employeeId).thenReturn(emp.id);
      when(userManager.employee).thenReturn(emp);
    });

    test('test initial test', () {
      editEmployeeDetailsBloc.add(EmployeeEditEmployeeDetailsInitialLoadEvent(
          gender: emp.gender, dateOfBirth: emp.dateOfBirth));
      expect(
          editEmployeeDetailsBloc.stream,
          emits(EmployeeEditEmployeeDetailsState(
              dateOfBirth: emp.dateOfBirth!.toDate, gender: emp.gender)));
    });

    test('test name validation', () {
      editEmployeeDetailsBloc
          .add(ValidNameEmployeeEditEmployeeDetailsEvent(name: ""));
      editEmployeeDetailsBloc
          .add(ValidNameEmployeeEditEmployeeDetailsEvent(name: "Tester Dummy"));
      expect(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            const EmployeeEditEmployeeDetailsState(nameError: true),
            const EmployeeEditEmployeeDetailsState(nameError: false)
          ]));
    });

    test('test designation validation', () {
      editEmployeeDetailsBloc.add(
          ValidDesignationEmployeeEditEmployeeDetailsEvent(designation: ""));
      editEmployeeDetailsBloc.add(
          ValidDesignationEmployeeEditEmployeeDetailsEvent(
              designation: "Application Tester"));
      expect(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            const EmployeeEditEmployeeDetailsState(designationError: true),
            const EmployeeEditEmployeeDetailsState(designationError: false)
          ]));
    });

    test('update Employee details success test', () async {
      editEmployeeDetailsBloc.add(EmployeeEditEmployeeDetailsInitialLoadEvent(
          gender: emp.gender, dateOfBirth: emp.dateOfBirth));
      editEmployeeDetailsBloc.add(UpdateEmployeeDetailsEvent(
          name: emp.name,
          designation: emp.designation,
          phoneNumber: emp.phone!,
          bloodGroup: emp.bloodGroup!,
          address: emp.address!,
          level: emp.level!));
      expectLater(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            EmployeeEditEmployeeDetailsState(
                dateOfBirth: emp.dateOfBirth!.toDate, gender: emp.gender),
            EmployeeEditEmployeeDetailsState(
                dateOfBirth: emp.dateOfBirth!.toDate,
                gender: emp.gender,
                status: EmployeeEditEmployeeDetailsStatus.loading),
            EmployeeEditEmployeeDetailsState(
                dateOfBirth: emp.dateOfBirth!.toDate,
                gender: emp.gender,
                status: EmployeeEditEmployeeDetailsStatus.success),
          ]));

      await untilCalled(employeeService.updateEmployeeDetails(employee: emp));
      verify(employeeService.updateEmployeeDetails(employee: emp)).called(1);

      await untilCalled(preference.setCurrentUser(emp));
      verify(preference.setCurrentUser(emp)).called(1);
    });

    test('update Employee details success test', () async {
      editEmployeeDetailsBloc.add(EmployeeEditEmployeeDetailsInitialLoadEvent(
          gender: emp.gender, dateOfBirth: emp.dateOfBirth));
      when(employeeService.updateEmployeeDetails(employee: emp))
          .thenThrow(Exception("error"));
      editEmployeeDetailsBloc.add(UpdateEmployeeDetailsEvent(
          name: emp.name,
          designation: emp.designation,
          phoneNumber: emp.phone!,
          bloodGroup: emp.bloodGroup!,
          address: emp.address!,
          level: emp.level!));
      expectLater(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            EmployeeEditEmployeeDetailsState(
                dateOfBirth: emp.dateOfBirth!.toDate, gender: emp.gender),
            EmployeeEditEmployeeDetailsState(
                dateOfBirth: emp.dateOfBirth!.toDate,
                gender: 1,
                status: EmployeeEditEmployeeDetailsStatus.loading),
            EmployeeEditEmployeeDetailsState(
                dateOfBirth: emp.dateOfBirth!.toDate,
                gender: 1,
                status: EmployeeEditEmployeeDetailsStatus.failure,
                error: firestoreFetchDataError),
          ]));

      await untilCalled(employeeService.updateEmployeeDetails(employee: emp));
      verify(employeeService.updateEmployeeDetails(employee: emp)).called(1);
    });
  });
}
