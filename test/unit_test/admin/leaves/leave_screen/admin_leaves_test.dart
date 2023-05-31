import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
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
    Leave andrewCurrentYearLeave = Leave(
        leaveId: 'leave-id',
        uid: 'andrew-id',
        type: 2,
        startDate: DateTime.now().timeStampToInt,
        endDate: DateTime.now().add(const Duration(days: 1)).timeStampToInt,
        total: 2,
        reason: 'reason',
        status: LeaveStatus.approved,
        appliedOn: 400,
        perDayDuration: const [
          LeaveDayDuration.noLeave,
          LeaveDayDuration.firstHalfLeave
        ]);
    Leave joiCurrentYearLeave = Leave(
        leaveId: 'leave-id',
        uid: 'joi-id',
        type: 2,
        startDate: DateTime.now().timeStampToInt,
        endDate: DateTime.now().add(const Duration(days: 1)).timeStampToInt,
        total: 2,
        reason: 'reason',
        status: LeaveStatus.approved,
        appliedOn: 400,
        perDayDuration: const [
          LeaveDayDuration.noLeave,
          LeaveDayDuration.firstHalfLeave
        ]);
    Leave joiPreviousYearLeave = Leave(
        leaveId: 'leave-id',
        uid: 'joi-id',
        type: 2,
        startDate:
            DateTime.now().subtract(const Duration(days: 365)).timeStampToInt,
        endDate:
            DateTime.now().subtract(const Duration(days: 364)).timeStampToInt,
        total: 2,
        reason: 'reason',
        status: LeaveStatus.approved,
        appliedOn: 400,
        perDayDuration: const [
          LeaveDayDuration.noLeave,
          LeaveDayDuration.firstHalfLeave
        ]);
    const andrew = Employee(
      uid: 'andrew-id',
      role: Role.admin,
      name: 'Andrew jhone',
      employeeId: '100',
      email: 'andrew.j@canopas.com',
      designation: 'Android developer',
      dateOfJoining: 11,
    );
    const joi = Employee(
      uid: 'joi-id',
      role: Role.admin,
      name: 'joi jhone',
      employeeId: '100',
      email: 'joi.j@canopas.com',
      designation: 'Android developer',
      dateOfJoining: 11,
    );

    group('Admin Leaves fetch data test', () {
      setUp(() {
        leaveService = MockLeaveService();
        employeeService = MockEmployeeService();
        bloc = AdminLeavesBloc(leaveService, employeeService);
      });

      test('initial value test', () {
        expect(
            bloc.state,
            AdminLeavesState(
              selectedEmployee: null,
              leaveApplication: const [],
              selectedYear: DateTime.now().year,
              status: Status.initial,
              employees: const [],
              error: null,
              searchEmployeeInput: '',
            ));
      });

      test('successfully fetch initial data test', () {
        bloc.add(AdminLeavesInitialLoadEvent());
        when(employeeService.getEmployees())
            .thenAnswer((_) async => [andrew, joi]);
        when(leaveService.getAllLeaves()).thenAnswer((_) async => [
              andrewCurrentYearLeave,
              joiCurrentYearLeave,
              joiPreviousYearLeave
            ]);

        expect(
            bloc.stream,
            emitsInOrder([
              AdminLeavesState(status: Status.loading),
              AdminLeavesState(status: Status.success, leaveApplication: [
                LeaveApplication(
                    employee: andrew, leave: andrewCurrentYearLeave),
                LeaveApplication(employee: joi, leave: joiCurrentYearLeave)
              ], employees: const [
                andrew,
                joi
              ])
            ]));
      });

      test('check leave not add on list when employee not found', () {
        bloc.add(AdminLeavesInitialLoadEvent());
        when(employeeService.getEmployees()).thenAnswer((_) async => [andrew]);
        when(leaveService.getAllLeaves()).thenAnswer((_) async => [
              andrewCurrentYearLeave,
              joiCurrentYearLeave,
            ]);

        expect(
            bloc.stream,
            emitsInOrder([
              AdminLeavesState(status: Status.loading),
              AdminLeavesState(status: Status.success, leaveApplication: [
                LeaveApplication(
                    employee: andrew, leave: andrewCurrentYearLeave),
              ], employees: const [
                andrew,
              ])
            ]));
      });

      test('show error on initial data failure test', () {
        bloc.add(AdminLeavesInitialLoadEvent());
        when(employeeService.getEmployees())
            .thenAnswer((_) async => [andrew, joi]);
        when(leaveService.getAllLeaves()).thenThrow(Exception('error'));
        expect(
            bloc.stream,
            emitsInOrder([
              AdminLeavesState(status: Status.loading),
              AdminLeavesState(
                  status: Status.error, error: firestoreFetchDataError),
            ]));
      });

      test('text search employee text-field inputs', () {
        bloc.add(SearchEmployeeEvent(search: "dummy"));
        expect(
            bloc.stream,
            emits(
              AdminLeavesState(searchEmployeeInput: 'dummy'),
            ));
      });
    });
    group('Admin Leaves data filter test', () {
      setUpAll(() {
        leaveService = MockLeaveService();
        employeeService = MockEmployeeService();
        bloc = AdminLeavesBloc(leaveService, employeeService);
      });

      test('successfully fetch initial data test', () {
        bloc.add(AdminLeavesInitialLoadEvent());
        when(employeeService.getEmployees())
            .thenAnswer((_) async => [andrew, joi]);
        when(leaveService.getAllLeaves()).thenAnswer((_) async => [
              andrewCurrentYearLeave,
              joiCurrentYearLeave,
              joiPreviousYearLeave
            ]);

        expect(
            bloc.stream,
            emitsInOrder([
              AdminLeavesState(status: Status.loading),
              AdminLeavesState(status: Status.success, leaveApplication: [
                LeaveApplication(
                    employee: andrew, leave: andrewCurrentYearLeave),
                LeaveApplication(employee: joi, leave: joiCurrentYearLeave)
              ], employees: const [
                andrew,
                joi
              ])
            ]));
      });

      test('show particular employee leaves test', () async {
        bloc.add(ChangeEmployeeEvent(employee: joi));
        expect(
            bloc.stream,
            emitsInOrder([
              AdminLeavesState(
                  selectedEmployee: joi,
                  selectedYear: DateTime.now().year,
                  status: Status.success,
                  leaveApplication: [
                    LeaveApplication(employee: joi, leave: joiCurrentYearLeave)
                  ],
                  employees: const [
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
                  selectedEmployee: joi,
                  selectedYear:
                      DateTime.now().subtract(const Duration(days: 365)).year,
                  status: Status.success,
                  leaveApplication: [
                    LeaveApplication(employee: joi, leave: joiPreviousYearLeave)
                  ],
                  employees: const [
                    andrew,
                    joi
                  ])
            ]));
      });
    });
  });
}
