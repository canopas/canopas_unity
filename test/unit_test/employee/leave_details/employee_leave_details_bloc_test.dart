import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/model/leave_count.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/admin/paid_leave/paid_leave_service.dart';
import 'package:projectunity/services/admin/requests/admin_leave_service.dart';
import 'package:projectunity/services/leave/user_leave_service.dart';
import 'package:projectunity/ui/user/leave_details/bloc/leave_details_bloc/employee_leave_details_bloc.dart';
import 'package:projectunity/ui/user/leave_details/bloc/leave_details_bloc/leave_details_event.dart';
import 'package:projectunity/ui/user/leave_details/bloc/leave_details_bloc/leave_details_state.dart';
import 'employee_leave_details_bloc_test.mocks.dart';

@GenerateMocks([UserLeaveService,AdminLeaveService,UserManager,PaidLeaveService])
void main(){
  late UserLeaveService userLeaveService;
  late UserManager userManager;
  late EmployeeLeaveDetailsBloc employeeLeaveDetailsBloc;
  late PaidLeaveService paidLeaveService;
  late EmployeeLeaveDetailsState loadingState;
  Leave leave = const Leave(
      leaveId: 'leave-id',
      uid: 'id',
      leaveType: 2,
      startDate: 500,
      endDate: 600,
      totalLeaves: 2,
      reason: 'reason',
      leaveStatus: 2,
      appliedOn: 400,
      perDayDuration: [0, 1]);

  LeaveCounts leaveCounts = const LeaveCounts(paidLeaveCount: 12,remainingLeaveCount: 7.0,usedLeaveCount: 5.0);
  
 

  Employee employee = const Employee(
      id: 'id',
      roleType: 1,
      name: 'Andrew jhone',
      employeeId: '100',
      email: 'andrew.j@canopas.com',
      designation: 'Android developer');

  

  group("Leave Details Screen Test", () {

    setUp((){
      userLeaveService = MockUserLeaveService();
      userManager = MockUserManager();
      paidLeaveService = MockPaidLeaveService();
      employeeLeaveDetailsBloc = EmployeeLeaveDetailsBloc(userLeaveService, paidLeaveService, userManager);
      loadingState = const EmployeeLeaveDetailsState(leaveDetailsLeaveCountStatus: EmployeeLeaveDetailsLeaveCountStatus.loading);
      when(userManager.employeeId).thenReturn("id");
      when(userManager.isAdmin).thenReturn(false);
    });

    test("fetch leave count test", (){
      when(paidLeaveService.getPaidLeaves()).thenAnswer((_) => Future(() => 12));
      when(userLeaveService.getUserUsedLeaveCount("id")).thenAnswer((_) => Future(() => 6.0));
      LeaveApplication leaveApplication = LeaveApplication(employee: employee, leave: leave);
      employeeLeaveDetailsBloc.add(EmployeeLeaveDetailsInitialLoadEvents(leaveApplication: leaveApplication));
      expect(employeeLeaveDetailsBloc.stream, emitsInOrder([
       loadingState,
       const EmployeeLeaveDetailsState(leaveDetailsLeaveCountStatus: EmployeeLeaveDetailsLeaveCountStatus.success,paidLeaveCount: 12,remainingLeaveCount: 6.0),
      ]));
    });

    test("not fetch leave count when leave application hase leave count test", (){
      LeaveApplication leaveApplication = LeaveApplication(employee: employee, leave: leave,leaveCounts: leaveCounts );
      employeeLeaveDetailsBloc.add(EmployeeLeaveDetailsInitialLoadEvents(leaveApplication: leaveApplication));
      expect(employeeLeaveDetailsBloc.stream, emitsInOrder([
        loadingState,
        const EmployeeLeaveDetailsState(leaveDetailsLeaveCountStatus: EmployeeLeaveDetailsLeaveCountStatus.success,paidLeaveCount: 12,remainingLeaveCount: 7.0),
      ]));
    });


    test("get data from user manager test", (){
      expect(employeeLeaveDetailsBloc.currentUserId,"id");
    });


    test("remove leave application test", (){
      when(userLeaveService.deleteLeaveRequest(leave.leaveId)).thenAnswer((realInvocation) => Future(() => null));
      LeaveApplication leaveApplication = LeaveApplication(employee: employee, leave: leave,leaveCounts: leaveCounts );
      employeeLeaveDetailsBloc.add(EmployeeLeaveDetailsRemoveLeaveRequestEvent(leaveApplication));
      expect(employeeLeaveDetailsBloc.stream, emitsInOrder([
        const EmployeeLeaveDetailsState(leaveDetailsStatus: EmployeeLeaveDetailsStatus.loading),
        const EmployeeLeaveDetailsState(leaveDetailsStatus: EmployeeLeaveDetailsStatus.success),
      ]));
    });


  });


}