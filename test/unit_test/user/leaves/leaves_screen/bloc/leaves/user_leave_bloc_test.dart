import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/Repo/leave_repo.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_bloc.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_event.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_state.dart';

import 'user_leave_bloc_test.mocks.dart';

@GenerateMocks([LeaveRepo, UserStateNotifier])
void main() {
  late LeaveRepo leaveRepo;
  late UserStateNotifier userStateNotifier;
  late UserLeaveBloc bloc;

  const String employeeId = 'CA 1044';
  DateTime today = DateTime.now().dateOnly;

  Leave upcomingLeave = Leave(
      leaveId: 'Leave Id',
      uid: "user id",
      type: LeaveType.sickLeave,
      startDate: today.add(const Duration(days: 1)),
      endDate: today.add(const Duration(days: 2)),
      total: 2,
      reason: 'Suffering from viral fever',
      status: LeaveStatus.approved,
      appliedOn: today,
      perDayDuration: const [
        LeaveDayDuration.firstHalfLeave,
        LeaveDayDuration.firstHalfLeave
      ]);

  Leave pastLeave = Leave(
      leaveId: 'Leave-Id',
      uid: "user id",
      type: LeaveType.sickLeave,
      startDate: today.subtract(const Duration(days: 2)),
      endDate: today.subtract(const Duration(days: 1)),
      total: 1,
      reason: 'Suffering from viral fever',
      status: LeaveStatus.approved,
      appliedOn: today,
      perDayDuration: const [LeaveDayDuration.firstHalfLeave]);

  Leave specificYearLeave = Leave(
      leaveId: 'Leave-Id',
      uid: "user id",
      type: LeaveType.sickLeave,
      startDate: DateTime(2022),
      endDate: DateTime(2022),
      total: 1,
      reason: 'Suffering from viral fever',
      status: LeaveStatus.approved,
      appliedOn: today,
      perDayDuration: const [LeaveDayDuration.firstHalfLeave]);

  setUp(() {
    leaveRepo = MockLeaveRepo();
    userStateNotifier = MockUserStateNotifier();
    bloc = UserLeaveBloc(userStateNotifier, leaveRepo);
  });

  tearDown(() async {
    await bloc.close();
  });

  group('UserLeaveBloc stream test', () {
    test('Emits loading state as initial state of UserLeavesBloc', () {
      expect(
          bloc.state,
          UserLeaveState(
              selectedYear: DateTime.now().year,
              leaves: const [],
              error: null,
              status: Status.initial));
    });

    test(
        'Emits loading state and success with sorted leave and show current year leave after add UserLeaveEvent respectively',
        () {
      bloc.add(FetchUserLeaveEvent());
      when(userStateNotifier.employeeId).thenReturn(employeeId);
      when(leaveRepo.userLeaves(employeeId)).thenAnswer(
          (_) => Stream.value([pastLeave, upcomingLeave, specificYearLeave]));
      expectLater(
          bloc.stream,
          emitsInOrder([
            UserLeaveState(status: Status.loading),
            UserLeaveState(
                status: Status.success, leaves: [upcomingLeave, pastLeave]),
          ]));
    });

    test('Emits error state when Exception is thrown', () {
      bloc.add(FetchUserLeaveEvent());

      when(userStateNotifier.employeeId).thenReturn(employeeId);
      when(leaveRepo.userLeaves(employeeId)).thenThrow(Exception('error'));
      expectLater(
          bloc.stream,
          emitsInOrder([
            UserLeaveState(status: Status.loading),
            UserLeaveState(error: firestoreFetchDataError, status: Status.error)
          ]));
    });

    test('Emits error state when stream have any error', () {
      bloc.add(FetchUserLeaveEvent());

      when(userStateNotifier.employeeId).thenReturn(employeeId);
      when(leaveRepo.userLeaves(employeeId))
          .thenAnswer((_) => Stream.error(firestoreFetchDataError));
      expectLater(
          bloc.stream,
          emitsInOrder([
            UserLeaveState(status: Status.loading),
            UserLeaveState(error: firestoreFetchDataError, status: Status.error)
          ]));
    });

    test('change year and show year wise leave test', () {
      bloc.add(FetchUserLeaveEvent());
      when(userStateNotifier.employeeId).thenReturn(employeeId);
      when(leaveRepo.userLeaves(employeeId)).thenAnswer(
          (_) => Stream.value([pastLeave, upcomingLeave, specificYearLeave]));
      bloc.add(ChangeYearEvent(year: 2022));
      expectLater(
          bloc.stream,
          emitsInOrder([
            UserLeaveState(status: Status.loading),
            UserLeaveState(
                status: Status.success, leaves: [upcomingLeave, pastLeave]),
            UserLeaveState(
                status: Status.success,
                leaves: [specificYearLeave],
                selectedYear: 2022),
          ]));
    });
  });
}
