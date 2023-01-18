import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/services/admin/employee_service.dart';
import 'package:projectunity/services/admin/leave_service.dart';
import 'package:projectunity/ui/user/user_home/bloc/user_home_bloc.dart';
import 'package:projectunity/ui/user/user_home/bloc/user_home_event.dart';
import 'package:projectunity/ui/user/user_home/bloc/user_home_state.dart';

import 'user_home_test.mocks.dart';

@GenerateMocks([
  AdminLeaveService,
  EmployeeService,
])
void main() {
  late UserHomeBloc bLoc;
  late EmployeeService employeeService;
  late AdminLeaveService adminLeaveService;

  const employee = Employee(
      id: "1",
      roleType: 2,
      name: "test",
      employeeId: "103",
      email: "abc@gmail.com",
      designation: "android dev");

  Leave leave = const Leave(
      leaveId: "101",
      uid: "1",
      leaveType: 1,
      startDate: 111,
      endDate: 113,
      totalLeaves: 1,
      reason: "test",
      leaveStatus: 0,
      appliedOn: 111,
      perDayDuration: []);
  late DateTime date;

  group('user home test', () {
    setUp(() {
      employeeService = MockEmployeeService();
      adminLeaveService = MockAdminLeaveService();
      bLoc = UserHomeBloc(employeeService, adminLeaveService);
      date = bLoc.state.dateOfAbsenceEmployee;
    });

    test('User home initial load test', () {
      when(adminLeaveService.getAllAbsence(
              date: bLoc.state.dateOfAbsenceEmployee))
          .thenAnswer((_) async => [leave]);
      when(employeeService.getEmployees()).thenAnswer((_) async => [employee]);
      bLoc.add(UserHomeFetchEvent());
      expectLater(
          bLoc.stream,
          emitsInOrder([
            UserHomeState(
                dateOfAbsenceEmployee: date, status: UserHomeStatus.loading),
            UserHomeState(
                dateOfAbsenceEmployee: date,
                status: UserHomeStatus.success,
                absence: [LeaveApplication(employee: employee, leave: leave)]),
          ]));
    });

    test('test before date fetch absence', () {
      when(adminLeaveService.getAllAbsence(
              date: bLoc.state.dateOfAbsenceEmployee
                  .subtract(const Duration(days: 1))))
          .thenAnswer((_) async => []);
      when(employeeService.getEmployees()).thenAnswer((_) async => [employee]);
      bLoc.add(ChangeToBeforeDateEvent());

      expectLater(
          bLoc.stream,
          emitsInOrder([
            UserHomeState(
                dateOfAbsenceEmployee: date.subtract(const Duration(days: 1)),
                status: UserHomeStatus.initial),
            UserHomeState(
                dateOfAbsenceEmployee: date.subtract(const Duration(days: 1)),
                status: UserHomeStatus.loading),
            UserHomeState(
                dateOfAbsenceEmployee: date.subtract(const Duration(days: 1)),
                status: UserHomeStatus.success,
                absence: const []),
          ]));
    });

    test('test after date fetch absence', () {
      when(adminLeaveService.getAllAbsence(
              date: bLoc.state.dateOfAbsenceEmployee
                  .add(const Duration(days: 1))))
          .thenAnswer((_) async => []);
      when(employeeService.getEmployees()).thenAnswer((_) async => [employee]);
      bLoc.add(ChangeToAfterDateEvent());

      expectLater(
          bLoc.stream,
          emitsInOrder([
            UserHomeState(
                dateOfAbsenceEmployee: date.add(const Duration(days: 1)),
                status: UserHomeStatus.initial),
            UserHomeState(
                dateOfAbsenceEmployee: date.add(const Duration(days: 1)),
                status: UserHomeStatus.loading),
            UserHomeState(
                dateOfAbsenceEmployee: date.add(const Duration(days: 1)),
                status: UserHomeStatus.success,
                absence: const []),
          ]));
    });
  });

  tearDown(() {
    bLoc.close();
  });
}
