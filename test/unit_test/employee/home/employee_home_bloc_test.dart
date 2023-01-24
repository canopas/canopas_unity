import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/model/leave_count.dart';
import 'package:projectunity/pref/user_preference.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/admin/employee_service.dart';
import 'package:projectunity/services/admin/paid_leave_service.dart';
import 'package:projectunity/services/admin/leave_service.dart';
import 'package:projectunity/services/auth/auth_service.dart';
import 'package:projectunity/services/user/user_leave_service.dart';
import 'package:projectunity/ui/user/home/bloc/employee_home_bloc.dart';
import 'package:projectunity/ui/user/home/bloc/employee_home_event.dart';
import 'package:projectunity/ui/user/home/bloc/employee_home_state.dart';
import 'employee_home_bloc_test.mocks.dart';


@GenerateMocks([
  UserLeaveService,
  UserManager,
  PaidLeaveService,
  EmployeeService,
  AdminLeaveService,
  AuthService,
  UserPreference,
])
void main() {
  late EmployeeHomeBloc bLoc;
  late EmployeeService employeeService;
  late AdminLeaveService adminLeaveService;
  late PaidLeaveService paidLeaveService;
  late UserLeaveService userLeaveService;
  late UserManager userManager;
  late AuthService authService;
  late UserPreference userPreference;

  EmployeeHomeState loadingState =
      const EmployeeHomeState(status: EmployeeHomeStatus.loading);

  const employee = Employee(
      id: "1",
      roleType: 2,
      name: "test",
      employeeId: "103",
      email: "abc@gmail.com",
      designation: "android dev");

  Leave leave = const Leave(
      leaveId: "101",
      uid: "1",
      leaveType: 1,
      startDate: 111,
      endDate: 113,
      totalLeaves: 1,
      reason: "test",
      leaveStatus: 0,
      appliedOn: 111,
      perDayDuration: []);

  setUp(() {
    employeeService = MockEmployeeService();
    userLeaveService = MockUserLeaveService();
    userManager = MockUserManager();
    paidLeaveService = MockPaidLeaveService();
    adminLeaveService = MockAdminLeaveService();
    authService = MockAuthService();
    userPreference = MockUserPreference();
    bLoc = EmployeeHomeBloc(userManager, userLeaveService, paidLeaveService,
        employeeService, adminLeaveService,userPreference,authService);

    when(employeeService.hasUser(employee.email)).thenAnswer((_) => Future(() => true));
    when(authService.signOutWithGoogle()).thenAnswer((_) => Future(() => true));
    when(userPreference.removeCurrentUser()).thenAnswer((_) => Future(() => true));
    when(userManager.email).thenReturn(employee.email);

    when(userManager.employeeId).thenReturn(employee.id);
  });


  test("emit state with loading status on FetchEvent", () {
    when(userLeaveService.getUserUsedLeaveCount("1"))
        .thenAnswer((_) => Future.value(2.0));
    when(paidLeaveService.getPaidLeaves()).thenAnswer((_) => Future.value(12));

    when(employeeService.getEmployees()).thenAnswer((_) => Future.value([]));
    when(adminLeaveService.getAllAbsence()).thenAnswer((_) => Future.value([]));

    bLoc.add(EmployeeHomeFetchEvent());

    expect(bLoc.stream, emits(loadingState));
  });

  test("emit state with leave count while fetching summary on FetchEvent",
      () async {
    when(userLeaveService.getUserUsedLeaveCount("1"))
        .thenAnswer((_) => Future.value(2.0));
    when(paidLeaveService.getPaidLeaves()).thenAnswer((_) => Future.value(12));
    when(employeeService.getEmployees()).thenAnswer((_) => Future.value([]));
    when(adminLeaveService.getAllAbsence()).thenAnswer((_) => Future.value([]));

    LeaveCounts leaveCounts = const LeaveCounts(
        remainingLeaveCount: 10.0, usedLeaveCount: 2.0, paidLeaveCount: 12);

    EmployeeHomeState currentState = EmployeeHomeState(
        status: EmployeeHomeStatus.loading,
        leaveCount: leaveCounts,
        absence: const []);

    final expected = [loadingState, currentState];
    expectLater(bLoc.stream, emitsInOrder(expected));

    bLoc.add(EmployeeHomeFetchEvent());
  });



  test("emit state with failure status while fetching summary on FetchEvent",
      () async {
    when(userLeaveService.getUserUsedLeaveCount("1"))
        .thenThrow(Exception("Error"));
    when(paidLeaveService.getPaidLeaves()).thenAnswer((_) => Future.value(12));
    when(employeeService.getEmployees()).thenAnswer((_) => Future.value([]));
    when(adminLeaveService.getAllAbsence()).thenAnswer((_) => Future.value([]));

    EmployeeHomeState currentState =
        const EmployeeHomeState(status: EmployeeHomeStatus.failure);

    final expected = [loadingState, currentState];
    expectLater(bLoc.stream, emitsInOrder(expected));

    bLoc.add(EmployeeHomeFetchEvent());
  });

  test("emit state with failure status while absence on FetchEvent", () async {
    when(userLeaveService.getUserUsedLeaveCount("1"))
        .thenAnswer((_) => Future.value(2.0));
    when(paidLeaveService.getPaidLeaves()).thenThrow(Exception("Error"));

    when(employeeService.getEmployees()).thenAnswer((_) => Future.value([]));
    when(adminLeaveService.getAllAbsence()).thenAnswer((_) => Future.value([]));

    EmployeeHomeState currentState =
        const EmployeeHomeState(status: EmployeeHomeStatus.failure);

    final expected = [loadingState, currentState];
    expectLater(bLoc.stream, emitsInAnyOrder(expected));

    bLoc.add(EmployeeHomeFetchEvent());
  });

  test(
      "emit state with empty absence list while fetching absence on FetchEvent",
      () async {
    when(userLeaveService.getUserUsedLeaveCount("1"))
        .thenAnswer((_) => Future.value(2.0));
    when(paidLeaveService.getPaidLeaves()).thenAnswer((_) => Future.value(12));

    when(employeeService.getEmployees()).thenAnswer((_) => Future.value([]));
    when(adminLeaveService.getAllAbsence()).thenAnswer((_) => Future.value([]));

    LeaveCounts leaveCounts = const LeaveCounts(
        remainingLeaveCount: 10.0, usedLeaveCount: 2.0, paidLeaveCount: 12);

    EmployeeHomeState stateWithLeaveCount = EmployeeHomeState(
        status: EmployeeHomeStatus.loading, leaveCount: leaveCounts);

    EmployeeHomeState currentState = EmployeeHomeState(
        status: EmployeeHomeStatus.success,
        leaveCount: leaveCounts,
        absence: const []);

    final expected = [loadingState, stateWithLeaveCount, currentState];
    expectLater(bLoc.stream, emitsInAnyOrder(expected));

    bLoc.add(EmployeeHomeFetchEvent());
  });

  test("emit state with  absence list while fetching absence on FetchEvent",
      () async {
    when(userLeaveService.getUserUsedLeaveCount("1"))
        .thenAnswer((_) => Future.value(2.0));
    when(paidLeaveService.getPaidLeaves()).thenAnswer((_) => Future.value(12));

    when(employeeService.getEmployees())
        .thenAnswer((_) => Future.value([employee]));

    when(adminLeaveService.getAllAbsence())
        .thenAnswer((_) => Future.value([leave]));

    LeaveCounts leaveCounts = const LeaveCounts(
        remainingLeaveCount: 10.0, usedLeaveCount: 2.0, paidLeaveCount: 12);

    final leaveApplication = LeaveApplication(employee: employee, leave: leave);

    EmployeeHomeState stateWithLeaveCount = EmployeeHomeState(
        status: EmployeeHomeStatus.loading, leaveCount: leaveCounts);

    EmployeeHomeState currentState = EmployeeHomeState(
        status: EmployeeHomeStatus.success,
        leaveCount: leaveCounts,
        absence: [leaveApplication]);

    final expected = [loadingState, stateWithLeaveCount, currentState];
    expectLater(bLoc.stream, emitsInAnyOrder(expected));

    bLoc.add(EmployeeHomeFetchEvent());
  });

  test(
      "emit state with empty list when employee not match with leave while fetching absence on FetchEvent",
      () async {
    const employee = Employee(
        id: "2",
        roleType: 1,
        name: "test",
        employeeId: "103",
        email: "abc@gmail.com",
        designation: "android dev");

    when(userLeaveService.getUserUsedLeaveCount("1"))
        .thenAnswer((_) => Future.value(2.0));
    when(paidLeaveService.getPaidLeaves()).thenAnswer((_) => Future.value(12));

    when(employeeService.getEmployees())
        .thenAnswer((_) => Future.value([employee]));

    when(adminLeaveService.getAllAbsence())
        .thenAnswer((_) => Future.value([leave]));

    LeaveCounts leaveCounts = const LeaveCounts(
        remainingLeaveCount: 10.0, usedLeaveCount: 2.0, paidLeaveCount: 12);

    EmployeeHomeState stateWithLeaveCount = EmployeeHomeState(
        status: EmployeeHomeStatus.loading, leaveCount: leaveCounts);

    EmployeeHomeState currentState = EmployeeHomeState(
        status: EmployeeHomeStatus.success,
        leaveCount: leaveCounts,
        absence: const []);

    final expected = [loadingState, stateWithLeaveCount, currentState];
    expectLater(bLoc.stream, emitsInAnyOrder(expected));

    bLoc.add(EmployeeHomeFetchEvent());
  });

  group('Navigation for user', () {
    test(' on UserDisable event User should be navigate to login screen if has been deleted successfully by admin', ()async  {
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

  tearDown(() {
    bLoc.close();
  });
}
