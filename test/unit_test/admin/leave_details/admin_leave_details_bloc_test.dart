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
import 'package:projectunity/services/admin/paid_leave/paid_leave_service.dart';
import 'package:projectunity/services/admin/requests/admin_leave_service.dart';
import 'package:projectunity/services/leave/user_leave_service.dart';
import 'package:projectunity/ui/admin/leave_details/bloc/admin_leave_details_bloc.dart';
import 'package:projectunity/ui/admin/leave_details/bloc/admin_leave_details_event.dart';
import 'package:projectunity/ui/admin/leave_details/bloc/admin_leave_details_state.dart';

import 'admin_leave_details_bloc_test.mocks.dart';

@GenerateMocks([UserLeaveService,NavigationStackManager,AdminLeaveService,UserManager,PaidLeaveService])
void main(){
  late UserLeaveService userLeaveService;
  late NavigationStackManager stackManager;
  late AdminLeaveService adminLeaveService;
  late AdminLeaveDetailsBloc adminLeaveDetailsBloc;
  late PaidLeaveService paidLeaveService;
  late AdminLeaveDetailsState loadingState;
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

  setUp((){
    userLeaveService = MockUserLeaveService();
    stackManager = MockNavigationStackManager();
    adminLeaveService = MockAdminLeaveService();
    paidLeaveService = MockPaidLeaveService();
    adminLeaveDetailsBloc = AdminLeaveDetailsBloc(userLeaveService, stackManager, adminLeaveService, paidLeaveService);
    loadingState = const AdminLeaveDetailsState(leaveDetailsLeaveCountStatus: AdminLeaveDetailsLeaveCountStatus.loading);
  });

  group("Leave Details Screen Test", () {

    test("fetch leave count test", (){
      when(paidLeaveService.getPaidLeaves()).thenAnswer((_) => Future(() => 12));
      when(userLeaveService.getUserUsedLeaveCount("id")).thenAnswer((_) => Future(() => 6.0));
      LeaveApplication leaveApplication = LeaveApplication(employee: employee, leave: leave);
      adminLeaveDetailsBloc.add(AdminLeaveDetailsInitialLoadEvents(leaveApplication: leaveApplication));
      expect(adminLeaveDetailsBloc.stream, emitsInOrder([
        loadingState,
        const AdminLeaveDetailsState(leaveDetailsLeaveCountStatus: AdminLeaveDetailsLeaveCountStatus.success,remainingLeaveCount: 6.0,paidLeaveCount: 12),
      ]));
    });

    test("not fetch leave count when leave application hase leave count test", (){
      LeaveApplication leaveApplication = LeaveApplication(employee: employee, leave: leave,leaveCounts: leaveCounts );
      adminLeaveDetailsBloc.add(AdminLeaveDetailsInitialLoadEvents(leaveApplication: leaveApplication));
      expect(adminLeaveDetailsBloc.stream, emitsInOrder([
        loadingState,
        const AdminLeaveDetailsState(leaveDetailsLeaveCountStatus: AdminLeaveDetailsLeaveCountStatus.success,remainingLeaveCount: 7.0,paidLeaveCount: 12),
      ]));
    });

    test("approve leave application test", (){
      when(adminLeaveService.updateLeaveStatus("leave-id", {
        'leave_status': approveLeaveStatus,
        'rejection_reason': "reason",
      })).thenAnswer((realInvocation) => Future(() => null));
      adminLeaveDetailsBloc.add(AdminLeaveDetailsApproveRequestEvent(leaveId: "leave-id"));
      expect(adminLeaveDetailsBloc.stream, emitsInOrder([
        const AdminLeaveDetailsState(leaveDetailsStatus: AdminLeaveDetailsStatus.approveLoading),
        const AdminLeaveDetailsState(leaveDetailsStatus: AdminLeaveDetailsStatus.success),
      ]));
    });


    test("reject leave application test", (){
      when(adminLeaveService.updateLeaveStatus("leave-id", {
        'leave_status': rejectLeaveStatus,
        'rejection_reason': "reason",
      })).thenAnswer((realInvocation) => Future(() => null));
      adminLeaveDetailsBloc.add(AdminLeaveDetailsRejectRequestEvent(leaveId: "leave-id"));
      expect(adminLeaveDetailsBloc.stream, emitsInOrder([
        const AdminLeaveDetailsState(leaveDetailsStatus: AdminLeaveDetailsStatus.rejectLoading),
        const AdminLeaveDetailsState(leaveDetailsStatus: AdminLeaveDetailsStatus.success),
      ]));
    });

    test("Navigation test to user details screen", () async {
      const state = NavStackItem.employeeDetailState(id: "id");
      adminLeaveDetailsBloc.add(AdminLeaveDetailsOnUserContentTapEvent("id"));
      await untilCalled(stackManager.push(state));
      verify(stackManager.push(state)).called(1);
    });

  });


}