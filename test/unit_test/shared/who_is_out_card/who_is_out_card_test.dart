import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/model/leave_application.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:projectunity/ui/shared/who_is_out_card/bloc/who_is_out_card_bloc.dart';
import 'package:projectunity/ui/shared/who_is_out_card/bloc/who_is_out_card_event.dart';
import 'package:projectunity/ui/shared/who_is_out_card/bloc/who_is_out_card_state.dart';
import 'package:table_calendar/table_calendar.dart';

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
    uid: "uid",
    role: Role.employee,
    name: "tester",
    employeeId: "103",
    email: "tester@canopas.com",
    designation: "tester",
    dateOfJoining: 11,
  );

  late DateTime selectedDate;
  late DateTime focusDay;

  Leave leave = Leave(
      leaveId: "leave-id",
      uid: "uid",
      type: 1,
      startDate: DateTime.now().timeStampToInt,
      endDate: DateTime.now().timeStampToInt,
      total: 1,
      reason: "test",
      status: LeaveStatus.approved,
      appliedOn: DateTime.now().dateOnly.timeStampToInt,
      perDayDuration: const [LeaveDayDuration.fullLeave]);

  Leave nextMonthLeave = Leave(
      leaveId: "leave-id",
      uid: "uid",
      type: 1,
      startDate: DateTime(DateTime.now().year, DateTime.now().month + 1)
          .timeStampToInt,
      endDate: DateTime(DateTime.now().year, DateTime.now().month + 1)
          .timeStampToInt,
      total: 1,
      reason: "test",
      status: LeaveStatus.approved,
      appliedOn: DateTime.now().dateOnly.timeStampToInt,
      perDayDuration: const [LeaveDayDuration.fullLeave]);

  group('user home test', () {
    setUp(() {
      employeeService = MockEmployeeService();
      leaveService = MockLeaveService();
      bLoc = WhoIsOutCardBloc(employeeService, leaveService);
      selectedDate = bLoc.state.selectedDate;
      focusDay = bLoc.state.focusDay;
    });

    test("test success test of fetch initial month leaves", () {
      when(employeeService.getEmployees()).thenAnswer((_) async => [employee]);
      when(leaveService.getAllAbsence(date: selectedDate))
          .thenAnswer((_) async => [leave]);
      bLoc.add(WhoIsOutInitialLoadEvent());

      expect(
          bLoc.stream,
          emitsInOrder([
            WhoIsOutCardState(
                selectedDate: selectedDate,
                focusDay: focusDay,
                status: Status.loading),
            WhoIsOutCardState(
                selectedDate: selectedDate,
                focusDay: focusDay,
                status: Status.success,
                allAbsences: [
                  LeaveApplication(employee: employee, leave: leave)
                ],
                selectedDayAbsences: [
                  LeaveApplication(employee: employee, leave: leave)
                ]),
          ]));
    });

    test("test failure test of fetch initial month leaves", () {
      when(employeeService.getEmployees()).thenAnswer((_) async => [employee]);
      when(leaveService.getAllAbsence(date: selectedDate))
          .thenThrow(Exception("error"));
      bLoc.add(WhoIsOutInitialLoadEvent());

      expect(
          bLoc.stream,
          emitsInOrder([
            WhoIsOutCardState(
                selectedDate: selectedDate,
                focusDay: selectedDate,
                status: Status.loading),
            WhoIsOutCardState(
                selectedDate: selectedDate,
                focusDay: focusDay,
                status: Status.error,
                error: firestoreFetchDataError),
          ]));
    });

    test("Change Calendar format test", () {
      bLoc.add(ChangeCalendarFormat(CalendarFormat.month));
      expect(
          bLoc.stream,
          emits(WhoIsOutCardState(
              selectedDate: selectedDate,
              focusDay: focusDay,
              calendarFormat: CalendarFormat.month)));
    });

    test("no more fetch  leave if already fetched test", () {
      final currentMonthFirstDay = DateTime(focusDay.year, focusDay.month + 1);
      when(leaveService.getAllAbsence(date: currentMonthFirstDay))
          .thenAnswer((_) async => [leave]);
      bLoc.add(FetchMoreLeaves(currentMonthFirstDay));
      expect(
          bLoc.stream,
          emits(WhoIsOutCardState(
              selectedDate: selectedDate, focusDay: currentMonthFirstDay)));
    });

    tearDown(() {
      bLoc.close();
    });
  });

  group("fetch more leave on month change test", () {
    setUpAll(() {
      employeeService = MockEmployeeService();
      leaveService = MockLeaveService();
      bLoc = WhoIsOutCardBloc(employeeService, leaveService);
      selectedDate = bLoc.state.selectedDate;
      focusDay = bLoc.state.focusDay;
    });

    test("initial leave setup", () {
      when(employeeService.getEmployees()).thenAnswer((_) async => [employee]);
      when(leaveService.getAllAbsence(date: selectedDate))
          .thenAnswer((_) async => [leave]);
      bLoc.add(WhoIsOutInitialLoadEvent());

      expect(
          bLoc.stream,
          emitsInOrder([
            WhoIsOutCardState(
                selectedDate: selectedDate,
                focusDay: focusDay,
                status: Status.loading),
            WhoIsOutCardState(
                selectedDate: selectedDate,
                focusDay: focusDay,
                status: Status.success,
                allAbsences: [
                  LeaveApplication(employee: employee, leave: leave)
                ],
                selectedDayAbsences: [
                  LeaveApplication(employee: employee, leave: leave)
                ]),
          ]));
    });

    test("fetch more leave success on focus month change test", () {
      final nextMonthFirstDay = DateTime(focusDay.year, focusDay.month + 1);
      when(leaveService.getAllAbsence(date: nextMonthFirstDay))
          .thenAnswer((_) async => [nextMonthLeave]);
      bLoc.add(FetchMoreLeaves(nextMonthFirstDay));
      expect(
          bLoc.stream,
          emitsInOrder([
            WhoIsOutCardState(
                selectedDate: selectedDate,
                focusDay: nextMonthFirstDay,
                status: Status.success,
                allAbsences: [
                  LeaveApplication(employee: employee, leave: leave)
                ],
                selectedDayAbsences: [
                  LeaveApplication(employee: employee, leave: leave)
                ]),
            WhoIsOutCardState(
                selectedDate: selectedDate,
                focusDay: nextMonthFirstDay,
                status: Status.success,
                allAbsences: [
                  LeaveApplication(employee: employee, leave: leave),
                  LeaveApplication(employee: employee, leave: nextMonthLeave)
                ],
                selectedDayAbsences: [
                  LeaveApplication(employee: employee, leave: leave)
                ]),
          ]));
    });

    test("see other date leave test", () {
      final nextMonthFirstDay = DateTime(focusDay.year, focusDay.month + 1);
      bLoc.add(ChangeCalendarDate(nextMonthFirstDay));
      expect(
          bLoc.stream,
          emits(
            WhoIsOutCardState(
                selectedDate: nextMonthFirstDay,
                focusDay: nextMonthFirstDay,
                status: Status.success,
                allAbsences: [
                  LeaveApplication(employee: employee, leave: leave),
                  LeaveApplication(employee: employee, leave: nextMonthLeave)
                ],
                selectedDayAbsences: [
                  LeaveApplication(employee: employee, leave: nextMonthLeave)
                ]),
          ));
    });
  });
}
