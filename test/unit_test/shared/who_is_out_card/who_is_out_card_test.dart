import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/repo/employee_repo.dart';
import 'package:projectunity/data/repo/leave_repo.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/model/leave_application.dart';
import 'package:projectunity/ui/shared/who_is_out_card/bloc/who_is_out_card_bloc.dart';
import 'package:projectunity/ui/shared/who_is_out_card/bloc/who_is_out_card_event.dart';
import 'package:projectunity/ui/shared/who_is_out_card/bloc/who_is_out_card_state.dart';
import 'package:table_calendar/table_calendar.dart';

import 'who_is_out_card_test.mocks.dart';

@GenerateMocks([
  LeaveRepo,
  EmployeeRepo,
])
void main() {
  late WhoIsOutCardBloc bLoc;
  late EmployeeRepo employeeRepo;
  late LeaveRepo leaveRepo;

  final employee = Employee(
    uid: "uid",
    role: Role.employee,
    name: "tester",
    employeeId: "103",
    email: "tester@canopas.com",
    designation: "tester",
    dateOfJoining: DateTime(2000),
  );

  late DateTime selectedDate;
  late DateTime focusDay;

  Leave leave = Leave(
      leaveId: "leave-id",
      uid: "uid",
      type: LeaveType.urgentLeave,
      startDate: DateTime.now().dateOnly,
      endDate: DateTime.now().dateOnly,
      total: 1,
      reason: "test",
      status: LeaveStatus.approved,
      appliedOn: DateTime.now().dateOnly,
      perDayDuration: const [LeaveDayDuration.fullLeave]);

  group('user home test', () {
    setUp(() {
      employeeRepo = MockEmployeeRepo();
      leaveRepo = MockLeaveRepo();
      bLoc = WhoIsOutCardBloc(employeeRepo, leaveRepo);
      selectedDate = bLoc.state.selectedDate;
      focusDay = bLoc.state.focusDay;
    });

    test("Fetch initial month leaves success state test", () {
      when(employeeRepo.employees).thenAnswer((_) => Stream.value([employee]));
      when(leaveRepo.leaveByMonth(focusDay))
          .thenAnswer((_) => Stream.value([leave]));
      bLoc.add(FetchWhoIsOutCardLeaves());

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

    test("Fetch initial month leaves failure state if exception thrown", () {
      when(employeeRepo.employees).thenAnswer((_) => Stream.value([employee]));
      when(leaveRepo.leaveByMonth(selectedDate)).thenThrow(Exception("error"));
      bLoc.add(FetchWhoIsOutCardLeaves());

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

    test("Fetch initial month leaves failure state if stream has error test",
        () {
      when(employeeRepo.employees).thenAnswer((_) => Stream.value([employee]));
      when(leaveRepo.leaveByMonth(selectedDate))
          .thenAnswer((_) => Stream.error(firestoreFetchDataError));
      bLoc.add(FetchWhoIsOutCardLeaves());

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

    test("Fetch more leave on month change test success state", () {
      when(employeeRepo.employees).thenAnswer((_) => Stream.value([employee]));
      when(leaveRepo.leaveByMonth(DateTime(focusDay.year, focusDay.month + 1)))
          .thenAnswer((_) => Stream.value([leave]));
      bLoc.add(FetchWhoIsOutCardLeaves(
          focusDay: DateTime(focusDay.year, focusDay.month + 1)));
      expect(
          bLoc.stream,
          emitsInOrder([
            WhoIsOutCardState(
                selectedDate: selectedDate,
                focusDay: DateTime(focusDay.year, focusDay.month + 1),
                status: Status.loading),
            WhoIsOutCardState(
              status: Status.success,
              selectedDate: selectedDate,
              focusDay: DateTime(focusDay.year, focusDay.month + 1),
              allAbsences: [LeaveApplication(employee: employee, leave: leave)],
              selectedDayAbsences: [
                LeaveApplication(employee: employee, leave: leave)
              ],
            ),
          ]));
    });

    test(
        'Fetch more leave on month change test failure state if exception thrown',
        () {
      when(employeeRepo.employees).thenAnswer((_) => Stream.value([employee]));
      when(leaveRepo.leaveByMonth(DateTime(focusDay.year, focusDay.month + 1)))
          .thenAnswer((_) => Stream.error(firestoreFetchDataError));
      bLoc.add(FetchWhoIsOutCardLeaves(
          focusDay: DateTime(focusDay.year, focusDay.month + 1)));
      expect(
          bLoc.stream,
          emitsInOrder([
            WhoIsOutCardState(
                selectedDate: selectedDate,
                focusDay: DateTime(focusDay.year, focusDay.month + 1),
                status: Status.loading),
            WhoIsOutCardState(
                selectedDate: selectedDate,
                focusDay: DateTime(focusDay.year, focusDay.month + 1),
                error: firestoreFetchDataError,
                status: Status.error),
          ]));
    });

    test(
        'Fetch more leave on month change test failure state if stream emit error',
        () {
      when(employeeRepo.employees).thenAnswer((_) => Stream.value([employee]));
      when(leaveRepo.leaveByMonth(DateTime(focusDay.year, focusDay.month + 1)))
          .thenAnswer((_) => Stream.error(firestoreFetchDataError));
      bLoc.add(FetchWhoIsOutCardLeaves(
          focusDay: DateTime(focusDay.year, focusDay.month + 1)));
      expect(
          bLoc.stream,
          emitsInOrder([
            WhoIsOutCardState(
                selectedDate: selectedDate,
                focusDay: DateTime(focusDay.year, focusDay.month + 1),
                status: Status.loading),
            WhoIsOutCardState(
                selectedDate: selectedDate,
                focusDay: DateTime(focusDay.year, focusDay.month + 1),
                error: firestoreFetchDataError,
                status: Status.error),
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

    tearDown(() {
      bLoc.close();
    });
  });
}
