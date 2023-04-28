import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/model/leave_application.dart';
import 'package:projectunity/data/model/leave_count.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:projectunity/data/services/space_service.dart';
import 'package:projectunity/ui/user/home/leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_bloc.dart';
import 'package:projectunity/ui/user/home/leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_events.dart';
import 'package:projectunity/ui/user/home/leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_states.dart';

import 'user_leave_calendar_test.mocks.dart';

@GenerateMocks([LeaveService, EmployeeService, UserManager,SpaceService])
void main() {
  late LeaveService leaveService;
  late EmployeeService employeeService;
  late UserManager userManager;
  late SpaceService spaceService;
  late UserLeaveCalendarBloc userLeaveCalendarViewBloc;

  String userID = "123";

  const employee = Employee(
    uid: "123",
    role: Role.employee,
    name: "test",
    employeeId: "103",
    email: "abc@gmail.com",
    designation: "tester",
  );

  Leave leave = Leave(
      leaveId: "234",
      uid: "123",
      type: 1,
      startDate: DateTime.now().dateOnly.timeStampToInt,
      endDate: DateTime.now().dateOnly.timeStampToInt,
      total: 1.0,
      reason: 'leave reason',
      status: 1,
      appliedOn: 1000,
      perDayDuration: const [1]);

  const leaveCounts = LeaveCounts(
      paidLeaveCount: 12, usedLeaveCount: 6.0, remainingLeaveCount: 6.0);

  List<LeaveApplication> leaveApplications = [
    LeaveApplication(employee: employee, leave: leave, leaveCounts: leaveCounts)
  ];

  group("User Leave Calendar Test", () {
    setUp(() {
      leaveService = MockLeaveService();
      employeeService = MockEmployeeService();
      userManager = MockUserManager();
      spaceService = MockSpaceService();
      userLeaveCalendarViewBloc = UserLeaveCalendarBloc(
          leaveService, employeeService, userManager,spaceService);
      when(employeeService.getEmployee(userID))
          .thenAnswer((_) => Future(() => employee));
      when(leaveService.getAllLeavesOfUser(userID))
          .thenAnswer((_) => Future(() => [leave]));
      when(leaveService.getUserUsedLeaves(userID))
          .thenAnswer((_) => Future(() => 6.0));
      when(userManager.currentSpaceId).thenReturn('space-id');
      when(spaceService.getPaidLeaves(spaceId: 'space-id'))
          .thenAnswer((_) => Future(() => 12));
    });

    test("initial load data test", () {
      userLeaveCalendarViewBloc.add(UserLeaveCalendarInitialLoadEvent(userID));
      expect(
          userLeaveCalendarViewBloc.stream,
          emitsInOrder([
            UserLeaveCalendarViewLoadingState(),
            UserLeaveCalendarViewSuccessState(
                leaveApplications: leaveApplications,
                allLeaveApplications: leaveApplications)
          ]));
    });

    test("get leave by select date range test when there leave of that date.",
        () {
      userLeaveCalendarViewBloc.emit(UserLeaveCalendarViewSuccessState(
          leaveApplications: const [],
          allLeaveApplications: leaveApplications));
      userLeaveCalendarViewBloc.add(DateRangeSelectedEvent(
          DateTime.now().dateOnly,
          DateTime.now().add(const Duration(days: 1)).dateOnly,
          DateTime.now().dateOnly));
      expect(
          userLeaveCalendarViewBloc.stream,
          emits(UserLeaveCalendarViewSuccessState(
              leaveApplications: leaveApplications,
              allLeaveApplications: leaveApplications)));
    });

    test(
        "get leave by select date range test when there no leave of that date.",
        () {
      userLeaveCalendarViewBloc.emit(UserLeaveCalendarViewSuccessState(
          leaveApplications: leaveApplications,
          allLeaveApplications: leaveApplications));
      userLeaveCalendarViewBloc.add(DateRangeSelectedEvent(
          DateTime(2000).dateOnly,
          DateTime(2000).dateOnly,
          DateTime(2000).dateOnly));
      expect(
          userLeaveCalendarViewBloc.stream,
          emits(UserLeaveCalendarViewSuccessState(
              leaveApplications: const [],
              allLeaveApplications: leaveApplications)));
    });

    test("remove leave application test", () {
      userLeaveCalendarViewBloc.emit(UserLeaveCalendarViewSuccessState(
          leaveApplications: leaveApplications,
          allLeaveApplications: leaveApplications));
      userLeaveCalendarViewBloc
          .add(RemoveOrCancelLeaveApplication(leaveApplications.first));
      expect(
          userLeaveCalendarViewBloc.stream,
          emits(
            UserLeaveCalendarViewSuccessState(
                leaveApplications: const [], allLeaveApplications: const []),
          ));
    });
  });
}
