import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/leave_count.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/repo/leave_repo.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_bloc.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_state.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_cout_event.dart';

import 'user_leave_count_bloc_test.mocks.dart';

@GenerateMocks([LeaveRepo, UserStateNotifier])
void main() {
  late LeaveRepo leaveRepo;
  late UserStateNotifier userStateNotifier;
  late UserLeaveCountBloc userLeaveCountBloc;

  UserLeaveCountState loadingState = const UserLeaveCountState(
      status: Status.loading, usedLeavesCounts: LeaveCounts(), error: null);

  const String employeeId = 'Employee Id';

  setUp(() {
    leaveRepo = MockLeaveRepo();
    userStateNotifier = MockUserStateNotifier();
    userLeaveCountBloc = UserLeaveCountBloc(leaveRepo, userStateNotifier);
  });

  tearDown(() async {
    await userLeaveCountBloc.close();
  });

  group('User Leave count State', () {
    test(
        'Emits initial  state when screen is open and fetching data from service',
        () {
      expect(
          userLeaveCountBloc.state,
          const UserLeaveCountState(
              status: Status.initial,
              usedLeavesCounts: LeaveCounts(),
              error: null));
    });
    test(
        'emits loading state and success state after add FetchUserLeaveCountEvent respectively',
        () {
      userLeaveCountBloc.add(FetchLeaveCountEvent());

      when(userStateNotifier.employeeId).thenReturn(employeeId);
      when(userStateNotifier.currentSpaceId).thenReturn("space-id");
      when(leaveRepo.getUserUsedLeaves(uid: employeeId)).thenAnswer(
          (_) async => const LeaveCounts(urgentLeaves: 2, casualLeaves: 5));

      const UserLeaveCountState successState = UserLeaveCountState(
          status: Status.success,
          usedLeavesCounts: LeaveCounts(urgentLeaves: 2, casualLeaves: 5),
          error: null);
      expectLater(userLeaveCountBloc.stream,
          emitsInOrder([loadingState, successState]));
    });

    test('emits error state when Exception is thrown', () {
      userLeaveCountBloc.add(FetchLeaveCountEvent());

      when(userStateNotifier.employeeId).thenReturn('Ca 1044');
      when(userStateNotifier.currentSpaceId).thenReturn('space-id');
      when(leaveRepo.getUserUsedLeaves(uid: 'Ca 1044'))
          .thenThrow(Exception('error'));

      const UserLeaveCountState errorState = UserLeaveCountState(
          status: Status.success,
          usedLeavesCounts: LeaveCounts(urgentLeaves: 0, casualLeaves: 0),
          error: firestoreFetchDataError);
      expectLater(
          userLeaveCountBloc.stream, emitsInOrder([loadingState, errorState]));
    });
  });
}
