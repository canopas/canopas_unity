import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/services/user/user_leave_service.dart';
import 'package:projectunity/ui/admin/employee/details_leaves/bloc/admin_employee_details_leave_bloc.dart';
import 'package:projectunity/ui/admin/employee/details_leaves/bloc/admin_employee_details_leave_events.dart';
import 'package:projectunity/ui/admin/employee/details_leaves/bloc/admin_employee_details_leave_state.dart';
import 'admin_employee_details_leaves_test.mocks.dart';

@GenerateMocks([UserLeaveService])
void main(){
  late UserLeaveService userLeaveService;
  late AdminEmployeeDetailsLeavesBLoc bloc;
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

  setUp(() {
    userLeaveService = MockUserLeaveService();
     bloc = AdminEmployeeDetailsLeavesBLoc(userLeaveService);
  });

  group('Admin Employee Details Leaves Test', () {
    test('data fetch success on init test', () {
      when(userLeaveService.getUpcomingLeaves("id")).thenAnswer((_) async => [leave]);
      when(userLeaveService.getPastLeavesOfUser("id")).thenAnswer((_) async => [leave,leave]);
      when(userLeaveService.getRecentLeavesOfUser("id")).thenAnswer((_) async => [leave]);
      bloc.add(AdminEmployeeDetailsLeavesInitEvent(employeeId: "id"));
      expect(bloc.stream, emitsInOrder([
        const AdminEmployeeDetailsLeavesState(loading: true),
        AdminEmployeeDetailsLeavesState(loading: false,
        recentLeaves: [leave],
        upcomingLeaves: [leave],
        pastLeaves: [leave,leave]),
      ]));
    });

    test('data fetch failure on init test', () {
      when(userLeaveService.getUpcomingLeaves("id")).thenAnswer((_) async => [leave]);
      when(userLeaveService.getPastLeavesOfUser("id")).thenThrow(Exception(firestoreFetchDataError));
      when(userLeaveService.getRecentLeavesOfUser("id")).thenAnswer((_) async => [leave]);
      bloc.add(AdminEmployeeDetailsLeavesInitEvent(employeeId: "id"));
      expect(bloc.stream, emitsInOrder(const [
        AdminEmployeeDetailsLeavesState(loading: true),
        AdminEmployeeDetailsLeavesState(loading: false,
            error: firestoreFetchDataError)
      ]));
    });
  });
}