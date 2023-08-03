import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/repo/leave_repo.dart';
import 'package:projectunity/data/repo/employee_repo.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/extensions/list.dart';
import 'package:projectunity/data/core/extensions/stream_extension.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/pagination/pagination.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leave_event.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_bloc.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_state.dart';
import 'admin_leaves_test.mocks.dart';

@GenerateMocks([EmployeeRepo, LeaveRepo, DocumentSnapshot])
void main() {
  late EmployeeRepo employeeRepo;
  late LeaveRepo leaveRepo;
  late AdminLeavesBloc bloc;
  late DocumentSnapshot<Leave> lastDoc;

  group('Admin Leaves Test', () {
    Leave andrewCurrentYearLeave = Leave(
        leaveId: 'leave-id',
        uid: 'andrew-id',
        type: LeaveType.annualLeave,
        startDate: DateTime.now().dateOnly,
        endDate: DateTime.now().dateOnly.add(const Duration(days: 1)),
        total: 2,
        reason: 'reason',
        status: LeaveStatus.approved,
        appliedOn: DateTime.now().dateOnly,
        perDayDuration: const [
          LeaveDayDuration.noLeave,
          LeaveDayDuration.firstHalfLeave
        ]);
    Leave joiCurrentYearLeave = Leave(
        leaveId: 'leave-id',
        uid: 'joi-id',
        type: LeaveType.sickLeave,
        startDate: DateTime.now().dateOnly,
        endDate: DateTime.now().dateOnly.add(const Duration(days: 1)),
        total: 2,
        reason: 'reason',
        status: LeaveStatus.approved,
        appliedOn: DateTime.now().dateOnly,
        perDayDuration: const [
          LeaveDayDuration.noLeave,
          LeaveDayDuration.firstHalfLeave
        ]);
    Leave joiPreviousYearLeave = Leave(
        leaveId: 'leave-id',
        uid: 'joi-id',
        type: LeaveType.annualLeave,
        startDate: DateTime.now().dateOnly.subtract(const Duration(days: 365)),
        endDate: DateTime.now().dateOnly.subtract(const Duration(days: 364)),
        total: 2,
        reason: 'reason',
        status: LeaveStatus.approved,
        appliedOn: DateTime.now().dateOnly,
        perDayDuration: const [
          LeaveDayDuration.noLeave,
          LeaveDayDuration.firstHalfLeave
        ]);
    final andrew = Employee(
      uid: 'andrew-id',
      role: Role.employee,
      name: 'Andrew jhone',
      employeeId: '100',
      email: 'andrew.j@canopas.com',
      designation: 'Android developer',
      dateOfJoining: DateTime(2000),
    );
    final joi = Employee(
      uid: 'joi-id',
      role: Role.employee,
      name: 'joi jhone',
      employeeId: '100',
      email: 'joi.j@canopas.com',
      designation: 'Android developer',
      dateOfJoining: DateTime(2000),
    );

    group('Admin Leaves fetch data test', () {
      setUp(() {
        leaveRepo = MockLeaveRepo();
        employeeRepo = MockEmployeeRepo();
        lastDoc = MockDocumentSnapshot();
        bloc = AdminLeavesBloc(leaveRepo, employeeRepo);
      });

      test('Initial value test', () {
        expect(
            bloc.state,
            AdminLeavesState(
              showPaginationLoading: false,
              membersFetchStatus: Status.initial,
              selectedMember: null,
              leaveApplicationMap: const {},
              selectedYear: DateTime.now().year,
              leavesFetchStatus: Status.initial,
              members: const [],
              error: null,
            ));
      });

      test('Admin leave initial data load test', () {
        when(employeeRepo.allEmployees).thenReturn([joi, andrew]);
        when(leaveRepo.leaves())
            .thenAnswer((_) async => PaginatedLeaves(leaves: [
                  joiCurrentYearLeave,
                  andrewCurrentYearLeave,
                  joiPreviousYearLeave,
                  andrewCurrentYearLeave
                ], lastDoc: lastDoc));
        bloc.add(InitialAdminLeavesEvent());
        expect(
            bloc.stream,
            emitsInOrder([
              AdminLeavesState(
                members: [joi, andrew],
                membersFetchStatus: Status.success,
              ),
              AdminLeavesState(
                members: [joi, andrew],
                membersFetchStatus: Status.success,
                leavesFetchStatus: Status.loading,
              ),
              AdminLeavesState(
                  members: [joi, andrew],
                  membersFetchStatus: Status.success,
                  leavesFetchStatus: Status.success,
                  leaveApplicationMap:
                      getLeaveApplicationFromLeaveEmployee(leaves: [
                    joiCurrentYearLeave,
                    andrewCurrentYearLeave,
                    joiPreviousYearLeave,
                    andrewCurrentYearLeave
                  ], members: [
                    joi,
                    andrew
                  ]).groupByAppliedOnMonth()),
            ]));
      });
    });
  });
}
