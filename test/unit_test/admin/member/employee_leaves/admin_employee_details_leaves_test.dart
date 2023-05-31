import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:projectunity/ui/admin/members/details_leaves/bloc/admin_employee_details_leave_bloc.dart';
import 'package:projectunity/ui/admin/members/details_leaves/bloc/admin_employee_details_leave_events.dart';
import 'package:projectunity/ui/admin/members/details_leaves/bloc/admin_employee_details_leave_state.dart';
import 'admin_employee_details_leaves_test.mocks.dart';

@GenerateMocks([LeaveService])
void main() {
  late LeaveService leaveService;
  late AdminEmployeeDetailsLeavesBLoc bloc;
  const leave = Leave(
      leaveId: 'leave-id',
      uid: 'id',
      type: 2,
      startDate: 500,
      endDate: 600,
      total: 2,
      reason: 'reason',
      status: LeaveStatus.approved,
      appliedOn: 400,
      perDayDuration: [
        LeaveDayDuration.noLeave,
        LeaveDayDuration.firstHalfLeave
      ]);

  setUp(() {
    leaveService = MockLeaveService();
    bloc = AdminEmployeeDetailsLeavesBLoc(leaveService);
  });

  tearDown(() {
    bloc.close();
  });

  group('Admin Employee Details Leaves Test', () {
    test('data fetch success on init test', () {
      when(leaveService.getAllLeavesOfUser(leave.uid))
          .thenAnswer((_) async => [leave]);

      bloc.add(InitEvents(employeeId: leave.uid));
      expect(
          bloc.stream,
          emitsInOrder(const [
            AdminEmployeeDetailsLeavesState(status: Status.loading),
            AdminEmployeeDetailsLeavesState(
                status: Status.success, leaves: [leave]),
          ]));
    });

    test('data fetch failure on init test', () {
      when(leaveService.getAllLeavesOfUser(leave.uid))
          .thenThrow(Exception(firestoreFetchDataError));
      bloc.add(InitEvents(employeeId: leave.uid));
      expect(
          bloc.stream,
          emitsInOrder(const [
            AdminEmployeeDetailsLeavesState(status: Status.loading),
            AdminEmployeeDetailsLeavesState(
                status: Status.error, error: firestoreFetchDataError)
          ]));
    });
  });
}
