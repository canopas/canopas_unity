import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/model/leave_count.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/admin/employee/employee_service.dart';
import 'package:projectunity/services/admin/paid_leave/paid_leave_service.dart';
import 'package:projectunity/services/admin/requests/admin_leave_service.dart';
import 'package:projectunity/services/leave/user_leave_service.dart';
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
  NavigationStackManager
])
void main() {
  late EmployeeHomeBloc bLoc;
  late EmployeeService employeeService;
  late AdminLeaveService adminLeaveService;
  late PaidLeaveService paidLeaveService;
  late UserLeaveService userLeaveService;
  late NavigationStackManager stackManager;
  late UserManager userManager;

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
    stackManager = MockNavigationStackManager();
    bLoc = EmployeeHomeBloc(userManager, userLeaveService, paidLeaveService,
        employeeService, adminLeaveService, stackManager);

    when(userManager.employeeId).thenReturn("1");
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

  test("test navigate to user calender on EmployeeHomeShowLeaveCalender event",
      () async {
    bLoc.add(EmployeeHomeShowLeaveCalender());

    const state = NavStackItem.userLeaveCalendarState(userId: "1");
    await untilCalled(stackManager.push(state));

    verify(stackManager.push(state));
  });

  test("test navigate to settings on EmployeeHomeShowSetting event", () async {
    bLoc.add(EmployeeHomeShowSetting());

    const state = NavStackItem.employeeSettingsState();

    await untilCalled(stackManager.push(state));
    verify(stackManager.push(state));
  });

  test("test navigate to all leaves on EmployeeHomeShowAllLeaves event",
      () async {
    bLoc.add(EmployeeHomeShowAllLeaves());

    const state = NavStackItem.employeeAllLeavesScreenState();

    await untilCalled(stackManager.push(state));
    verify(stackManager.push(state));
  });

  test(
      "test navigate to requested leaves on EmployeeHomeShowRequestedLeaves event",
      () async {
    bLoc.add(EmployeeHomeShowRequestedLeaves());

     const state = NavStackItem.employeeRequestedLeavesScreenState();

    await untilCalled(stackManager.push(state));
    verify(stackManager.push(state));
  });

  test(
      "test navigate to upcoming leaves on EmployeeHomeShowUpcomingLeaves event",
      () async {
    bLoc.add(EmployeeHomeShowUpcomingLeaves());

     const state = NavStackItem.employeeUpcomingLeavesScreenState();

    await untilCalled(stackManager.push(state));
    verify(stackManager.push(state));
  });

  test("test navigate to apply for leaves on EmployeeHomeShowApplyLeave event",
      () async {
    bLoc.add(EmployeeHomeShowApplyLeave());

    const state = NavStackItem.leaveRequestState();

    await untilCalled(stackManager.push(state));
    verify(stackManager.push(state));
  });

  test("test navigate to who's out calender on EmployeeHomeShowWhosOut event",
      () async {
    bLoc.add(EmployeeHomeShowWhosOut());

    const state = NavStackItem.whoIsOutCalendarState();

    await untilCalled(stackManager.push(state));
    verify(stackManager.push(state));
  });

  tearDown(() {
    bLoc.close();
  });
}
