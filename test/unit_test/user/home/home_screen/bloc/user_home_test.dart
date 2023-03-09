import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/pref/user_preference.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/auth_service.dart';
import 'package:projectunity/services/leave_service.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_bloc.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_event.dart';
import 'package:projectunity/ui/user/home/home_screen/bloc/user_home_state.dart';

import 'user_home_test.mocks.dart';

@GenerateMocks([UserManager, AuthService, UserPreference, LeaveService])
void main() {
  late UserHomeBloc bLoc;
  late UserManager userManager;
  late AuthService authService;
  late UserPreference userPreference;
  late LeaveService leaveService;

  const employee = Employee(
      id: "1",
      roleType: 2,
      name: "test",
      employeeId: "103",
      email: "abc@gmail.com",
      designation: "android dev");
  final leave = Leave(
      leaveId: 'leaveId',
      uid: employee.id,
      leaveType: 2,
      startDate: DateTime.now().add(const Duration(days: 2)).timeStampToInt,
      endDate: DateTime.now().add(const Duration(days: 4)).timeStampToInt,
      totalLeaves: 2,
      reason: 'Suffering from fever',
      leaveStatus: pendingLeaveStatus,
      appliedOn: 12,
      perDayDuration: const [1, 1]);

  setUp(() {
    userManager = MockUserManager();
    authService = MockAuthService();
    userPreference = MockUserPreference();
    leaveService = MockLeaveService();
    bLoc = UserHomeBloc(userPreference, authService, userManager, leaveService);

    when(authService.signOutWithGoogle()).thenAnswer((_) async => true);
    when(userPreference.removeCurrentUser()).thenAnswer((_) async => true);
    when(userManager.email).thenReturn(employee.email);

    when(userManager.employeeId).thenReturn(employee.id);
  });

  group('User home bloc state for requests', () {
    test('Emits initial state as state of bloc', () {
      expect((bLoc.state), UserHomeInitialState());
    });

    test(
        'Emits loading state and then success state with requests if user has applied for any request',
        () {
      when(leaveService.getRequestedLeaveOfUser(employee.id))
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
      when(leaveService.getRequestedLeaveOfUser(employee.id))
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

  group('Authentication status event', () {
    test(
        ' on UserDisable event User should be navigate to login screen if has been deleted successfully by admin',
        () async {
      when(userManager.employeeId).thenReturn(employee.id);
      bLoc.add(UserDisabled(employee.id));
      await untilCalled(authService.signOutWithGoogle());
      await untilCalled(userPreference.removeCurrentUser());
      await untilCalled(userManager.hasLoggedIn());
      verify(authService.signOutWithGoogle()).called(1);

      verify(userPreference.removeCurrentUser()).called(1);
      verify(userManager.hasLoggedIn()).called(1);
    });
  });
}
