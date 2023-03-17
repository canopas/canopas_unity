import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:projectunity/data/services/paid_leave_service.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_bloc.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_count_state.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leave_count/user_leave_cout_event.dart';

import 'user_leave_count_bloc_test.mocks.dart';

@GenerateMocks([LeaveService, UserManager, PaidLeaveService])
void main() {
  late LeaveService leaveService;
  late UserManager userManager;
  late PaidLeaveService paidLeaveService;
  late UserLeaveCountBloc userLeaveCountBloc;
  UserLeaveCountState loadingState = const UserLeaveCountState(
      status: UserLeaveCountStatus.loading,
      used: 0,
      totalLeaves: 12,
      leavePercentage: 1,
      error: null);

  const String employeeId = 'Employee Id';

  setUp(() {
    leaveService = MockLeaveService();
    userManager = MockUserManager();
    paidLeaveService = MockPaidLeaveService();
    userLeaveCountBloc =
        UserLeaveCountBloc(leaveService, userManager, paidLeaveService);
  });

  group('User Leave count State', () {
    test(
        'Emits initial  state when screen is open and fetching data from service',
        () {
      UserLeaveCountState initialState = const UserLeaveCountState(
          status: UserLeaveCountStatus.initial,
          used: 0,
          totalLeaves: 12,
          leavePercentage: 1,
          error: null);
      expect(userLeaveCountBloc.state, initialState);
    });
    test(
        'emits loading state and success state after add FetchUserLeaveCountEvent respectively',
        () {
      userLeaveCountBloc.add(FetchLeaveCountEvent());

      when(userManager.employeeId).thenReturn(employeeId);
      when(leaveService.getUserUsedLeaves(employeeId))
          .thenAnswer((_) async => 7);
      when(paidLeaveService.getPaidLeaves()).thenAnswer((_) async => 12);
      var percentage = 7 / 12;

      UserLeaveCountState successState = UserLeaveCountState(
          status: UserLeaveCountStatus.success,
          used: 7,
          totalLeaves: 12,
          leavePercentage: percentage,
          error: null);
      expectLater(userLeaveCountBloc.stream,
          emitsInOrder([loadingState, successState]));
    });

    test('emits error state when Exception is thrown', () {
      userLeaveCountBloc.add(FetchLeaveCountEvent());

      when(userManager.employeeId).thenReturn('Ca 1044');
      when(leaveService.getUserUsedLeaves('Ca 1044'))
          .thenAnswer((_) async => 7);
      when(paidLeaveService.getPaidLeaves())
          .thenThrow(Exception('Couldn\'t load'));
      UserLeaveCountState errorState = const UserLeaveCountState(
          status: UserLeaveCountStatus.failure,
          used: 0,
          totalLeaves: 12,
          leavePercentage: 1,
          error: firestoreFetchDataError);
      expectLater(
          userLeaveCountBloc.stream, emitsInOrder([loadingState, errorState]));
    });
  });
}
