import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/model/leave_count.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/services/admin/employee/employee_service.dart';
import 'package:projectunity/services/admin/paid_leave/paid_leave_service.dart';
import 'package:projectunity/services/leave/user_leave_service.dart';
import 'package:projectunity/ui/shared/user_leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_bloc.dart';
import 'package:projectunity/ui/shared/user_leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_events.dart';
import 'package:projectunity/ui/shared/user_leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_states.dart';

import 'user_leave_calendar_view_test.mocks.dart';

@GenerateMocks([UserLeaveService,NavigationStackManager,EmployeeService,PaidLeaveService])
void main(){

  late UserLeaveService userLeaveService;
  late NavigationStackManager stackManager;
  late EmployeeService employeeService;
  late PaidLeaveService paidLeaveService;
  late UserLeaveCalendarViewBloc userLeaveCalendarViewBloc;

  String userID = "123";

  final employee = Employee(
    id: "123",
    roleType: 2,
    name: "test",
    employeeId: "103",
    email: "abc@gmail.com",
    designation: "tester",
  );

  final leave = Leave(
      leaveId: "234",
      uid: "123",
      leaveType: 1,
      startDate: 300303,
      endDate: 500000,
      totalLeaves: 1.0,
      reason: 'leave reason',
      leaveStatus: 1,
      appliedOn: 1000,
      perDayDuration: const [1]);

  const leaveCounts = LeaveCounts(paidLeaveCount: 12, usedLeaveCount: 6.0, remainingLeaveCount: 6.0);

  List<LeaveApplication> leaveApplications = [LeaveApplication(employee: employee, leave: leave,leaveCounts: leaveCounts)];

  setUpAll((){
    userLeaveService = MockUserLeaveService();
    stackManager = MockNavigationStackManager();
    employeeService = MockEmployeeService();
    paidLeaveService = MockPaidLeaveService();
    userLeaveCalendarViewBloc = UserLeaveCalendarViewBloc(userLeaveService, stackManager, employeeService,paidLeaveService);
  });


  group("User Leave Calendar Test", () {
    test("initial load data test", () {

      when(employeeService.getEmployee(userID)).thenAnswer((_) => Future(() => employee));
      when(userLeaveService.getAllLeavesOfUser(userID)).thenAnswer((_) => Future(() => [leave]));
      when(userLeaveService.getUserUsedLeaveCount(userID)).thenAnswer((_) => Future(() => 6.0));
      when(paidLeaveService.getPaidLeaves()).thenAnswer((_) => Future(() => 12));

      userLeaveCalendarViewBloc.add(UserLeaveCalendarInitialLoadEvent(userID));
      expect(userLeaveCalendarViewBloc.stream, emitsInOrder([
        UserLeaveCalendarViewLoadingState(),
        UserLeaveCalendarViewSuccessState(leaveApplication: leaveApplications,allLeaves: leaveApplications)
      ]));
    });

    test("get leave by select date range test", () {
      userLeaveCalendarViewBloc.add(DateRangeSelectedEvent(DateTime.now(), DateTime.now().add(const Duration(days: 1)), DateTime.now()));
      expect(userLeaveCalendarViewBloc.stream, emits(
        UserLeaveCalendarViewSuccessState(leaveApplication: const [],allLeaves: leaveApplications)
      ));
    });
  });

  group("navigation test", () {
    test('Navigate to leave detail view test ', () async {
      NavStackItem state = NavStackItem.employeeLeaveDetailState(leaveApplications.first);
      userLeaveCalendarViewBloc.add(LeaveTypeCardTapEvent(leaveApplications.first));
      await untilCalled(stackManager.push(state));
      verify(stackManager.push(state)).called(1);
    });
  });


}

