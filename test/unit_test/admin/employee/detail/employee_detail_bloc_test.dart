import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/services/admin/employee/employee_service.dart';
import 'package:projectunity/services/leave/user_leave_service.dart';
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_bloc.dart';
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_event.dart';
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_state.dart';

import 'employee_detail_bloc_test.mocks.dart';

@GenerateMocks([EmployeeService, UserLeaveService])
void main() {
  late EmployeeService employeeService;
  late EmployeeDetailBloc employeeDetailBloc;
  late UserLeaveService userLeaveService;
  Employee employee = const Employee(
      id: 'id',
      roleType: 2,
      name: 'Andrew jhone',
      employeeId: 'CA 1254',
      email: 'andrew.j@canopas.com',
      designation: 'Android developer');

  Employee admin = const Employee(
      id: 'id',
      roleType: 1,
      name: 'Andrew jhone',
      employeeId: 'CA 1254',
      email: 'andrew.j@canopas.com',
      designation: 'Android developer');

  setUp(() {
    employeeService = MockEmployeeService();
    userLeaveService = MockUserLeaveService();
    employeeDetailBloc = EmployeeDetailBloc(employeeService, userLeaveService);
  });

  group('Employee detail bloc', () {
    test('Emits Initial State after employee detail screen is open', () {
      expect(employeeDetailBloc.state, EmployeeDetailInitialState());
    });

    test('Emits Failure state when employee is found null', () {
      when(employeeService.getEmployee(employee.id))
          .thenAnswer((_) async => await null);
      employeeDetailBloc
          .add(EmployeeDetailInitialLoadEvent(employeeId: employee.id));
      expectLater(
          employeeDetailBloc.stream,
          emitsInOrder([
            EmployeeDetailLoadingState(),
            EmployeeDetailFailureState(error: firestoreFetchDataError)
          ]));
    });

    test('Emits Failure state when exception is thrown by any cause', () {
      when(employeeService.getEmployee(employee.id))
          .thenThrow(Exception('Employee not found'));
      employeeDetailBloc
          .add(EmployeeDetailInitialLoadEvent(employeeId: employee.id));
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
      when(employeeService.getEmployee(employee.id))
          .thenAnswer((_) async => employee);
      employeeDetailBloc.add(EmployeeDetailInitialLoadEvent(employeeId: employee.id));
      expectLater(
          employeeDetailBloc.stream,
          emitsInOrder([
            EmployeeDetailLoadingState(),
            EmployeeDetailLoadedState(employee: employee)
          ]));
    });

    test('test for make user as admin', (){
      employeeDetailBloc.emit(EmployeeDetailLoadedState(employee: employee));
      employeeDetailBloc.add(EmployeeDetailsChangeRoleTypeEvent());

      expectLater(
          employeeDetailBloc.stream,
          emits(EmployeeDetailLoadedState(employee: admin)));
    });

    test('test for remove user as admin', (){
      employeeDetailBloc.emit(EmployeeDetailLoadedState(employee: admin));
      employeeDetailBloc.add(EmployeeDetailsChangeRoleTypeEvent());

      expectLater(
          employeeDetailBloc.stream,
          emits(EmployeeDetailLoadedState(employee: employee)));
    });

    test('delete employee failed test', () {
      when(employeeService.deleteEmployee(employee.id))
          .thenThrow(Exception("error"));
      employeeDetailBloc.add(DeleteEmployeeEvent(employeeId: employee.id));
      expect(employeeDetailBloc.stream,
          emits(EmployeeDetailFailureState(error: firestoreFetchDataError)));
    });

    test('delete employee success test', () async {
      employeeDetailBloc.add(DeleteEmployeeEvent(employeeId: employee.id));
          await untilCalled(userLeaveService.deleteAllLeaves(employee.id));
          await untilCalled(userLeaveService.deleteAllLeaves(employee.id));
          verify(employeeService.deleteEmployee(employee.id)).called(1);
          verify(userLeaveService.deleteAllLeaves(employee.id)).called(1);
        });
  });
}
