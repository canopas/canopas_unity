import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/model/leave_application.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:projectunity/ui/shared/employees_calendar/bloc/calendar_leaves_bloc/employees_calendar_leaves_bloc.dart';
import 'package:projectunity/ui/shared/employees_calendar/bloc/calendar_leaves_bloc/employees_calendar_leaves_state.dart';
import 'package:projectunity/ui/shared/employees_calendar/bloc/calendar_leaves_bloc/employees_calender_leaves_event.dart';

import 'employees_leave_calendar_bloc_test.mocks.dart';

@GenerateMocks([EmployeeService, LeaveService, UserManager])
void main() {
  late EmployeeService employeeService;
  late LeaveService leaveService;
  late UserManager userManager;
  late EmployeesCalendarLeavesBloc whoIsOutViewBloc;

  const employee = Employee(
    uid: "123",
    role: Role.employee,
    name: "test",
    employeeId: "103",
    email: "abc@gmail.com",
    designation: "tester",
    dateOfJoining: 11,
  );

  final currentTime = DateTime.now().timeStampToInt;
  final leave = Leave(
      leaveId: "234",
      uid: "123",
      type: 1,
      startDate: currentTime,
      endDate: currentTime,
      total: 1.0,
      reason: 'leave reason',
      status: 1,
      appliedOn: currentTime,
      perDayDuration: const [LeaveDayDuration.firstHalfLeave]);

  List<LeaveApplication> leaveApplications = [
    LeaveApplication(employee: employee, leave: leave)
  ];

  setUpAll(() {
    employeeService = MockEmployeeService();
    leaveService = MockLeaveService();
    userManager = MockUserManager();
    whoIsOutViewBloc =
        EmployeesCalendarLeavesBloc(employeeService, leaveService, userManager);
  });

  group("who is out view test", () {
    test("who is out view initial load test", () {
      when(employeeService.getEmployees())
          .thenAnswer((_) => Future(() => [employee]));
      when(leaveService.getAllLeaves())
          .thenAnswer((_) => Future(() => [leave]));
      whoIsOutViewBloc.add(EmployeeCalenadarLeavesInitialLoadEvent());
      expect(
          whoIsOutViewBloc.stream,
          emitsInOrder([
            EmployeesCalendarLeavesLoadingState(),
            EmployeesCalendarLeavesSuccessState(
                leaveApplications: leaveApplications)
          ]));
    });

    test("who is out view date select test", () {
      whoIsOutViewBloc.add(GetSelectedDateLeavesEvent(
          currentTime.toDate.add(const Duration(days: 5))));
      whoIsOutViewBloc.add(GetSelectedDateLeavesEvent(currentTime.toDate));
      expect(
          whoIsOutViewBloc.stream,
          emitsInOrder([
            EmployeesCalendarLeavesSuccessState(leaveApplications: const []),
            EmployeesCalendarLeavesSuccessState(
                leaveApplications: leaveApplications),
          ]));
    });
  });
}
