import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/Repo/leave_repo.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/provider/user_status_notifier.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_bloc.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_event.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_state.dart';

import 'user_home_test.mocks.dart';

@GenerateMocks([UserStatusNotifier, LeaveRepo])
void main() {
  late UserHomeBloc bLoc;
  late UserStatusNotifier userStateNotifier;
  late LeaveRepo leaveRepo;

  const employeeUID = 'uid';

  final leave = Leave(
      leaveId: 'leaveId',
      uid: employeeUID,
      type: LeaveType.sickLeave,
      startDate: DateTime.now().add(const Duration(days: 2)),
      endDate: DateTime.now().add(const Duration(days: 4)),
      total: 2,
      reason: 'Suffering from fever',
      status: LeaveStatus.pending,
      appliedOn: DateTime.now(),
      perDayDuration: const [
        LeaveDayDuration.firstHalfLeave,
        LeaveDayDuration.firstHalfLeave
      ]);

  setUp(() {
    userStateNotifier = MockUserStateNotifier();
    leaveRepo = MockLeaveRepo();
    bLoc = UserHomeBloc(userStateNotifier, leaveRepo);
    when(userStateNotifier.employeeId).thenReturn(employeeUID);
  });

  group('User home bloc state for requests', () {
    test('test initial state', () {
      expect((bLoc.state), UserHomeInitialState());
    });

    test(
        'Emits loading state and then success state with requests if user has applied for any request',
        () {
      when(leaveRepo.userLeaveRequest(employeeUID))
          .thenAnswer((_) => Stream.value([leave]));
      expectLater(
          bLoc.stream,
          emitsInOrder([
            UserHomeLoadingState(),
            UserHomeSuccessState(requests: [leave])
          ]));
      bLoc.add(UserHomeFetchLeaveRequest());
    });

    test(
        'Emits loading state and then error state if exception is thrown by stream',
        () {
      when(leaveRepo.userLeaveRequest(employeeUID))
          .thenAnswer((_) => Stream.error(firestoreFetchDataError));
      expectLater(
          bLoc.stream,
          emitsInOrder([
            UserHomeLoadingState(),
            UserHomeErrorState(error: firestoreFetchDataError)
          ]));
      bLoc.add(UserHomeFetchLeaveRequest());
    });

    test('Emits loading state and then error state if their any exception', () {
      when(leaveRepo.userLeaveRequest(employeeUID))
          .thenThrow(Exception(firestoreFetchDataError));
      expectLater(
          bLoc.stream,
          emitsInOrder([
            UserHomeLoadingState(),
            UserHomeErrorState(error: firestoreFetchDataError)
          ]));
      bLoc.add(UserHomeFetchLeaveRequest());
    });
  });
}
