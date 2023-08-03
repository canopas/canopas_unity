import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/repo/leave_repo.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/ui/admin/members/details_leaves/bloc/admin_employee_details_leave_bloc.dart';
import 'package:projectunity/ui/admin/members/details_leaves/bloc/admin_employee_details_leave_events.dart';
import 'package:projectunity/ui/admin/members/details_leaves/bloc/admin_employee_details_leave_state.dart';

import 'admin_employee_details_leaves_test.mocks.dart';

@GenerateMocks([LeaveRepo])
void main() {
  late LeaveRepo leaveRepo;
  late AdminEmployeeDetailsLeavesBLoc bloc;
  Leave leave = Leave(
      leaveId: 'leave-id',
      uid: 'id',
      type: LeaveType.annualLeave,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      total: 2,
      reason: 'reason',
      status: LeaveStatus.approved,
      appliedOn: DateTime.now(),
      perDayDuration: const [
        LeaveDayDuration.noLeave,
        LeaveDayDuration.firstHalfLeave
      ]);

  setUp(() {
    leaveRepo = MockLeaveRepo();
    bloc = AdminEmployeeDetailsLeavesBLoc(leaveRepo);
  });

  tearDown(() {
    bloc.close();
  });

  group('Admin Employee Details Leaves Test', () {
    test('data fetch success on init test', () {
      when(leaveRepo.userLeavesByYear(leave.uid, DateTime.now().year))
          .thenAnswer((_) => Stream.value([leave]));

      bloc.add(InitEvents(employeeId: leave.uid));
      expect(
          bloc.stream,
          emitsInOrder([
            const AdminEmployeeDetailsLeavesState(status: Status.loading),
            AdminEmployeeDetailsLeavesState(
                status: Status.success, leaves: [leave]),
          ]));
    });

    test('data fetch failure by stream error', () {
      when(leaveRepo.userLeavesByYear(leave.uid, DateTime.now().year))
          .thenAnswer((_) => Stream.error(firestoreFetchDataError));
      bloc.add(InitEvents(employeeId: leave.uid));
      expect(
          bloc.stream,
          emitsInOrder(const [
            AdminEmployeeDetailsLeavesState(status: Status.loading),
            AdminEmployeeDetailsLeavesState(
                status: Status.error, error: firestoreFetchDataError)
          ]));
    });

    test('data fetch failure by exception', () {
      when(leaveRepo.userLeavesByYear(leave.uid, DateTime.now().year))
          .thenThrow(Exception('error'));
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
