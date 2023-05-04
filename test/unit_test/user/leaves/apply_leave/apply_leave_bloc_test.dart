import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/extensions/map_extension.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:projectunity/ui/user/leaves/apply_leave/bloc/apply_leave_bloc.dart';
import 'package:projectunity/ui/user/leaves/apply_leave/bloc/apply_leave_event.dart';
import 'package:projectunity/ui/user/leaves/apply_leave/bloc/apply_leave_state.dart';

import 'apply_leave_bloc_test.mocks.dart';

@GenerateMocks([ LeaveService, UserManager])
void main() {
  late LeaveService leaveService;
  late UserManager userManager;
  late ApplyLeaveBloc leaveRequestBloc;

  DateTime currentDate = DateTime.now().dateOnly;
  DateTime futureDate = DateTime.now()
      .add(Duration(
          days: currentDate.add(const Duration(days: 5)).isWeekend ? 7 : 5))
      .dateOnly;

  group("Leave Request Form view test", () {
    setUp(() {
      leaveService = MockLeaveService();
      userManager = MockUserManager();
      leaveRequestBloc = ApplyLeaveBloc(userManager, leaveService);

      when(userManager.userUID).thenReturn("id");
      when(userManager.employeeId).thenReturn("id");
      when(leaveService.getNewLeaveId()).thenReturn("new-leave-id");
      when(leaveService.checkLeaveAlreadyApplied(
          userId: 'id',
          dateDuration: {DateTime(2000): LeaveDayDuration.firstHalfLeave})).thenAnswer((_) async => true);
    });

    test("leave Type change test", () {
      leaveRequestBloc.add(ApplyLeaveChangeLeaveTypeEvent(leaveType: 1));
      expect(
          leaveRequestBloc.stream,
          emits(ApplyLeaveState(
              startDate: currentDate,
              endDate: currentDate,
              selectedDates: {currentDate: LeaveDayDuration.fullLeave},
              leaveType: 1)));
    });

    test('on apply leave fill data error test', () async {
      when(userManager.userUID).thenReturn("id");
      when(userManager.employeeId).thenReturn("id");

      leaveRequestBloc.add(ApplyLeaveSubmitFormEvent());
      expectLater(
          leaveRequestBloc.stream,
          emitsInOrder([
            ApplyLeaveState(
                leaveRequestStatus: Status.loading,
                startDate: currentDate,
                endDate: currentDate,
                selectedDates: {currentDate: LeaveDayDuration.fullLeave}),
            ApplyLeaveState(
                leaveRequestStatus: Status.error,
                startDate: currentDate,
                endDate: currentDate,
                showTextFieldError: true,
                selectedDates: {currentDate: LeaveDayDuration.fullLeave},
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
                selectedDates: {currentDate: LeaveDayDuration.fullLeave},
                reason: "reason"),
          ));
    });

    test("date range per day selection change test", () {
      leaveRequestBloc
          .add(ApplyLeaveUpdateLeaveOfTheDayEvent(date: currentDate, value: LeaveDayDuration.noLeave));
      expect(
          leaveRequestBloc.stream,
          emits(
            ApplyLeaveState(
                startDate: currentDate,
                endDate: currentDate,
                selectedDates: {currentDate: LeaveDayDuration.noLeave},
                totalLeaveDays: 0),
          ));
    });

    test('on apply leave minimum hour error test', () {
      leaveRequestBloc
          .add(ApplyLeaveUpdateLeaveOfTheDayEvent(date: currentDate, value: LeaveDayDuration.noLeave));
      leaveRequestBloc.add(ApplyLeaveReasonChangeEvent(reason: "reason"));
      leaveRequestBloc.add(ApplyLeaveSubmitFormEvent());
      expect(
          leaveRequestBloc.stream,
          emitsInOrder([
            ApplyLeaveState(
              startDate: currentDate,
              endDate: currentDate,
              selectedDates: {currentDate: LeaveDayDuration.noLeave},
              totalLeaveDays: 0,
            ),
            ApplyLeaveState(
                startDate: currentDate,
                endDate: currentDate,
                selectedDates: {currentDate: LeaveDayDuration.noLeave},
                totalLeaveDays: 0,
                reason: "reason"),
            ApplyLeaveState(
                leaveRequestStatus: Status.loading,
                totalLeaveDays: 0,
                startDate: currentDate,
                endDate: currentDate,
                selectedDates: {currentDate: LeaveDayDuration.noLeave},
                reason: "reason"),
            ApplyLeaveState(
                leaveRequestStatus: Status.error,
                totalLeaveDays: 0,
                startDate: currentDate,
                endDate: currentDate,
                selectedDates: {currentDate: LeaveDayDuration.noLeave},
                error: applyMinimumHalfDay,
                reason: "reason"),
          ]));
    });

    test("start Date change test", () {
      Map<DateTime, LeaveDayDuration> updatedSelectedLeaves = {
        currentDate: LeaveDayDuration.fullLeave
      }.getSelectedLeaveOfTheDays(startDate: currentDate, endDate: currentDate);
      double totalDays = updatedSelectedLeaves.getTotalLeaveCount();

      leaveRequestBloc
          .add(ApplyLeaveStartDateChangeEvents(startDate: currentDate));

      expect(
          leaveRequestBloc.stream,
          emits(ApplyLeaveState(
              startDate: currentDate,
              endDate: currentDate,
              selectedDates: updatedSelectedLeaves,
              totalLeaveDays: totalDays)));
    });

    test("end Date change test", () {
      Map<DateTime, LeaveDayDuration> updatedSelectedLeaves = {
        currentDate: LeaveDayDuration.fullLeave
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
      Map<DateTime, LeaveDayDuration> updatedSelectedLeaves = {
        currentDate: LeaveDayDuration.fullLeave
      }.getSelectedLeaveOfTheDays(startDate: futureDate, endDate: currentDate);
      double totalDays = updatedSelectedLeaves.getTotalLeaveCount();
      leaveRequestBloc
          .add(ApplyLeaveStartDateChangeEvents(startDate: futureDate));
      leaveRequestBloc.add(ApplyLeaveReasonChangeEvent(reason: "reason"));
      leaveRequestBloc.add(ApplyLeaveSubmitFormEvent());

      expectLater(
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
                leaveRequestStatus: Status.loading,
                totalLeaveDays: totalDays,
                startDate: futureDate,
                endDate: currentDate,
                selectedDates: updatedSelectedLeaves,
                reason: "reason"),
            ApplyLeaveState(
                leaveRequestStatus: Status.error,
                totalLeaveDays: totalDays,
                startDate: futureDate,
                endDate: currentDate,
                selectedDates: updatedSelectedLeaves,
                error: applyMinimumHalfDay,
                reason: "reason"),
          ]));
    });

    test('on apply already leave applied error test', () async {
      when(leaveService.checkLeaveAlreadyApplied(
              userId: 'id', dateDuration: leaveRequestBloc.state.selectedDates))
          .thenAnswer((_) async => true);
      when(userManager.userUID).thenReturn('id');
      Map<DateTime, LeaveDayDuration> updatedSelectedLeaves = {
        currentDate: LeaveDayDuration.fullLeave
      }.getSelectedLeaveOfTheDays(endDate: futureDate, startDate: currentDate);
      double totalDays = updatedSelectedLeaves.getTotalLeaveCount();

      final entries =
          updatedSelectedLeaves.entries.where((day) => day.value != LeaveDayDuration.noLeave);
      DateTime firstDate = entries.first.key;
      DateTime lastDate = entries.last.key;
      Map<DateTime, LeaveDayDuration> selectedDates = updatedSelectedLeaves
        ..removeWhere(
            (key, value) => key.isBefore(firstDate) || key.isAfter(lastDate));

      Leave leave = Leave(
        leaveId: "1234",
        uid: "id",
        type: 0,
        startDate: firstDate.timeStampToInt,
        endDate: lastDate.timeStampToInt,
        total: totalDays,
        reason: "reason",
        status: pendingLeaveStatus,
        appliedOn: currentDate.timeStampToInt,
        perDayDuration: selectedDates.values.toList(),
      );

      when(leaveService.applyForLeave(leave)).thenAnswer((_) async {});
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
                leaveRequestStatus: Status.loading),
            ApplyLeaveState(
                startDate: currentDate,
                endDate: futureDate,
                selectedDates: selectedDates,
                totalLeaveDays: totalDays,
                reason: "reason",
                error: alreadyLeaveAppliedError,
                leaveRequestStatus: Status.error),
          ]));
    });

    test('on apply success test', () async {
      when(leaveService.checkLeaveAlreadyApplied(
              userId: 'id', dateDuration: leaveRequestBloc.state.selectedDates))
          .thenAnswer((_) async => false);
      when(userManager.userUID).thenReturn('id');

      Map<DateTime, LeaveDayDuration> updatedSelectedLeaves = {
        currentDate: LeaveDayDuration.fullLeave
      }.getSelectedLeaveOfTheDays(endDate: futureDate, startDate: currentDate);
      double totalDays = updatedSelectedLeaves.getTotalLeaveCount();

      final entries =
          updatedSelectedLeaves.entries.where((day) => day.value != LeaveDayDuration.noLeave);
      DateTime firstDate = entries.first.key;
      DateTime lastDate = entries.last.key;
      Map<DateTime, LeaveDayDuration> selectedDates = updatedSelectedLeaves
        ..removeWhere(
            (key, value) => key.isBefore(firstDate) || key.isAfter(lastDate));

      Leave leave = Leave(
        leaveId: "1234",
        uid: "id",
        type: 0,
        startDate: firstDate.timeStampToInt,
        endDate: lastDate.timeStampToInt,
        total: totalDays,
        reason: "reason",
        status: pendingLeaveStatus,
        appliedOn: currentDate.timeStampToInt,
        perDayDuration: selectedDates.values.toList(),
      );

      when(leaveService.applyForLeave(leave)).thenAnswer((_) async {});
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
                leaveRequestStatus: Status.loading),
            ApplyLeaveState(
                startDate: currentDate,
                endDate: futureDate,
                selectedDates: selectedDates,
                totalLeaveDays: totalDays,
                reason: "reason",
                leaveRequestStatus: Status.success),
          ]));
    });

    tearDownAll(() {
      leaveRequestBloc.close();
    });
  });
}
