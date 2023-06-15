import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/auth_service.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_bloc.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_event.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_state.dart';

import 'user_home_test.mocks.dart';

@GenerateMocks([UserStateNotifier, AuthService, LeaveService])
void main() {
  late UserHomeBloc bLoc;
  late UserStateNotifier userStateNotifier;
  late AuthService authService;
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
      perDayDuration: const [LeaveDayDuration.firstHalfLeave, LeaveDayDuration.firstHalfLeave]);

  setUp(() {
    userStateNotifier = MockUserStateNotifier();
    authService = MockAuthService();
    leaveService = MockLeaveService();
    bLoc = UserHomeBloc(userStateNotifier, leaveService);

    when(authService.signOutWithGoogle()).thenAnswer((_) async => true);
    when(userStateNotifier.employeeId).thenReturn(employee.uid);
  });

  group('User home bloc state for requests', () {
    test('Emits initial state as state of bloc', () {
      expect((bLoc.state), UserHomeInitialState());
    });

    test(
        'Emits loading state and then success state with requests if user has applied for any request',
        () {
      when(leaveService.getRequestedLeave(employee.uid))
          .thenAnswer((_) async => [leave]);

      expectLater(
          bLoc.stream,
          emitsInOrder([
            UserHomeLoadingState(),
            UserHomeSuccessState(requests: [leave])
          ]));
      bLoc.add(UserHomeFetchLeaveRequest());
    });

    test('Emits loading state and then error state if exception is thrown', () {
      when(leaveService.getRequestedLeave(employee.uid))
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
