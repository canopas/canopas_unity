import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/services/admin/employee_service.dart';
import 'package:projectunity/services/admin/leave_service.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leave_event.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_bloc.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_state.dart';

import 'admin_leaves_test.mocks.dart';

@GenerateMocks([EmployeeService, AdminLeaveService])
void main() {
  late AdminLeaveService adminLeaveService;
  late EmployeeService employeeService;
  late AdminLeavesBloc bloc;
  group('Admin Leaves Test', () {
    setUp(() {
      adminLeaveService = MockAdminLeaveService();
      employeeService = MockEmployeeService();
      bloc = AdminLeavesBloc(adminLeaveService, employeeService);
    });
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

    Employee employee = const Employee(
        id: 'id',
        roleType: 1,
        name: 'Andrew jhone',
        employeeId: '100',
        email: 'andrew.j@canopas.com',
        designation: 'Android developer');

    test('successfully fetch initial data test', () {
      bloc.add(AdminLeavesInitialLoadEvent());
      when(adminLeaveService.getRecentLeaves())
          .thenAnswer((_) async => [leave, leave]);
      when(adminLeaveService.getUpcomingLeaves())
          .thenAnswer((_) async => [leave]);
      when(employeeService.getEmployees()).thenAnswer((_) async => [employee]);
      expect(
          bloc.stream,
          emitsInOrder([
            const AdminLeavesState(status: AdminLeavesStatus.loading),
            AdminLeavesState(status: AdminLeavesStatus.success, recentLeaves: [
              LeaveApplication(employee: employee, leave: leave),
              LeaveApplication(employee: employee, leave: leave)
            ], upcomingLeaves: [
              LeaveApplication(employee: employee, leave: leave)
            ]),
          ]));
    });

    test('fail initial data fetch test', () {
      bloc.add(AdminLeavesInitialLoadEvent());
      when(adminLeaveService.getRecentLeaves()).thenThrow(Exception("error"));
      when(adminLeaveService.getUpcomingLeaves())
          .thenAnswer((_) async => [leave]);
      when(employeeService.getEmployees()).thenAnswer((_) async => [employee]);
      expect(
          bloc.stream,
          emitsInOrder([
            const AdminLeavesState(status: AdminLeavesStatus.loading),
            const AdminLeavesState(
                status: AdminLeavesStatus.failure,
                error: firestoreFetchDataError),
          ]));
    });
  });
}
