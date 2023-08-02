import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/Repo/employee_repo.dart';
import 'package:projectunity/data/Repo/leave_repo.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/model/leave_application.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leave_event.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_bloc.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/bloc%20/admin_leaves_state.dart';
import 'admin_leaves_test.mocks.dart';

@GenerateMocks([EmployeeRepo, LeaveRepo])
void main() {
  late EmployeeRepo employeeRepo;
  late LeaveRepo leaveRepo;
  late AdminLeavesBloc bloc;

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
        bloc = AdminLeavesBloc(leaveRepo, employeeRepo);
      });

      test('initial value test', () {
        expect(
            bloc.state,
            AdminLeavesState(
              selectedMember: null,
              leaveApplicationMap: const [],
              selectedYear: DateTime.now().year,
              leavesFetchStatus: Status.initial,
              members: const [],
              error: null,
            ));
      });

      test('Successfully read real-time changes', () {
        bloc.add(FetchMoreLeavesEvent());
        when(employeeRepo.employees)
            .thenAnswer((realInvocation) => Stream.value([andrew, joi]));
        when(leaveRepo.leaves).thenAnswer((realInvocation) => Stream.value([
              andrewCurrentYearLeave,
              joiCurrentYearLeave,
              joiPreviousYearLeave
            ]));

        expect(
            bloc.stream,
            emitsInOrder([
              AdminLeavesState(leavesFetchStatus: Status.loading),
              AdminLeavesState(leavesFetchStatus: Status.success, leaveApplicationMap: [
                LeaveApplication(
                    employee: andrew, leave: andrewCurrentYearLeave),
                LeaveApplication(employee: joi, leave: joiCurrentYearLeave)
              ], members: [
                andrew,
                joi
              ])
            ]));
      });

      test('Check leave not add on list when employee not found', () {
        when(employeeRepo.employees)
            .thenAnswer((realInvocation) => Stream.value([andrew]));
        when(leaveRepo.leaves).thenAnswer((realInvocation) => Stream.value([
              andrewCurrentYearLeave,
              joiCurrentYearLeave,
            ]));
        bloc.add(FetchMoreLeavesEvent());
        expectLater(
            bloc.stream,
            emitsInOrder([
              AdminLeavesState(leavesFetchStatus: Status.loading),
              AdminLeavesState(leavesFetchStatus: Status.success, leaveApplicationMap: [
                LeaveApplication(
                    employee: andrew, leave: andrewCurrentYearLeave),
              ], members: [
                andrew,
              ])
            ]));
      });

      test('show error on initial data failure test', () {
        bloc.add(FetchMoreLeavesEvent());
        when(employeeRepo.employees)
            .thenAnswer((realInvocation) => Stream.value([andrew]));
        when(leaveRepo.leaves).thenThrow(Exception('error'));
        expectLater(
            bloc.stream,
            emitsInOrder([
              AdminLeavesState(leavesFetchStatus: Status.loading),
              AdminLeavesState(
                  leavesFetchStatus: Status.error, error: firestoreFetchDataError),
            ]));
      });

      test('Show employee by search', () {
        bloc.add(FetchMoreLeavesEvent());
        when(employeeRepo.employees)
            .thenAnswer((realInvocation) => Stream.value([andrew, joi]));
        when(leaveRepo.leaves).thenAnswer((realInvocation) => Stream.value([
              andrewCurrentYearLeave,
              joiCurrentYearLeave,
              joiPreviousYearLeave
            ]));
        bloc.add(SearchEmployeeEvent(search: "joi"));
        expectLater(
            bloc.stream,
            emitsInOrder([
              AdminLeavesState(leavesFetchStatus: Status.loading),
              AdminLeavesState(leavesFetchStatus: Status.success, leaveApplicationMap: [
                LeaveApplication(
                    employee: andrew, leave: andrewCurrentYearLeave),
                LeaveApplication(employee: joi, leave: joiCurrentYearLeave)
              ], members: [
                andrew,
                joi
              ]),
              AdminLeavesState(leavesFetchStatus: Status.success, leaveApplicationMap: [
                LeaveApplication(
                    employee: andrew, leave: andrewCurrentYearLeave),
                LeaveApplication(employee: joi, leave: joiCurrentYearLeave)
              ], members: [
                joi
              ]),
            ]));
      });
    });
    group('Admin Leaves data filter test', () {
      setUpAll(() {
        leaveRepo = MockLeaveRepo();
        employeeRepo = MockEmployeeRepo();
        bloc = AdminLeavesBloc(leaveRepo, employeeRepo);
      });

      test('Successfully read real-time changes', () {
        bloc.add(FetchMoreLeavesEvent());
        when(employeeRepo.employees)
            .thenAnswer((realInvocation) => Stream.value([andrew, joi]));
        when(leaveRepo.leaves).thenAnswer((realInvocation) => Stream.value([
              andrewCurrentYearLeave,
              joiCurrentYearLeave,
              joiPreviousYearLeave
            ]));

        expect(
            bloc.stream,
            emitsInOrder([
              AdminLeavesState(leavesFetchStatus: Status.loading),
              AdminLeavesState(leavesFetchStatus: Status.success, leaveApplicationMap: [
                LeaveApplication(
                    employee: andrew, leave: andrewCurrentYearLeave),
                LeaveApplication(employee: joi, leave: joiCurrentYearLeave)
              ], members: [
                andrew,
                joi
              ])
            ]));
      });

      test('show particular employee leaves test', () async {
        bloc.add(FetchInitialMemberLeavesEvent(member: joi));
        expect(
            bloc.stream,
            emitsInOrder([
              AdminLeavesState(
                  selectedMember: joi,
                  selectedYear: DateTime.now().year,
                  leavesFetchStatus: Status.success,
                  leaveApplicationMap: [
                    LeaveApplication(employee: joi, leave: joiCurrentYearLeave)
                  ],
                  members: [
                    andrew,
                    joi
                  ])
            ]));
      });
      test('show particular employee leaves test', () async {
        bloc.add(ChangeEmployeeLeavesYearEvent(
            year: DateTime.now().subtract(const Duration(days: 365)).year));
        expect(
            bloc.stream,
            emitsInOrder([
              AdminLeavesState(
                  selectedMember: joi,
                  selectedYear:
                      DateTime.now().subtract(const Duration(days: 365)).year,
                  leavesFetchStatus: Status.success,
                  leaveApplicationMap: [
                    LeaveApplication(employee: joi, leave: joiPreviousYearLeave)
                  ],
                  members: [
                    andrew,
                    joi
                  ])
            ]));
      });
    });
  });
}
