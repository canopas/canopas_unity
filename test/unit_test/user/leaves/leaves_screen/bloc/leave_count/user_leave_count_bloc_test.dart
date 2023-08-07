import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/repo/leave_repo.dart';
import 'package:projectunity/data/services/space_service.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_bloc.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_state.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_cout_event.dart';

import 'user_leave_count_bloc_test.mocks.dart';

@GenerateMocks([LeaveRepo, UserStateNotifier, SpaceService])
void main() {
  late LeaveRepo leaveRepo;
  late UserStateNotifier userStateNotifier;
  late SpaceService spaceService;
  late UserLeaveCountBloc userLeaveCountBloc;

  UserLeaveCountState loadingState = const UserLeaveCountState(
      status: Status.loading,
      usedLeavesCounts: 0,
      leavePercentage: 0,
      error: null);

  const String employeeId = 'Employee Id';

  setUp(() {
    leaveRepo = MockLeaveRepo();
    userStateNotifier = MockUserStateNotifier();
    spaceService = MockSpaceService();
    userLeaveCountBloc =
        UserLeaveCountBloc(leaveRepo, userStateNotifier, spaceService);
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
              usedLeavesCounts: 0,
              leavePercentage: 0,
              error: null));
    });
    test(
        'emits loading state and success state after add FetchUserLeaveCountEvent respectively',
        () {
          userLeaveCountBloc.add(FetchLeaveCountEvent());

      when(userStateNotifier.employeeId).thenReturn(employeeId);
      when(userStateNotifier.currentSpaceId).thenReturn("space-id");
      when(leaveRepo.getUserUsedLeaves(uid: employeeId))
          .thenAnswer((_) async => 7);
      when(spaceService.getPaidLeaves(spaceId: 'space-id'))
          .thenAnswer((_) async => 12);

      const UserLeaveCountState successState = UserLeaveCountState(
          status: Status.success,
          usedLeavesCounts: 7,
          leavePercentage: 7 / 12,
          error: null);
      expectLater(userLeaveCountBloc.stream,
          emitsInOrder([loadingState, successState]));
    });

    test('emits error state when Exception is thrown', () {
      userLeaveCountBloc.add(FetchLeaveCountEvent());

      when(userStateNotifier.employeeId).thenReturn('Ca 1044');
      when(userStateNotifier.currentSpaceId).thenReturn('space-id');
      when(leaveRepo.getUserUsedLeaves(uid: 'Ca 1044'))
          .thenAnswer((_) async => 7);
      when(spaceService.getPaidLeaves(spaceId: 'space-id'))
          .thenThrow(Exception('error'));
      const UserLeaveCountState errorState = UserLeaveCountState(
          status: Status.success,
          usedLeavesCounts: 0,
          leavePercentage: 0,
          error: firestoreFetchDataError);
      expectLater(
          userLeaveCountBloc.stream, emitsInOrder([loadingState, errorState]));
    });
  });
}
