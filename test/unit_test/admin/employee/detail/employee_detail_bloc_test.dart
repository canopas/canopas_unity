import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:projectunity/data/services/paid_leave_service.dart';
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_bloc.dart';
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_event.dart';
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_state.dart';

import 'employee_detail_bloc_test.mocks.dart';

@GenerateMocks([EmployeeService, LeaveService, PaidLeaveService])
void main() {
  late EmployeeService employeeService;
  late EmployeeDetailBloc employeeDetailBloc;
  late LeaveService leaveService;
  late PaidLeaveService paidLeaveService;
  Employee employee = const Employee(
      uid: 'id',
      role: 2,
      name: 'Andrew jhone',
      employeeId: 'CA 1254',
      email: 'andrew.j@canopas.com',
      designation: 'Android developer');
  Employee admin = const Employee(
      uid: 'id',
      role: 1,
      name: 'Andrew jhone',
      employeeId: 'CA 1254',
      email: 'andrew.j@canopas.com',
      designation: 'Android developer');

  setUp(() {
    employeeService = MockEmployeeService();
    leaveService = MockLeaveService();
    paidLeaveService = MockPaidLeaveService();
    employeeDetailBloc = EmployeeDetailBloc(
      paidLeaveService,
      employeeService,
      leaveService,
    );
    when(leaveService.getUserUsedLeaves(employee.uid))
        .thenAnswer((_) async => 10);
    when(paidLeaveService.getPaidLeaves()).thenAnswer((_) async => 12);
  });

  group('Employee detail bloc', () {
    test('Emits Initial State after employee detail screen is open', () {
      expect(employeeDetailBloc.state, EmployeeDetailInitialState());
    });

    test('Emits Failure state when employee is found null', () {
      when(employeeService.getEmployee(employee.uid))
          .thenAnswer((_) async => await null);
      employeeDetailBloc
          .add(EmployeeDetailInitialLoadEvent(employeeId: employee.uid));
      expectLater(
          employeeDetailBloc.stream,
          emitsInOrder([
            EmployeeDetailLoadingState(),
            EmployeeDetailFailureState(error: firestoreFetchDataError)
          ]));
    });

    test('Emits Failure state when exception is thrown by any cause', () {
      when(employeeService.getEmployee(employee.uid))
          .thenThrow(Exception('Employee not found'));
      employeeDetailBloc
          .add(EmployeeDetailInitialLoadEvent(employeeId: employee.uid));
      expectLater(
          employeeDetailBloc.stream,
          emitsInOrder([
            EmployeeDetailLoadingState(),
            EmployeeDetailFailureState(error: firestoreFetchDataError)
          ]));
    });
    test('Emits Failure state when exception is thrown while fetching leaves',
        () {
      when(employeeService.getEmployee(employee.uid))
          .thenAnswer((_) async => employee);
      when(leaveService.getUserUsedLeaves(employee.uid))
          .thenThrow(Exception(firestoreFetchDataError));
      employeeDetailBloc
          .add(EmployeeDetailInitialLoadEvent(employeeId: employee.uid));
      expectLater(
          employeeDetailBloc.stream,
          emitsInOrder([
            EmployeeDetailLoadingState(),
            EmployeeDetailFailureState(error: firestoreFetchDataError)
          ]));
    });

    test(
        'Emits Loading state while fetch data from firestore and then EmitsSuccess state with detail of employee ',
        () {
      when(employeeService.getEmployee(employee.uid))
          .thenAnswer((_) async => employee);

      employeeDetailBloc
          .add(EmployeeDetailInitialLoadEvent(employeeId: employee.uid));
      EmployeeDetailLoadedState loadedState = EmployeeDetailLoadedState(
          employee: employee,
          timeOffRatio: 10 / 12,
          paidLeaves: 12,
          usedLeaves: 10);
      expectLater(employeeDetailBloc.stream,
          emitsInOrder([EmployeeDetailLoadingState(), loadedState]));
    });
    test('test for make user as admin', () {
      EmployeeDetailLoadedState loadedStateWithEmployee =
          EmployeeDetailLoadedState(
              employee: employee,
              timeOffRatio: 10 / 12,
              paidLeaves: 12,
              usedLeaves: 10);
      employeeDetailBloc.emit(loadedStateWithEmployee);
      employeeDetailBloc.add(EmployeeDetailsChangeRoleEvent());
      EmployeeDetailLoadedState loadedStateWithAdmin =
          EmployeeDetailLoadedState(
              employee: admin,
              timeOffRatio: 10 / 12,
              paidLeaves: 12,
              usedLeaves: 10);

      expectLater(employeeDetailBloc.stream, emits(loadedStateWithAdmin));
    });
    test('test for remove user as admin', () {
      EmployeeDetailLoadedState loadedStateWithAdmin =
          EmployeeDetailLoadedState(
              employee: admin,
              timeOffRatio: 10 / 12,
              paidLeaves: 12,
              usedLeaves: 10);
      employeeDetailBloc.emit(loadedStateWithAdmin);
      employeeDetailBloc.add(EmployeeDetailsChangeRoleEvent());
      EmployeeDetailLoadedState loadedStateWithEmployee =
          EmployeeDetailLoadedState(
              employee: employee,
              timeOffRatio: 10 / 12,
              paidLeaves: 12,
              usedLeaves: 10);

      expectLater(employeeDetailBloc.stream, emits(loadedStateWithEmployee));
    });

    test('delete employee failed test', () {
      when(employeeService.deleteEmployee(employee.uid))
          .thenThrow(Exception("error"));
      employeeDetailBloc.add(DeleteEmployeeEvent(employeeId: employee.uid));
      expect(employeeDetailBloc.stream,
          emits(EmployeeDetailFailureState(error: firestoreFetchDataError)));
    });

    test('delete employee success test', () async {
      employeeDetailBloc.add(DeleteEmployeeEvent(employeeId: employee.uid));
      await untilCalled(leaveService.deleteAllLeavesOfUser(employee.uid));
      await untilCalled(leaveService.deleteAllLeavesOfUser(employee.uid));
      verify(employeeService.deleteEmployee(employee.uid)).called(1);
      verify(leaveService.deleteAllLeavesOfUser(employee.uid)).called(1);
    });
  });
}
