import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_bloc.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_event.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_state.dart';

import 'user_leave_bloc_test.mocks.dart';

@GenerateMocks([LeaveService, UserStateNotifier])
void main() {
  late LeaveService leaveService;
  late UserStateNotifier userStateNotifier;
  late UserLeaveBloc userLeaveBloc;

  DateTime today = DateTime.now();

  Leave upcomingLeave = Leave(
      leaveId: 'leave-id-1',
      uid: "user-id",
      type: LeaveType.sickLeave,
      startDate: today.add(const Duration(days: 1)),
      endDate: today.add(const Duration(days: 2)),
      total: 2,
      reason: 'reason',
      status: LeaveStatus.approved,
      appliedOn: today,
      perDayDuration: const [
        LeaveDayDuration.fullLeave,
        LeaveDayDuration.fullLeave
      ]);

  Leave pastLeave = Leave(
      leaveId: 'Leave-id-2',
      uid: "user-id",
      type: LeaveType.sickLeave,
      startDate: today.subtract(const Duration(days: 2)),
      endDate: today.subtract(const Duration(days: 1)),
      total: 1,
      reason: 'reason',
      status: LeaveStatus.approved,
      appliedOn: today,
      perDayDuration: const [LeaveDayDuration.fullLeave]);

  Leave specificYearLeave = Leave(
      leaveId: 'leave-id-3',
      uid: "user-id",
      type: LeaveType.sickLeave,
      startDate: DateTime(2022),
      endDate: DateTime(2022),
      total: 1,
      reason: 'reason',
      status: LeaveStatus.approved,
      appliedOn: today,
      perDayDuration: const [LeaveDayDuration.fullLeave]);

  setUp(() {
    leaveService = MockLeaveService();
    userStateNotifier = MockUserStateNotifier();
    when(userStateNotifier.employeeId).thenReturn('user-id');
  });

  tearDown(() async {
    await userLeaveBloc.close();
  });

  group('User leave test', () {
    test('User leave test listen real-time data and emit success state test',
        () async {
      when(leaveService.leaveDBSnapshotOfUser('user-id')).thenAnswer(
          (realInvocation) =>
              Stream.value([upcomingLeave, pastLeave, specificYearLeave]));
      userLeaveBloc = UserLeaveBloc(userStateNotifier, leaveService);
      expect(
        userLeaveBloc.state,
        UserLeaveState(
            selectedYear: DateTime.now().year, status: Status.loading),
      );
      expectLater(
        userLeaveBloc.stream,
        emits(UserLeaveState(
            selectedYear: DateTime.now().year,
            status: Status.success,
            leaves: [upcomingLeave, pastLeave])),
      );
      await untilCalled(leaveService.leaveDBSnapshotOfUser('user-id'));
      verify(leaveService.leaveDBSnapshotOfUser('user-id')).called(1);
    });

    test('User leave test listen real-time data and emit error test', () async {
      when(leaveService.leaveDBSnapshotOfUser('user-id')).thenAnswer(
          (realInvocation) => Stream.error(firestoreFetchDataError));

      userLeaveBloc = UserLeaveBloc(userStateNotifier, leaveService);

      expect(
        userLeaveBloc.state,
        UserLeaveState(
            selectedYear: DateTime.now().year, status: Status.loading),
      );
      expectLater(
        userLeaveBloc.stream,
        emits(UserLeaveState(
            selectedYear: DateTime.now().year,
            status: Status.error,
            error: firestoreFetchDataError)),
      );

      await untilCalled(leaveService.leaveDBSnapshotOfUser('user-id'));
      verify(leaveService.leaveDBSnapshotOfUser('user-id')).called(1);
    });

    test('change year and show year wise leave test', () async {
      when(leaveService.leaveDBSnapshotOfUser('user-id')).thenAnswer(
          (realInvocation) =>
              Stream.value([upcomingLeave, pastLeave, specificYearLeave]));
      userLeaveBloc = UserLeaveBloc(userStateNotifier, leaveService);
      expect(
        userLeaveBloc.state,
        UserLeaveState(
            selectedYear: DateTime.now().year, status: Status.loading),
      );

      await untilCalled(leaveService.leaveDBSnapshotOfUser('user-id'));
      verify(leaveService.leaveDBSnapshotOfUser('user-id')).called(1);

      userLeaveBloc.add(ChangeYearEvent(year: 2022));
      expectLater(
        userLeaveBloc.stream,
        emitsInOrder([
          UserLeaveState(
              selectedYear: DateTime.now().year,
              status: Status.success,
              leaves: [upcomingLeave, pastLeave]),
          UserLeaveState(
              status: Status.success,
              leaves: [specificYearLeave],
              selectedYear: 2022),
        ]),
      );
    });
  });
}
