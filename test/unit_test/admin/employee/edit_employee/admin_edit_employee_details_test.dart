import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/ui/admin/employee/edit_employee/bloc/admin_edit_employee_bloc.dart';
import 'package:projectunity/ui/admin/employee/edit_employee/bloc/admin_edit_employee_events.dart';
import 'package:projectunity/ui/admin/employee/edit_employee/bloc/admin_edit_employee_state.dart';

import 'admin_edit_employee_details_test.mocks.dart';

@GenerateMocks([EmployeeService])
void main() {
  late EmployeeService employeeService;
  late AdminEditEmployeeDetailsBloc editEmployeeDetailsBloc;

  Employee emp = Employee(
    uid: "123",
    role: Role.admin,
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
      editEmployeeDetailsBloc.add(EditEmployeeByAdminInitialEvent(
          dateOfJoining: emp.dateOfJoining, roleType: emp.role));
      expect(
          editEmployeeDetailsBloc.stream,
          emits(AdminEditEmployeeDetailsState(
              dateOfJoining: emp.dateOfJoining!.dateOnly, roleType: Role.admin)));
    });

    test('change role type test', () {
      editEmployeeDetailsBloc.emit(AdminEditEmployeeDetailsState(
          dateOfJoining: emp.dateOfJoining!.dateOnly, roleType: Role.admin));
      editEmployeeDetailsBloc.add(ChangeEmployeeRoleEvent(roleType: Role.employee));
      expect(
          editEmployeeDetailsBloc.stream,
          emits(AdminEditEmployeeDetailsState(
              dateOfJoining: emp.dateOfJoining!.dateOnly, roleType: Role.employee)));
    });

    test('change joining date test', () {
      editEmployeeDetailsBloc.emit(AdminEditEmployeeDetailsState(
          dateOfJoining: emp.dateOfJoining!.dateOnly, roleType: Role.admin));
      DateTime otherDate = DateTime.now().add(const Duration(days: 5)).dateOnly;
      editEmployeeDetailsBloc
          .add(ChangeEmployeeDateOfJoiningEvent(dateOfJoining: otherDate));
      expect(
          editEmployeeDetailsBloc.stream,
          emits(AdminEditEmployeeDetailsState(
              dateOfJoining: otherDate, roleType: Role.admin)));
    });

    test('test validation validation', () {
      editEmployeeDetailsBloc.add(ChangeEmployeeNameEvent(name: ""));
      editEmployeeDetailsBloc
          .add(ChangeEmployeeNameEvent(name: "Tester Dummy"));
      expect(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            const AdminEditEmployeeDetailsState(nameError: true),
            const AdminEditEmployeeDetailsState(nameError: false)
          ]));
    });

    test('test email validation', () {
      editEmployeeDetailsBloc.add(ChangeEmployeeEmailEvent(email: ""));
      editEmployeeDetailsBloc
          .add(ChangeEmployeeEmailEvent(email: "dummy123@gmail.com"));
      expect(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            const AdminEditEmployeeDetailsState(emailError: true),
            const AdminEditEmployeeDetailsState(emailError: false)
          ]));
    });

    test('test designation validation', () {
      editEmployeeDetailsBloc
          .add(ChangeEmployeeDesignationEvent(designation: ""));
      editEmployeeDetailsBloc.add(
          ChangeEmployeeDesignationEvent(designation: "Application Tester"));
      expect(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            const AdminEditEmployeeDetailsState(designationError: true),
            const AdminEditEmployeeDetailsState(designationError: false)
          ]));
    });

    test('test employeeId validation', () {
      editEmployeeDetailsBloc.add(ChangeEmployeeIdEvent(employeeId: ""));
      editEmployeeDetailsBloc.add(ChangeEmployeeIdEvent(employeeId: "CA-1000"));
      expect(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            const AdminEditEmployeeDetailsState(employeeIdError: true),
            const AdminEditEmployeeDetailsState(employeeIdError: false)
          ]));
    });

    test('update Employee details test', () async {
      editEmployeeDetailsBloc.add(EditEmployeeByAdminInitialEvent(
          roleType: emp.role, dateOfJoining: emp.dateOfJoining));
      editEmployeeDetailsBloc.add(UpdateEmployeeByAdminEvent(
          previousEmployeeData: emp,
          designation: emp.designation!,
          email: emp.email,
          employeeId: emp.employeeId!,
          level: emp.level!,
          name: emp.name));
      expect(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            AdminEditEmployeeDetailsState(
                dateOfJoining: emp.dateOfJoining!.dateOnly, roleType: Role.admin),
            AdminEditEmployeeDetailsState(
                dateOfJoining: emp.dateOfJoining!.dateOnly,
                roleType: Role.admin,
                adminEditEmployeeDetailsStatus:
                    AdminEditEmployeeDetailsStatus.loading),
            AdminEditEmployeeDetailsState(
                dateOfJoining: emp.dateOfJoining!.dateOnly,
                roleType: Role.admin,
                adminEditEmployeeDetailsStatus:
                    AdminEditEmployeeDetailsStatus.success),
          ]));
      await untilCalled(employeeService.updateEmployeeDetails(employee: emp));
      verify(employeeService.updateEmployeeDetails(employee: emp)).called(1);
    });

    test('update Employee details failed test', () async {
      editEmployeeDetailsBloc.add(EditEmployeeByAdminInitialEvent(
          dateOfJoining: emp.dateOfJoining, roleType: emp.role));
      when(employeeService.updateEmployeeDetails(employee: emp))
          .thenThrow(Exception("error"));
      editEmployeeDetailsBloc.add(UpdateEmployeeByAdminEvent(
          designation: emp.designation!,
          email: emp.email,
          employeeId: emp.employeeId!,
          level: emp.level!,
          name: emp.name,
          previousEmployeeData: emp));
      expect(
          editEmployeeDetailsBloc.stream,
          emitsInOrder([
            AdminEditEmployeeDetailsState(
                dateOfJoining: emp.dateOfJoining!.dateOnly, roleType: Role.admin),
            AdminEditEmployeeDetailsState(
                dateOfJoining: emp.dateOfJoining!.dateOnly,
                roleType: Role.admin,
                adminEditEmployeeDetailsStatus:
                    AdminEditEmployeeDetailsStatus.loading),
            AdminEditEmployeeDetailsState(
                dateOfJoining: emp.dateOfJoining!.dateOnly,
                roleType: Role.admin,
                adminEditEmployeeDetailsStatus:
                    AdminEditEmployeeDetailsStatus.failure,
                error: firestoreFetchDataError),
          ]));
      await untilCalled(employeeService.updateEmployeeDetails(employee: emp));
      verify(employeeService.updateEmployeeDetails(employee: emp)).called(1);
    });
  });
}
