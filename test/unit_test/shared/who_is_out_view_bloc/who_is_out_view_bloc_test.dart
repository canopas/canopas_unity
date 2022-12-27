import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/admin/employee/employee_service.dart';
import 'package:projectunity/services/admin/requests/admin_leave_service.dart';
import 'package:projectunity/ui/shared/who_is_out_calendar/bloc/who_is_out_view_bloc/who_is_out_view_bloc.dart';
import 'package:projectunity/ui/shared/who_is_out_calendar/bloc/who_is_out_view_bloc/who_is_out_view_event.dart';
import 'package:projectunity/ui/shared/who_is_out_calendar/bloc/who_is_out_view_bloc/who_is_out_view_state.dart';

import 'who_is_out_view_bloc_test.mocks.dart';

@GenerateMocks([EmployeeService,AdminLeaveService,UserManager])
void main(){

  late EmployeeService employeeService;
  late AdminLeaveService adminLeaveService;
  late UserManager userManager;
  late WhoIsOutViewBloc whoIsOutViewBloc;

  const employee = Employee(
    id: "123",
    roleType: 2,
    name: "test",
    employeeId: "103",
    email: "abc@gmail.com",
    designation: "tester",
  );

  final currentTime = DateTime.now().timeStampToInt;
  final leave = Leave(
      leaveId: "234",
      uid: "123",
      leaveType: 1,
      startDate: currentTime,
      endDate: currentTime,
      totalLeaves: 1.0,
      reason: 'leave reason',
      leaveStatus: 1,
      appliedOn: currentTime,
      perDayDuration: const [1]);

  List<LeaveApplication> leaveApplications = [LeaveApplication(employee: employee, leave: leave)];

  setUpAll((){
       employeeService = MockEmployeeService();
       adminLeaveService = MockAdminLeaveService();
       userManager = MockUserManager();
       whoIsOutViewBloc = WhoIsOutViewBloc(employeeService, adminLeaveService,userManager);
  });

  group("who is out view test", () {
    test("who is out view initial load test", () {
      when(employeeService.getEmployees()).thenAnswer((_) => Future(() => [employee]));
      when(adminLeaveService.getAllLeaves()).thenAnswer((_) => Future(() => [leave]));
      whoIsOutViewBloc.add(WhoIsOutViewInitialLoadEvent());
      expect(whoIsOutViewBloc.stream, emitsInOrder([
        WhoISOutViewLoadingState(),
        WhoIsOutViewSuccessState(leaveApplications: leaveApplications)
      ]));
    });

    test("who is out view date select test", () {
      whoIsOutViewBloc.add(GetSelectedDateLeavesEvent(currentTime.toDate.add(const Duration(days: 5))));
      whoIsOutViewBloc.add(GetSelectedDateLeavesEvent(currentTime.toDate));
      expect(whoIsOutViewBloc.stream, emitsInOrder([
          WhoIsOutViewSuccessState(leaveApplications: const []),
          WhoIsOutViewSuccessState(leaveApplications: leaveApplications),
      ]));
    });
  });

}

