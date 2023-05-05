import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/model/leave_application.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leave_event.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_bloc.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_state.dart';

import 'admin_leaves_test.mocks.dart';

@GenerateMocks([EmployeeService, LeaveService])
void main() {
  late LeaveService leaveService;
  late EmployeeService employeeService;
  late AdminLeavesBloc bloc;
  group('Admin Leaves Test', () {
    setUp(() {
      leaveService = MockLeaveService();
      employeeService = MockEmployeeService();
      bloc = AdminLeavesBloc(leaveService, employeeService);
    });
    Leave leave = const Leave(
        leaveId: 'leave-id',
        uid: 'id',
        type: 2,
        startDate: 500,
        endDate: 600,
        total: 2,
        reason: 'reason',
        status: 2,
        appliedOn: 400,
        perDayDuration: [LeaveDayDuration.noLeave, LeaveDayDuration.firstHalfLeave]);

    Employee employee = const Employee(
        uid: 'id',
        role: Role.admin,
        name: 'Andrew jhone',
        employeeId: '100',
        email: 'andrew.j@canopas.com',
        designation: 'Android developer');

    test('successfully fetch initial data test', () {
      bloc.add(AdminLeavesInitialLoadEvent());
      when(leaveService.getRecentLeaves())
          .thenAnswer((_) async => [leave, leave]);
      when(leaveService.getUpcomingLeaves()).thenAnswer((_) async => [leave]);
      when(employeeService.getEmployees()).thenAnswer((_) async => [employee]);
      expect(
          bloc.stream,
          emitsInOrder([
            const AdminLeavesState(status: Status.loading),
            AdminLeavesState(status: Status.success, recentLeaves: [
              LeaveApplication(employee: employee, leave: leave),
              LeaveApplication(employee: employee, leave: leave)
            ], upcomingLeaves: [
              LeaveApplication(employee: employee, leave: leave)
            ]),
          ]));
    });

    test('fail initial data fetch test', () {
      bloc.add(AdminLeavesInitialLoadEvent());
      when(leaveService.getRecentLeaves()).thenThrow(Exception("error"));
      when(leaveService.getUpcomingLeaves()).thenAnswer((_) async => [leave]);
      when(employeeService.getEmployees()).thenAnswer((_) async => [employee]);
      expect(
          bloc.stream,
          emitsInOrder([
            const AdminLeavesState(status: Status.loading),
            const AdminLeavesState(
                status: Status.error, error: firestoreFetchDataError),
          ]));
    });
  });
}
