import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/model/leave_count.dart';
import 'package:projectunity/services/admin/employee_service.dart';
import 'package:projectunity/services/admin/paid_leave_service.dart';
import 'package:projectunity/services/user/user_leave_service.dart';
import 'package:projectunity/ui/user/user_leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_bloc.dart';
import 'package:projectunity/ui/user/user_leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_events.dart';
import 'package:projectunity/ui/user/user_leave_calendar/bloc/user_leave_calendar_view_bloc/user_leave_calendar_states.dart';
import 'user_leave_calendar_test.mocks.dart';
@GenerateMocks([UserLeaveService,EmployeeService,PaidLeaveService])
void main(){

  late UserLeaveService userLeaveService;
  late EmployeeService employeeService;
  late PaidLeaveService paidLeaveService;
  late UserLeaveCalendarBloc userLeaveCalendarViewBloc;

  String userID = "123";

  const employee = Employee(
    id: "123",
    roleType: 2,
    name: "test",
    employeeId: "103",
    email: "abc@gmail.com",
    designation: "tester",
  );

   Leave leave = Leave(
      leaveId: "234",
      uid: "123",
      leaveType: 1,
      startDate: DateTime.now().dateOnly.timeStampToInt,
      endDate: DateTime.now().dateOnly.timeStampToInt,
      totalLeaves: 1.0,
      reason: 'leave reason',
      leaveStatus: 1,
      appliedOn: 1000,
      perDayDuration: const [1]);

  const leaveCounts = LeaveCounts(paidLeaveCount: 12, usedLeaveCount: 6.0, remainingLeaveCount: 6.0);

  List<LeaveApplication> leaveApplications = [LeaveApplication(employee: employee, leave: leave,leaveCounts: leaveCounts)];


  group("User Leave Calendar Test", () {

    setUp((){
      userLeaveService = MockUserLeaveService();
      employeeService = MockEmployeeService();
      paidLeaveService = MockPaidLeaveService();
      userLeaveCalendarViewBloc = UserLeaveCalendarBloc(userLeaveService, employeeService,paidLeaveService);
      when(employeeService.getEmployee(userID)).thenAnswer((_) => Future(() => employee));
      when(userLeaveService.getAllLeavesOfUser(userID)).thenAnswer((_) => Future(() => [leave]));
      when(userLeaveService.getUserUsedLeaveCount(userID)).thenAnswer((_) => Future(() => 6.0));
      when(paidLeaveService.getPaidLeaves()).thenAnswer((_) => Future(() => 12));
    });

    test("initial load data test", () {
      userLeaveCalendarViewBloc.add(UserLeaveCalendarInitialLoadEvent(userID));
      expect(userLeaveCalendarViewBloc.stream, emitsInOrder([
        UserLeaveCalendarViewLoadingState(),
        UserLeaveCalendarViewSuccessState(leaveApplications: leaveApplications,allLeaveApplications: leaveApplications)
      ]));
    });

    test("get leave by select date range test when there leave of that date.", () {
      userLeaveCalendarViewBloc.emit(UserLeaveCalendarViewSuccessState(leaveApplications: const [],allLeaveApplications: leaveApplications));
      userLeaveCalendarViewBloc.add(DateRangeSelectedEvent(DateTime.now().dateOnly, DateTime.now().add(const Duration(days: 1)).dateOnly, DateTime.now().dateOnly));
      expect(userLeaveCalendarViewBloc.stream, emits(
        UserLeaveCalendarViewSuccessState(leaveApplications: leaveApplications,allLeaveApplications: leaveApplications)
      ));
    });

    test("get leave by select date range test when there no leave of that date.", () {
      userLeaveCalendarViewBloc.emit(UserLeaveCalendarViewSuccessState(leaveApplications: leaveApplications,allLeaveApplications: leaveApplications));
      userLeaveCalendarViewBloc.add(DateRangeSelectedEvent(DateTime(2000).dateOnly, DateTime(2000).dateOnly, DateTime(2000).dateOnly));
      expect(userLeaveCalendarViewBloc.stream, emits(
          UserLeaveCalendarViewSuccessState(leaveApplications: const [],allLeaveApplications: leaveApplications)
      ));
    });

    test("remove leave application test", (){
      userLeaveCalendarViewBloc.emit(UserLeaveCalendarViewSuccessState(leaveApplications: leaveApplications,allLeaveApplications: leaveApplications));
      userLeaveCalendarViewBloc.add(RemoveOrCancelLeaveApplication(leaveApplications.first));
      expect(userLeaveCalendarViewBloc.stream, emits(
          UserLeaveCalendarViewSuccessState(leaveApplications: const [],allLeaveApplications: const []),
      ));
    });

  });




}

