import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/services/admin/employee_service.dart';
import 'package:projectunity/ui/admin/edit_employe_details/bloc/admin_edit_employee_details_bloc.dart';
import 'package:projectunity/ui/admin/edit_employe_details/bloc/admin_edit_employee_details_events.dart';
import 'package:projectunity/ui/admin/edit_employe_details/bloc/admin_edit_employee_details_state.dart';

import 'admin_edit_employee_details_test.mocks.dart';

@GenerateMocks([EmployeeService])
void main() {
  late EmployeeService employeeService;
  late AdminEditEmployeeDetailsBloc editEmployeeDetailsBloc;

  Employee emp = Employee(
    id: "123",
    roleType: 1,
    name: "dummy tester",
    employeeId: "CA-1000",
    email: "dummy.t@canopas.com",
    designation: "Application Tester",
    dateOfJoining: DateTime.now().dateOnly.timeStampToInt,
    level: "SW-L2",
  );

  group("admin-edit-employee-details-test", () {
    setUp(() {
      employeeService = MockEmployeeService();
      editEmployeeDetailsBloc = AdminEditEmployeeDetailsBloc(employeeService);
    });

    test('test initial test', () {
      editEmployeeDetailsBloc.add(AdminEditEmployeeDetailsInitialEvent(
          dateOfJoining: emp.dateOfJoining, roleType: emp.roleType));
      expect(
          editEmployeeDetailsBloc.stream,
          emits(AdminEditEmployeeDetailsState(
              dateOfJoining: emp.dateOfJoining!.dateOnly, roleType: 1)));
    });

    test('change role type test', () {
      editEmployeeDetailsBloc.emit(AdminEditEmployeeDetailsState(
          dateOfJoining: emp.dateOfJoining!.dateOnly, roleType: 1));
      editEmployeeDetailsBloc
          .add(ChangeRoleTypeAdminEditEmployeeDetailsEvent(roleType: 2));
      expect(
          editEmployeeDetailsBloc.stream,
          emits(AdminEditEmployeeDetailsState(
              dateOfJoining: emp.dateOfJoining!.dateOnly, roleType: 2)));
    });

    test('change joining date test', () {
      editEmployeeDetailsBloc.emit(AdminEditEmployeeDetailsState(
          dateOfJoining: emp.dateOfJoining!.dateOnly, roleType: 1));
      DateTime otherDate = DateTime.now().add(const Duration(days: 5)).dateOnly;
      editEmployeeDetailsBloc.add(
          ChangeDateOfJoiningAdminEditEmployeeDetailsEvent(
              dateOfJoining: otherDate));
      expect(
          editEmployeeDetailsBloc.stream,
          emits(AdminEditEmployeeDetailsState(
              dateOfJoining: otherDate, roleType: 1)));
    });

    test('test validation validation', () {
      editEmployeeDetailsBloc
          .add(ValidNameAdminEditEmployeeDetailsEvent(name: ""));
      editEmployeeDetailsBloc
          .add(ValidNameAdminEditEmployeeDetailsEvent(name: "Tester Dummy"));
      expect(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            const AdminEditEmployeeDetailsState(nameError: true),
            const AdminEditEmployeeDetailsState(nameError: false)
          ]));
    });

    test('test email validation', () {
      editEmployeeDetailsBloc
          .add(ValidEmailAdminEditEmployeeDetailsEvent(email: ""));
      editEmployeeDetailsBloc.add(
          ValidEmailAdminEditEmployeeDetailsEvent(email: "dummy123@gmail.com"));
      expect(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            const AdminEditEmployeeDetailsState(emailError: true),
            const AdminEditEmployeeDetailsState(emailError: false)
          ]));
    });

    test('test designation validation', () {
      editEmployeeDetailsBloc
          .add(ValidDesignationAdminEditEmployeeDetailsEvent(designation: ""));
      editEmployeeDetailsBloc.add(ValidDesignationAdminEditEmployeeDetailsEvent(
          designation: "Application Tester"));
      expect(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            const AdminEditEmployeeDetailsState(designationError: true),
            const AdminEditEmployeeDetailsState(designationError: false)
          ]));
    });

    test('test employeeId validation', () {
      editEmployeeDetailsBloc
          .add(ValidEmployeeIdAdminEditEmployeeDetailsEvent(employeeId: ""));
      editEmployeeDetailsBloc.add(
          ValidEmployeeIdAdminEditEmployeeDetailsEvent(employeeId: "CA-1000"));
      expect(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            const AdminEditEmployeeDetailsState(employeeIdError: true),
            const AdminEditEmployeeDetailsState(employeeIdError: false)
          ]));
    });

    test('update Employee details test', () async {
      editEmployeeDetailsBloc.add(AdminEditEmployeeDetailsInitialEvent(
          roleType: emp.roleType, dateOfJoining: emp.dateOfJoining));
      editEmployeeDetailsBloc.add(
          UpdateEmployeeDetailsAdminEditEmployeeDetailsEvent(
              previousEmployeeData: emp,
              designation: emp.designation,
              email: emp.email,
              employeeId: emp.employeeId,
              level: emp.level!,
              name: emp.name));
      expect(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            AdminEditEmployeeDetailsState(
                dateOfJoining: emp.dateOfJoining!.dateOnly, roleType: 1),
            AdminEditEmployeeDetailsState(
                dateOfJoining: emp.dateOfJoining!.dateOnly,
                roleType: 1,
                adminEditEmployeeDetailsStatus:
                    AdminEditEmployeeDetailsStatus.loading),
            AdminEditEmployeeDetailsState(
                dateOfJoining: emp.dateOfJoining!.dateOnly,
                roleType: 1,
                adminEditEmployeeDetailsStatus:
                    AdminEditEmployeeDetailsStatus.success),
          ]));
      await untilCalled(
          employeeService.updateEmployeeDetails(employee: emp));
      verify(employeeService.updateEmployeeDetails(employee: emp))
          .called(1);
    });

    test('update Employee details failed test', () async {
      editEmployeeDetailsBloc.add(AdminEditEmployeeDetailsInitialEvent(
          dateOfJoining: emp.dateOfJoining, roleType: emp.roleType));
      when(employeeService.updateEmployeeDetails(employee: emp))
          .thenThrow(Exception("error"));
      editEmployeeDetailsBloc.add(
          UpdateEmployeeDetailsAdminEditEmployeeDetailsEvent(
              designation: emp.designation,
              email: emp.email,
              employeeId: emp.employeeId,
              level: emp.level!,
              name: emp.name,
              previousEmployeeData: emp));
      expect(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            AdminEditEmployeeDetailsState(
                dateOfJoining: emp.dateOfJoining!.dateOnly, roleType: 1),
            AdminEditEmployeeDetailsState(
                dateOfJoining: emp.dateOfJoining!.dateOnly,
                roleType: 1,
                adminEditEmployeeDetailsStatus:
                    AdminEditEmployeeDetailsStatus.loading),
            AdminEditEmployeeDetailsState(
                dateOfJoining: emp.dateOfJoining!.dateOnly,
                roleType: 1,
                adminEditEmployeeDetailsStatus:
                    AdminEditEmployeeDetailsStatus.failure,
                error: firestoreFetchDataError),
          ]));
      await untilCalled(
          employeeService.updateEmployeeDetails(employee: emp));
      verify(employeeService.updateEmployeeDetails(employee: emp))
          .called(1);
    });
  });
}
