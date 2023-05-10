import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_bloc.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_event.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_state.dart';

import 'user_leave_bloc_test.mocks.dart';

@GenerateMocks([LeaveService, UserManager])
void main() {
  late LeaveService leaveService;
  late UserManager userManager;
  late UserLeaveBloc userLeaveBloc;
  const String employeeId = 'CA 1044';
  DateTime today = DateTime.now();

  Leave upcomingLeave = Leave(
      leaveId: 'Leave Id',
      uid: "user id",
      type: 1,
      startDate: today.add(const Duration(days: 1)).timeStampToInt,
      endDate: today.add(const Duration(days: 2)).timeStampToInt,
      total: 2,
      reason: 'Suffering from viral fever',
      status: approveLeaveStatus,
      appliedOn: today.timeStampToInt,
      perDayDuration: const [
        LeaveDayDuration.firstHalfLeave,
        LeaveDayDuration.firstHalfLeave
      ]);

  Leave pastLeave = Leave(
      leaveId: 'Leave-Id',
      uid: "user id",
      type: 1,
      startDate: today.subtract(const Duration(days: 2)).timeStampToInt,
      endDate: today.subtract(const Duration(days: 1)).timeStampToInt,
      total: 1,
      reason: 'Suffering from viral fever',
      status: approveLeaveStatus,
      appliedOn: today.timeStampToInt,
      perDayDuration: const [LeaveDayDuration.firstHalfLeave]);

  setUp(() {
    leaveService = MockLeaveService();
    userManager = MockUserManager();
    userLeaveBloc = UserLeaveBloc(userManager, leaveService);
  });

  tearDown(() async {
    await userLeaveBloc.close();
  });

  group('UserLeaveBloc stream test', () {
    test('Emits loading state as initial state of UserLeavesBloc', () {
      expect(userLeaveBloc.state, const UserLeaveState());
    });

    test(
        'Emits loading state and success with sorted leave leave after add UserLeaveEvent respectively',
        () {
      userLeaveBloc.add(FetchUserLeaveEvent());
      when(userManager.employeeId).thenReturn(employeeId);
      when(leaveService.getAllLeavesOfUser(employeeId))
          .thenAnswer((_) async => [pastLeave, upcomingLeave]);
      expectLater(
          userLeaveBloc.stream,
          emitsInOrder([
            const UserLeaveState(status: Status.loading),
            UserLeaveState(
                status: Status.success, leaves: [upcomingLeave, pastLeave]),
          ]));
    });
    test('Emits error state when Exception is thrown', () {
      userLeaveBloc.add(FetchUserLeaveEvent());

      when(userManager.employeeId).thenReturn(employeeId);
      when(leaveService.getAllLeavesOfUser(employeeId))
          .thenThrow(Exception('error'));
      expectLater(
          userLeaveBloc.stream,
          emitsInOrder([
            const UserLeaveState(status: Status.loading),
            const UserLeaveState(
                error: firestoreFetchDataError, status: Status.error)
          ]));
    });
  });
}
