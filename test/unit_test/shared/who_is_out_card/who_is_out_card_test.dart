import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/model/leave_application.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:projectunity/ui/shared/WhoIsOutCard/bloc/who_is_out_card_bloc.dart';
import 'package:projectunity/ui/shared/WhoIsOutCard/bloc/who_is_out_card_event.dart';
import 'package:projectunity/ui/shared/WhoIsOutCard/bloc/who_is_out_card_state.dart';

import 'who_is_out_card_test.mocks.dart';

@GenerateMocks([
  LeaveService,
  EmployeeService,
])
void main() {
  late WhoIsOutCardBloc bLoc;
  late EmployeeService employeeService;
  late LeaveService leaveService;

  const employee = Employee(
    uid: "1",
    role: Role.employee,
    name: "test",
    employeeId: "103",
    email: "abc@gmail.com",
    designation: "android dev",
    dateOfJoining: 11,
  );

  Leave leave = const Leave(
      leaveId: "101",
      uid: "1",
      type: 1,
      startDate: 111,
      endDate: 113,
      total: 1,
      reason: "test",
      status: 0,
      appliedOn: 111,
      perDayDuration: []);
  late DateTime date;

  group('user home test', () {
    setUp(() {
      employeeService = MockEmployeeService();
      leaveService = MockLeaveService();
      bLoc = WhoIsOutCardBloc(employeeService, leaveService);
      date = bLoc.state.dateOfAbsenceEmployee;
    });

    test('User home initial load test', () {
      when(leaveService.getAllAbsence(date: bLoc.state.dateOfAbsenceEmployee))
          .thenAnswer((_) async => [leave]);
      when(employeeService.getEmployees()).thenAnswer((_) async => [employee]);
      bLoc.add(WhoIsOutInitialLoadEvent());
      expectLater(
          bLoc.stream,
          emitsInOrder([
            WhoIsOutCardState(
                dateOfAbsenceEmployee: date, status: Status.loading),
            WhoIsOutCardState(
                dateOfAbsenceEmployee: date,
                status: Status.success,
                absence: [LeaveApplication(employee: employee, leave: leave)]),
          ]));
    });

    test('test before date fetch absence', () {
      when(leaveService.getAllAbsence(
              date: bLoc.state.dateOfAbsenceEmployee
                  .subtract(const Duration(days: 1))))
          .thenAnswer((_) async => []);
      when(employeeService.getEmployees()).thenAnswer((_) async => [employee]);
      bLoc.add(ChangeToBeforeDateEvent());

      expectLater(
          bLoc.stream,
          emitsInOrder([
            WhoIsOutCardState(
                dateOfAbsenceEmployee: date.subtract(const Duration(days: 1)),
                status: Status.initial),
            WhoIsOutCardState(
                dateOfAbsenceEmployee: date.subtract(const Duration(days: 1)),
                status: Status.loading),
            WhoIsOutCardState(
                dateOfAbsenceEmployee: date.subtract(const Duration(days: 1)),
                status: Status.success,
                absence: const []),
          ]));
    });

    test('test after date fetch absence', () {
      when(leaveService.getAllAbsence(
              date: bLoc.state.dateOfAbsenceEmployee
                  .add(const Duration(days: 1))))
          .thenAnswer((_) async => []);
      when(employeeService.getEmployees()).thenAnswer((_) async => [employee]);
      bLoc.add(ChangeToAfterDateEvent());

      expectLater(
          bLoc.stream,
          emitsInOrder([
            WhoIsOutCardState(
                dateOfAbsenceEmployee: date.add(const Duration(days: 1)),
                status: Status.initial),
            WhoIsOutCardState(
                dateOfAbsenceEmployee: date.add(const Duration(days: 1)),
                status: Status.loading),
            WhoIsOutCardState(
                dateOfAbsenceEmployee: date.add(const Duration(days: 1)),
                status: Status.success,
                absence: const []),
          ]));
    });
  });

  tearDown(() {
    bLoc.close();
  });
}
