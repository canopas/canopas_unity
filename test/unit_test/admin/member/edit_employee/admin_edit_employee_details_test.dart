import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/storage_service.dart';
import 'package:projectunity/ui/admin/members/edit_employee/bloc/admin_edit_employee_bloc.dart';
import 'package:projectunity/ui/admin/members/edit_employee/bloc/admin_edit_employee_events.dart';
import 'package:projectunity/ui/admin/members/edit_employee/bloc/admin_edit_employee_state.dart';

import 'admin_edit_employee_details_test.mocks.dart';

@GenerateMocks([EmployeeService, StorageService, UserStateNotifier])
void main() {
  late UserStateNotifier userStateNotifier;
  late StorageService storageService;
  late EmployeeService employeeService;
  late AdminEditEmployeeDetailsBloc editEmployeeDetailsBloc;

  Employee emp = Employee(
    imageUrl: 'image-url',
    uid: "123",
    role: Role.admin,
    name: "dummy tester",
    employeeId: "CA-1000",
    email: "dummy.t@canopas.com",
    designation: "Application Tester",
    dateOfJoining: DateTime.now().dateOnly,
    level: "SW-L2",
  );

  group("admin-edit-employee-details-test", () {
    setUp(() {
      employeeService = MockEmployeeService();
      storageService = MockStorageService();
      userStateNotifier = MockUserStateNotifier();
      editEmployeeDetailsBloc = AdminEditEmployeeDetailsBloc(
          employeeService, userStateNotifier, storageService);
    });

    test('test initial test', () {
      editEmployeeDetailsBloc.add(EditEmployeeByAdminInitialEvent(
          dateOfJoining: emp.dateOfJoining, roleType: emp.role));
      expect(
          editEmployeeDetailsBloc.stream,
          emits(AdminEditEmployeeDetailsState(
              dateOfJoining: emp.dateOfJoining.dateOnly, role: Role.admin)));
    });

    test('change role type test', () {
      editEmployeeDetailsBloc.emit(AdminEditEmployeeDetailsState(
          dateOfJoining: emp.dateOfJoining.dateOnly, role: Role.admin));
      editEmployeeDetailsBloc
          .add(ChangeEmployeeRoleEvent(roleType: Role.employee));
      expect(
          editEmployeeDetailsBloc.stream,
          emits(AdminEditEmployeeDetailsState(
              dateOfJoining: emp.dateOfJoining.dateOnly, role: Role.employee)));
    });

    test('change joining date test', () {
      editEmployeeDetailsBloc.emit(AdminEditEmployeeDetailsState(
          dateOfJoining: emp.dateOfJoining.dateOnly, role: Role.admin));
      DateTime otherDate = DateTime.now().add(const Duration(days: 5)).dateOnly;
      editEmployeeDetailsBloc
          .add(ChangeEmployeeDateOfJoiningEvent(dateOfJoining: otherDate));
      expect(
          editEmployeeDetailsBloc.stream,
          emits(AdminEditEmployeeDetailsState(
              dateOfJoining: otherDate, role: Role.admin)));
    });

    test('pick and change profile image test', () {
      editEmployeeDetailsBloc.add(ChangeProfileImageEvent('path'));
      expect(editEmployeeDetailsBloc.stream,
          emits(const AdminEditEmployeeDetailsState(pickedImage: 'path')));
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
                dateOfJoining: emp.dateOfJoining.dateOnly, role: Role.admin),
            AdminEditEmployeeDetailsState(
                dateOfJoining: emp.dateOfJoining.dateOnly,
                role: Role.admin,
                status: Status.loading),
            AdminEditEmployeeDetailsState(
                dateOfJoining: emp.dateOfJoining.dateOnly,
                role: Role.admin,
                status: Status.success),
          ]));
      await untilCalled(employeeService.updateEmployeeDetails(employee: emp));
      verify(employeeService.updateEmployeeDetails(employee: emp)).called(1);
    });

    test('update Employee details with profile test', () async {
      when(userStateNotifier.currentSpaceId).thenReturn('space-id');

      editEmployeeDetailsBloc.add(EditEmployeeByAdminInitialEvent(
          roleType: emp.role, dateOfJoining: emp.dateOfJoining));
      editEmployeeDetailsBloc.add(ChangeProfileImageEvent('path'));
      when(storageService.uploadProfilePic(
              path: 'images/space-id/${emp.uid}/profile', imagePath: 'path'))
          .thenAnswer((realInvocation) async => 'image-url');
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
                dateOfJoining: emp.dateOfJoining.dateOnly, role: Role.admin),
            AdminEditEmployeeDetailsState(
                dateOfJoining: emp.dateOfJoining.dateOnly,
                role: Role.admin,
                pickedImage: 'path'),
            AdminEditEmployeeDetailsState(
              status: Status.loading,
              dateOfJoining: emp.dateOfJoining.dateOnly,
              role: Role.admin,
              pickedImage: 'path',
            ),
            AdminEditEmployeeDetailsState(
                dateOfJoining: emp.dateOfJoining.dateOnly,
                role: Role.admin,
                pickedImage: 'path',
                status: Status.success),
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
                dateOfJoining: emp.dateOfJoining.dateOnly, role: Role.admin),
            AdminEditEmployeeDetailsState(
                dateOfJoining: emp.dateOfJoining.dateOnly,
                role: Role.admin,
                status: Status.loading),
            AdminEditEmployeeDetailsState(
                dateOfJoining: emp.dateOfJoining.dateOnly,
                role: Role.admin,
                status: Status.error,
                error: firestoreFetchDataError),
          ]));
      await untilCalled(employeeService.updateEmployeeDetails(employee: emp));
      verify(employeeService.updateEmployeeDetails(employee: emp)).called(1);
    });
  });
}
