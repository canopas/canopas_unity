import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/extensions/map_extension.dart';
import 'package:projectunity/core/utils/const/leave_time_constants.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave_count.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/admin/paid_leave_service.dart';
import 'package:projectunity/services/user/user_leave_service.dart';
import 'package:projectunity/ui/user/leaves/apply_leave/bloc/apply_leave_bloc.dart';
import 'package:projectunity/ui/user/leaves/apply_leave/bloc/apply_leave_event.dart';
import 'package:projectunity/ui/user/leaves/apply_leave/bloc/apply_leave_state.dart';

import 'apply_leave_bloc_test.mocks.dart';

@GenerateMocks([PaidLeaveService, UserLeaveService, UserManager])
void main() {
  late PaidLeaveService paidLeaveService;
  late UserLeaveService userLeaveService;
  late UserManager userManager;
  late ApplyLeaveBloc leaveRequestBloc;

  LeaveCounts leaveCount = const LeaveCounts(
      remainingLeaveCount: 6.0, usedLeaveCount: 6.0, paidLeaveCount: 12);
  DateTime currentDate = DateTime.now().dateOnly;
  DateTime futureDate = DateTime.now()
      .add(Duration(
          days: currentDate.add(const Duration(days: 5)).isWeekend ? 7 : 5))
      .dateOnly;

  group("Leave Request Form view test", () {
    setUp(() {
      paidLeaveService = MockPaidLeaveService();
      userLeaveService = MockUserLeaveService();
      userManager = MockUserManager();
      leaveRequestBloc =
          ApplyLeaveBloc(userManager, paidLeaveService, userLeaveService);

      when(userManager.employeeId).thenReturn("id");
    });

    test("fetch user leave count test", () {
      when(userLeaveService.getUserUsedLeaveCount('id'))
          .thenAnswer((_) => Future(() => leaveCount.usedLeaveCount));
      when(paidLeaveService.getPaidLeaves())
          .thenAnswer((_) => Future(() => leaveCount.paidLeaveCount));
      leaveRequestBloc.add(ApplyLeaveInitialEvent());
      expect(
          leaveRequestBloc.stream,
          emitsInOrder([
            ApplyLeaveState(
                leaveCountStatus: LeaveCountStatus.loading,
                startDate: currentDate,
                endDate: currentDate,
                selectedDates: {currentDate: 3}),
            ApplyLeaveState(
                leaveCountStatus: LeaveCountStatus.success,
                startDate: currentDate,
                endDate: currentDate,
                selectedDates: {currentDate: 3},
                leaveCounts: leaveCount),
          ]));
    });

    test("fetch user leave count failed test", () {
      when(userLeaveService.getUserUsedLeaveCount('id'))
          .thenThrow(Exception("Error"));
      when(paidLeaveService.getPaidLeaves()).thenThrow(Exception("Error"));
      leaveRequestBloc.add(ApplyLeaveInitialEvent());
      expect(
          leaveRequestBloc.stream,
          emitsInOrder([
            ApplyLeaveState(
                leaveCountStatus: LeaveCountStatus.loading,
                startDate: currentDate,
                endDate: currentDate,
                selectedDates: {currentDate: 3}),
            ApplyLeaveState(
                leaveCountStatus: LeaveCountStatus.failure,
                startDate: currentDate,
                endDate: currentDate,
                selectedDates: {currentDate: 3},
                error: firestoreFetchDataError),
          ]));
    });

    test("leave Type change test", () {
      leaveRequestBloc.add(ApplyLeaveChangeLeaveTypeEvent(leaveType: 1));
      expect(
          leaveRequestBloc.stream,
          emits(ApplyLeaveState(
              startDate: currentDate,
              endDate: currentDate,
              selectedDates: {currentDate: 3},
              leaveType: 1)));
    });

    test('on apply leave fill data error test', () {
      leaveRequestBloc.add(ApplyLeaveSubmitFormEvent());
      expect(
          leaveRequestBloc.stream,
          emitsInOrder([
            ApplyLeaveState(
                leaveRequestStatus: ApplyLeaveStatus.loading,
                startDate: currentDate,
                endDate: currentDate,
                selectedDates: {currentDate: 3}),
            ApplyLeaveState(
                leaveRequestStatus: ApplyLeaveStatus.failure,
                startDate: currentDate,
                endDate: currentDate,
                selectedDates: {currentDate: 3},
                showTextFieldError: true,
                error: fillDetailsError),
          ]));
    });

    test("change reason test and apply leave button test", () {
      leaveRequestBloc.add(ApplyLeaveReasonChangeEvent(reason: "reason"));
      expect(
          leaveRequestBloc.stream,
          emits(
            ApplyLeaveState(
                startDate: currentDate,
                endDate: currentDate,
                selectedDates: {currentDate: 3},
                reason: "reason"),
          ));
    });

    test("date range per day selection change test", () {
      leaveRequestBloc
          .add(ApplyLeaveUpdateLeaveOfTheDayEvent(date: currentDate, value: 0));
      expect(
          leaveRequestBloc.stream,
          emits(
            ApplyLeaveState(
                startDate: currentDate,
                endDate: currentDate,
                selectedDates: {currentDate: 0},
                totalLeaveDays: 0),
          ));
    });

    test('on apply leave minimum hour error test', () {
      leaveRequestBloc
          .add(ApplyLeaveUpdateLeaveOfTheDayEvent(date: currentDate, value: 0));
      leaveRequestBloc.add(ApplyLeaveReasonChangeEvent(reason: "reason"));
      leaveRequestBloc.add(ApplyLeaveSubmitFormEvent());
      expect(
          leaveRequestBloc.stream,
          emitsInOrder([
            ApplyLeaveState(
              startDate: currentDate,
              endDate: currentDate,
              selectedDates: {currentDate: 0},
              totalLeaveDays: 0,
            ),
            ApplyLeaveState(
                startDate: currentDate,
                endDate: currentDate,
                selectedDates: {currentDate: 0},
                totalLeaveDays: 0,
                reason: "reason"),
            ApplyLeaveState(
                leaveRequestStatus: ApplyLeaveStatus.loading,
                totalLeaveDays: 0,
                startDate: currentDate,
                endDate: currentDate,
                selectedDates: {currentDate: 0},
                reason: "reason"),
            ApplyLeaveState(
                leaveRequestStatus: ApplyLeaveStatus.failure,
                totalLeaveDays: 0,
                startDate: currentDate,
                endDate: currentDate,
                selectedDates: {currentDate: 0},
                error: applyMinimumHalfDay,
                reason: "reason"),
          ]));
    });

    test("start Date change test", () {
      Map<DateTime, int> updatedSelectedLeaves = {
        currentDate: 3
      }.getSelectedLeaveOfTheDays(startDate: futureDate, endDate: currentDate);
      double totalDays = updatedSelectedLeaves.getTotalLeaveCount();

      leaveRequestBloc
          .add(ApplyLeaveStartDateChangeEvents(startDate: futureDate));

      expect(
          leaveRequestBloc.stream,
          emits(ApplyLeaveState(
              startDate: futureDate,
              endDate: currentDate,
              selectedDates: updatedSelectedLeaves,
              totalLeaveDays: totalDays)));
    });

    test("end Date change test", () {
      Map<DateTime, int> updatedSelectedLeaves = {
        currentDate: 3
      }.getSelectedLeaveOfTheDays(endDate: futureDate, startDate: currentDate);
      double totalDays = updatedSelectedLeaves.getTotalLeaveCount();

      leaveRequestBloc.add(ApplyLeaveEndDateChangeEvent(endDate: futureDate));

      expect(
          leaveRequestBloc.stream,
          emits(ApplyLeaveState(
              endDate: futureDate,
              startDate: currentDate,
              selectedDates: updatedSelectedLeaves,
              totalLeaveDays: totalDays)));
    });

    test('on apply leave invalid leave date error test', () {
      Map<DateTime, int> updatedSelectedLeaves = {
        currentDate: 3
      }.getSelectedLeaveOfTheDays(startDate: futureDate, endDate: currentDate);
      double totalDays = updatedSelectedLeaves.getTotalLeaveCount();
      leaveRequestBloc
          .add(ApplyLeaveStartDateChangeEvents(startDate: futureDate));
      leaveRequestBloc.add(ApplyLeaveReasonChangeEvent(reason: "reason"));
      leaveRequestBloc.add(ApplyLeaveSubmitFormEvent());

      expect(
          leaveRequestBloc.stream,
          emitsInOrder([
            ApplyLeaveState(
                startDate: futureDate,
                endDate: currentDate,
                selectedDates: updatedSelectedLeaves,
                totalLeaveDays: totalDays),
            ApplyLeaveState(
                startDate: futureDate,
                endDate: currentDate,
                selectedDates: updatedSelectedLeaves,
                totalLeaveDays: totalDays,
                reason: "reason"),
            ApplyLeaveState(
                leaveRequestStatus: ApplyLeaveStatus.loading,
                totalLeaveDays: totalDays,
                startDate: futureDate,
                endDate: currentDate,
                selectedDates: updatedSelectedLeaves,
                reason: "reason"),
            ApplyLeaveState(
                leaveRequestStatus: ApplyLeaveStatus.failure,
                totalLeaveDays: totalDays,
                startDate: futureDate,
                endDate: currentDate,
                selectedDates: updatedSelectedLeaves,
                error: invalidLeaveDateError,
                reason: "reason"),
          ]));
    });

    test('on apply success test', () async {
      Map<DateTime, int> updatedSelectedLeaves = {
        currentDate: 3
      }.getSelectedLeaveOfTheDays(endDate: futureDate, startDate: currentDate);
      double totalDays = updatedSelectedLeaves.getTotalLeaveCount();

      final entries =
          updatedSelectedLeaves.entries.where((day) => day.value != noLeave);
      DateTime firstDate = entries.first.key;
      DateTime lastDate = entries.last.key;
      Map<DateTime, int> selectedDates = updatedSelectedLeaves
        ..removeWhere(
            (key, value) => key.isBefore(firstDate) || key.isAfter(lastDate));

      Leave leave = Leave(
        leaveId: "1234",
        uid: "id",
        leaveType: 0,
        startDate: firstDate.timeStampToInt,
        endDate: lastDate.timeStampToInt,
        totalLeaves: totalDays,
        reason: "reason",
        leaveStatus: pendingLeaveStatus,
        appliedOn: currentDate.timeStampToInt,
        perDayDuration: selectedDates.values.toList(),
      );

      when(userLeaveService.applyForLeave(leave)).thenAnswer((_) async {});
      leaveRequestBloc.add(ApplyLeaveEndDateChangeEvent(endDate: futureDate));
      leaveRequestBloc.add(ApplyLeaveReasonChangeEvent(reason: "reason"));
      leaveRequestBloc.add(ApplyLeaveSubmitFormEvent());

      expect(
          leaveRequestBloc.stream,
          emitsInOrder([
            ApplyLeaveState(
                startDate: currentDate,
                endDate: futureDate,
                selectedDates: selectedDates,
                totalLeaveDays: totalDays),
            ApplyLeaveState(
                startDate: currentDate,
                endDate: futureDate,
                selectedDates: selectedDates,
                totalLeaveDays: totalDays,
                reason: "reason"),
            ApplyLeaveState(
                startDate: currentDate,
                endDate: futureDate,
                selectedDates: selectedDates,
                totalLeaveDays: totalDays,
                reason: "reason",
                leaveRequestStatus: ApplyLeaveStatus.loading),
            ApplyLeaveState(
                startDate: currentDate,
                endDate: futureDate,
                selectedDates: selectedDates,
                totalLeaveDays: totalDays,
                reason: "reason",
                leaveRequestStatus: ApplyLeaveStatus.success),
          ]));
    });

    tearDownAll(() {
      leaveRequestBloc.close();
    });
  });
}
