import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_bloc.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_state.dart';

import 'user_home_test.mocks.dart';

@GenerateMocks([UserStateNotifier, LeaveService])
void main() {
  late UserHomeBloc bLoc;
  late UserStateNotifier userStateNotifier;
  late LeaveService leaveService;

  final employee = Employee(
    uid: "1",
    role: Role.employee,
    name: "test",
    employeeId: "103",
    email: "abc@gmail.com",
    designation: "android dev",
    dateOfJoining: DateTime(2000),
  );
  final leave = Leave(
      leaveId: 'leaveId',
      uid: employee.uid,
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
    leaveService = MockLeaveService();
    when(userStateNotifier.employeeId).thenReturn(employee.uid);
  });

  group('User home bloc state for requests', () {
    test('listen realtime update in init state', () async {
      when(leaveService.getRequestedLeaveSnapshot(employee.uid))
          .thenAnswer((realInvocation) => Stream.value([leave]));
      bLoc = UserHomeBloc(userStateNotifier, leaveService);
      expect(bLoc.state, UserHomeInitialState());
      expectLater(
          bLoc.stream,
          emitsInOrder([
            UserHomeLoadingState(),
            UserHomeSuccessState(requests: [leave])
          ]));

      await untilCalled(leaveService.getRequestedLeaveSnapshot(employee.uid));
      verify(leaveService.getRequestedLeaveSnapshot(employee.uid)).called(1);
    });

    test('emit failure state with error on error', () async {
      when(leaveService.getRequestedLeaveSnapshot(employee.uid))
          .thenAnswer((realInvocation) => Stream.error("error"));
      bLoc = UserHomeBloc(userStateNotifier, leaveService);
      expect(bLoc.state, UserHomeInitialState());
      expectLater(
          bLoc.stream,
          emitsInOrder([
            UserHomeLoadingState(),
            UserHomeErrorState(error: firestoreFetchDataError)
          ]));

      await untilCalled(leaveService.getRequestedLeaveSnapshot(employee.uid));
      verify(leaveService.getRequestedLeaveSnapshot(employee.uid)).called(1);
    });
  });
}
