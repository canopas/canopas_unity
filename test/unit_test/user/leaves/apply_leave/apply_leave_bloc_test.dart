import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/extensions/map_extension.dart';
import 'package:projectunity/data/core/functions/shared_function.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/model/space/space.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/repo/leave_repo.dart';
import 'package:projectunity/data/services/mail_notification_service.dart';
import 'package:projectunity/ui/user/leaves/apply_leave/bloc/apply_leave_bloc.dart';
import 'package:projectunity/ui/user/leaves/apply_leave/bloc/apply_leave_event.dart';
import 'package:projectunity/ui/user/leaves/apply_leave/bloc/apply_leave_state.dart';

import 'apply_leave_bloc_test.mocks.dart';

@GenerateMocks([LeaveRepo, UserStateNotifier, NotificationService])
void main() {
  late LeaveRepo leaveRepo;
  late UserStateNotifier userStateNotifier;
  late ApplyLeaveBloc leaveRequestBloc;
  late AppFunctions appFunctions;
  late NotificationService notificationService;

  final DateTime currentDate = DateTime.now().dateOnly;
  final DateTime futureDate = DateTime.now().add(const Duration(days: 5));

  final Map<DateTime, LeaveDayDuration> currentDayMap = {
    currentDate: currentDate.getLeaveDayDuration(),
  };
  final double currentDayTotalLeaveCount = {
    currentDate: currentDate.getLeaveDayDuration(),
  }.getTotalLeaveCount();

  group("Leave Request Form view test", () {
    setUp(() {
      leaveRepo = MockLeaveRepo();
      userStateNotifier = MockUserStateNotifier();
      notificationService = MockNotificationService();
      appFunctions = AppFunctions();
      leaveRequestBloc = ApplyLeaveBloc(
        userStateNotifier,
        leaveRepo,
        notificationService,
        appFunctions,
      );

      when(userStateNotifier.userUID).thenReturn("id");
      when(userStateNotifier.employeeId).thenReturn("id");
      when(leaveRepo.generateLeaveId).thenReturn("new-leave-id");
    });

    test("leave Type change test", () {
      leaveRequestBloc.add(
        ApplyLeaveChangeLeaveTypeEvent(leaveType: LeaveType.urgentLeave),
      );
      expect(
        leaveRequestBloc.stream,
        emits(
          ApplyLeaveState(
            startDate: currentDate,
            endDate: currentDate,
            totalLeaveDays: currentDayTotalLeaveCount,
            selectedDates: currentDayMap,
            leaveType: LeaveType.urgentLeave,
          ),
        ),
      );
    });

    test('on apply leave fill data error test', () async {
      leaveRequestBloc.add(ApplyLeaveSubmitFormEvent());
      expectLater(
        leaveRequestBloc.stream,
        emitsInOrder([
          ApplyLeaveState(
            leaveRequestStatus: Status.loading,
            startDate: currentDate,
            endDate: currentDate,
            totalLeaveDays: currentDayTotalLeaveCount,
            selectedDates: currentDayMap,
          ),
          ApplyLeaveState(
            leaveRequestStatus: Status.error,
            startDate: currentDate,
            endDate: currentDate,
            showTextFieldError: true,
            totalLeaveDays: currentDayTotalLeaveCount,
            selectedDates: currentDayMap,
            error: fillDetailsError,
          ),
        ]),
      );
    });

    test("change reason test and apply leave button test", () {
      leaveRequestBloc.add(ApplyLeaveReasonChangeEvent(reason: "reason"));
      expect(
        leaveRequestBloc.stream,
        emits(
          ApplyLeaveState(
            startDate: currentDate,
            endDate: currentDate,
            totalLeaveDays: currentDayTotalLeaveCount,
            selectedDates: currentDayMap,
            reason: "reason",
          ),
        ),
      );
    });

    test("date range per day selection change test", () {
      leaveRequestBloc.add(
        ApplyLeaveUpdateLeaveOfTheDayEvent(
          date: currentDate,
          value: LeaveDayDuration.secondHalfLeave,
        ),
      );
      expect(
        leaveRequestBloc.stream,
        emits(
          ApplyLeaveState(
            startDate: currentDate,
            endDate: currentDate,
            selectedDates: {currentDate: LeaveDayDuration.secondHalfLeave},
            totalLeaveDays: 0.5,
          ),
        ),
      );
    });

    test('on apply leave minimum hour error test', () {
      leaveRequestBloc.add(
        ApplyLeaveUpdateLeaveOfTheDayEvent(
          date: currentDate,
          value: LeaveDayDuration.noLeave,
        ),
      );
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
            reason: "reason",
          ),
          ApplyLeaveState(
            leaveRequestStatus: Status.loading,
            totalLeaveDays: 0,
            startDate: currentDate,
            endDate: currentDate,
            selectedDates: {currentDate: LeaveDayDuration.noLeave},
            reason: "reason",
          ),
          ApplyLeaveState(
            leaveRequestStatus: Status.error,
            totalLeaveDays: 0,
            startDate: currentDate,
            endDate: currentDate,
            selectedDates: {currentDate: LeaveDayDuration.noLeave},
            error: applyMinimumHalfDay,
            reason: "reason",
          ),
        ]),
      );
    });

    test("start Date change test", () {
      leaveRequestBloc.add(
        ApplyLeaveStartDateChangeEvents(startDate: currentDate),
      );
      expect(
        leaveRequestBloc.stream,
        emits(
          ApplyLeaveState(
            startDate: currentDate,
            endDate: currentDate,
            selectedDates: currentDayMap,
            totalLeaveDays: currentDayTotalLeaveCount,
          ),
        ),
      );
    });

    test("end Date change test", () {
      Map<DateTime, LeaveDayDuration> updatedSelectedLeaves = currentDayMap
          .getSelectedLeaveOfTheDays(
            endDate: futureDate,
            startDate: currentDate,
          );
      double totalDays = updatedSelectedLeaves.getTotalLeaveCount();

      leaveRequestBloc.add(ApplyLeaveEndDateChangeEvent(endDate: futureDate));

      expect(
        leaveRequestBloc.stream,
        emits(
          ApplyLeaveState(
            endDate: futureDate,
            startDate: currentDate,
            selectedDates: updatedSelectedLeaves,
            totalLeaveDays: totalDays,
          ),
        ),
      );
    });

    test('on apply leave invalid leave date error test', () {
      Map<DateTime, LeaveDayDuration> updatedSelectedLeaves = {
        currentDate: LeaveDayDuration.fullLeave,
      }.getSelectedLeaveOfTheDays(startDate: futureDate, endDate: currentDate);
      double totalDays = updatedSelectedLeaves.getTotalLeaveCount();
      leaveRequestBloc.add(
        ApplyLeaveStartDateChangeEvents(startDate: futureDate),
      );
      leaveRequestBloc.add(ApplyLeaveReasonChangeEvent(reason: "reason"));
      leaveRequestBloc.add(ApplyLeaveSubmitFormEvent());

      expectLater(
        leaveRequestBloc.stream,
        emitsInOrder([
          ApplyLeaveState(
            startDate: futureDate,
            endDate: currentDate,
            selectedDates: updatedSelectedLeaves,
            totalLeaveDays: totalDays,
          ),
          ApplyLeaveState(
            startDate: futureDate,
            endDate: currentDate,
            selectedDates: updatedSelectedLeaves,
            totalLeaveDays: totalDays,
            reason: "reason",
          ),
          ApplyLeaveState(
            leaveRequestStatus: Status.loading,
            totalLeaveDays: totalDays,
            startDate: futureDate,
            endDate: currentDate,
            selectedDates: updatedSelectedLeaves,
            reason: "reason",
          ),
          ApplyLeaveState(
            leaveRequestStatus: Status.error,
            totalLeaveDays: totalDays,
            startDate: futureDate,
            endDate: currentDate,
            selectedDates: updatedSelectedLeaves,
            error: applyMinimumHalfDay,
            reason: "reason",
          ),
        ]),
      );
    });

    test('on apply already leave applied error test', () async {
      when(
        leaveRepo.checkLeaveAlreadyApplied(
          uid: 'id',
          dateDuration: currentDayMap.getSelectedLeaveOfTheDays(
            startDate: currentDate,
            endDate: futureDate,
          ),
        ),
      ).thenAnswer((_) async => true);

      when(userStateNotifier.userUID).thenReturn('id');
      Map<DateTime, LeaveDayDuration> updatedSelectedLeaves = currentDayMap
          .getSelectedLeaveOfTheDays(
            endDate: futureDate,
            startDate: currentDate,
          );
      double totalDays = updatedSelectedLeaves.getTotalLeaveCount();

      final entries = updatedSelectedLeaves.entries.where(
        (day) => day.value != LeaveDayDuration.noLeave,
      );
      DateTime firstDate = entries.first.key;
      DateTime lastDate = entries.last.key;
      Map<DateTime, LeaveDayDuration> selectedDates = updatedSelectedLeaves
        ..removeWhere(
          (key, value) => key.isBefore(firstDate) || key.isAfter(lastDate),
        );

      Leave leave = Leave(
        leaveId: "1234",
        uid: "id",
        type: LeaveType.casualLeave,
        startDate: firstDate,
        endDate: lastDate,
        total: totalDays,
        reason: "reason",
        status: LeaveStatus.pending,
        appliedOn: currentDate,
        perDayDuration: selectedDates.values.toList(),
      );

      when(leaveRepo.applyForLeave(leave: leave)).thenThrow(Exception('error'));
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
            totalLeaveDays: totalDays,
          ),
          ApplyLeaveState(
            startDate: currentDate,
            endDate: futureDate,
            selectedDates: selectedDates,
            totalLeaveDays: totalDays,
            reason: "reason",
          ),
          ApplyLeaveState(
            startDate: currentDate,
            endDate: futureDate,
            selectedDates: selectedDates,
            totalLeaveDays: totalDays,
            reason: "reason",
            leaveRequestStatus: Status.loading,
          ),
          ApplyLeaveState(
            startDate: currentDate,
            endDate: futureDate,
            selectedDates: selectedDates,
            totalLeaveDays: totalDays,
            reason: "reason",
            error: alreadyLeaveAppliedError,
            leaveRequestStatus: Status.error,
          ),
        ]),
      );
    });

    test('on apply success test', () async {
      when(
        leaveRepo.checkLeaveAlreadyApplied(
          uid: 'id',
          dateDuration: currentDayMap.getSelectedLeaveOfTheDays(
            startDate: currentDate,
            endDate: futureDate,
          ),
        ),
      ).thenAnswer((_) async => false);

      Map<DateTime, LeaveDayDuration> updatedSelectedLeaves = currentDayMap
          .getSelectedLeaveOfTheDays(
            endDate: futureDate,
            startDate: currentDate,
          );
      double totalDays = updatedSelectedLeaves.getTotalLeaveCount();

      final entries = updatedSelectedLeaves.entries.where(
        (day) => day.value != LeaveDayDuration.noLeave,
      );
      DateTime firstDate = entries.first.key;
      DateTime lastDate = entries.last.key;
      Map<DateTime, LeaveDayDuration> selectedDates = updatedSelectedLeaves
        ..removeWhere(
          (key, value) => key.isBefore(firstDate) || key.isAfter(lastDate),
        );

      Employee employee = Employee(
        uid: 'uid',
        name: 'dummy',
        email: 'dummy@canopas.com',
        role: Role.employee,
        dateOfJoining: DateTime(2002),
      );

      Leave leave = Leave(
        leaveId: "1234",
        uid: "id",
        type: LeaveType.casualLeave,
        startDate: firstDate,
        endDate: lastDate,
        total: totalDays,
        reason: "reason",
        status: LeaveStatus.pending,
        appliedOn: currentDate,
        perDayDuration: selectedDates.values.toList(),
      );

      final space = Space(
        id: 'space-id',
        name: 'name',
        createdAt: DateTime.now(),
        paidTimeOff: 12,
        ownerIds: const ["uid"],
        notificationEmail: "hr@canopas.com",
      );

      when(leaveRepo.generateLeaveId).thenReturn(leave.leaveId);
      when(userStateNotifier.employee).thenReturn(employee);
      when(userStateNotifier.currentSpace).thenReturn(space);
      when(
        notificationService.notifyHRForNewLeave(
          reason: 'reason',
          receiver: 'hr@canopas.com',
          name: "dummy",
          startDate: leave.startDate,
          duration: appFunctions.getNotificationDuration(
            total: leave.total,
            firstLeaveDayDuration: leave.perDayDuration.first,
          ),
          endDate: leave.endDate,
        ),
      ).thenAnswer((realInvocation) async => true);
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
            totalLeaveDays: totalDays,
          ),
          ApplyLeaveState(
            startDate: currentDate,
            endDate: futureDate,
            selectedDates: selectedDates,
            totalLeaveDays: totalDays,
            reason: "reason",
          ),
          ApplyLeaveState(
            startDate: currentDate,
            endDate: futureDate,
            selectedDates: selectedDates,
            totalLeaveDays: totalDays,
            reason: "reason",
            leaveRequestStatus: Status.loading,
          ),
          ApplyLeaveState(
            startDate: currentDate,
            endDate: futureDate,
            selectedDates: selectedDates,
            totalLeaveDays: totalDays,
            reason: "reason",
            leaveId: leave.leaveId,
            leaveRequestStatus: Status.success,
          ),
        ]),
      );
    });

    tearDownAll(() {
      leaveRequestBloc.close();
    });
  });
}
