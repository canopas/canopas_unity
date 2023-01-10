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
import 'package:projectunity/ui/admin/leave_request_details/bloc/admin_leave_details_bloc.dart';
import 'package:projectunity/ui/admin/leave_request_details/bloc/admin_leave_details_event.dart';
import 'package:projectunity/ui/admin/leave_request_details/bloc/admin_leave_details_state.dart';

import 'admin_leave_request_details_bloc_test.mocks.dart';

@GenerateMocks([UserLeaveService,AdminLeaveService,UserManager,PaidLeaveService])
void main(){
  late UserLeaveService userLeaveService;
  late AdminLeaveService adminLeaveService;
  late AdminLeaveApplicationDetailsBloc adminLeaveRequestDetailsBloc;
  late PaidLeaveService paidLeaveService;
  late AdminLeaveApplicationDetailsState loadingState;
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
    adminLeaveService = MockAdminLeaveService();
    paidLeaveService = MockPaidLeaveService();
    adminLeaveRequestDetailsBloc = AdminLeaveApplicationDetailsBloc(userLeaveService, adminLeaveService, paidLeaveService);
    loadingState = const AdminLeaveApplicationDetailsState(leaveDetailsLeaveCountStatus: AdminLeaveApplicationDetailsLeaveCountStatus.loading);
  });

  group("Leave Details Screen Test", () {

    test("fetch leave count test", (){
      when(paidLeaveService.getPaidLeaves()).thenAnswer((_) => Future(() => 12));
      when(userLeaveService.getUserUsedLeaveCount("id")).thenAnswer((_) => Future(() => 6.0));
      LeaveApplication leaveApplication = LeaveApplication(employee: employee, leave: leave);
      adminLeaveRequestDetailsBloc.add(AdminLeaveRequestDetailsInitialLoadEvents(leaveApplication: leaveApplication));
      expect(adminLeaveRequestDetailsBloc.stream, emitsInOrder([
        loadingState,
        const AdminLeaveApplicationDetailsState(leaveDetailsLeaveCountStatus: AdminLeaveApplicationDetailsLeaveCountStatus.success,remainingLeaveCount: 6.0,paidLeaveCount: 12),
      ]));
    });

    test("not fetch leave count when leave application hase leave count test", (){
      LeaveApplication leaveApplication = LeaveApplication(employee: employee, leave: leave,leaveCounts: leaveCounts );
      adminLeaveRequestDetailsBloc.add(AdminLeaveRequestDetailsInitialLoadEvents(leaveApplication: leaveApplication));
      expect(adminLeaveRequestDetailsBloc.stream, emitsInOrder([
        loadingState,
        const AdminLeaveApplicationDetailsState(leaveDetailsLeaveCountStatus: AdminLeaveApplicationDetailsLeaveCountStatus.success,remainingLeaveCount: 7.0,paidLeaveCount: 12),
      ]));
    });

    test("approve leave application test", (){
      when(adminLeaveService.updateLeaveStatus("leave-id", {
        'leave_status': approveLeaveStatus,
        'rejection_reason': "reason",
      })).thenAnswer((realInvocation) => Future(() => null));
      adminLeaveRequestDetailsBloc.add(AdminLeaveApplicationDetailsApproveRequestEvent(leaveId: "leave-id"));
      expect(adminLeaveRequestDetailsBloc.stream, emitsInOrder([
        const AdminLeaveApplicationDetailsState(leaveDetailsStatus: AdminLeaveApplicationDetailsStatus.approveLoading),
        const AdminLeaveApplicationDetailsState(leaveDetailsStatus: AdminLeaveApplicationDetailsStatus.success),
      ]));
    });


    test("reject leave application test", (){
      when(adminLeaveService.updateLeaveStatus("leave-id", {
        'leave_status': rejectLeaveStatus,
        'rejection_reason': "reason",
      })).thenAnswer((realInvocation) => Future(() => null));
      adminLeaveRequestDetailsBloc.add(AdminLeaveApplicationDetailsRejectRequestEvent(leaveId: "leave-id"));
      expect(adminLeaveRequestDetailsBloc.stream, emitsInOrder([
        const AdminLeaveApplicationDetailsState(leaveDetailsStatus: AdminLeaveApplicationDetailsStatus.rejectLoading),
        const AdminLeaveApplicationDetailsState(leaveDetailsStatus: AdminLeaveApplicationDetailsStatus.success),
      ]));
    });

  });


}