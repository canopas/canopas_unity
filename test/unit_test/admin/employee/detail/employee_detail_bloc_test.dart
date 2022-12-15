import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/services/admin/employee/employee_service.dart';
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_bloc.dart';
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_event.dart';
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_state.dart';

import '../../home/bloc/admin_home_bloc_test.mocks.dart';


@GenerateMocks([NavigationStackManager, EmployeeService])
void main() {
  late EmployeeService employeeService;
  late NavigationStackManager navigationStackManager;
  late EmployeeDetailBloc employeeDetailBloc;
  Employee employee = Employee(
      id: 'id',
      roleType: 2,
      name: 'Andrew jhone',
      employeeId: 'CA 1254',
      email: 'andrew.j@canopas.com',
      designation: 'Android developer');

  setUpAll(() {
    employeeService = MockEmployeeService();
    navigationStackManager = MockNavigationStackManager();
    employeeDetailBloc =
        EmployeeDetailBloc(navigationStackManager, employeeService);
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
      employeeDetailBloc
          .add(EmployeeDetailInitialLoadEvent(employeeId: employee.id));
      expectLater(
          employeeDetailBloc.stream,
          emitsInOrder([
            EmployeeDetailLoadingState(),
            EmployeeDetailLoadedState(employee: employee)
          ]));
    });
  });



  group("Navigation test", () {
    test('Navigate to Employee list screen after employee is deleted ',
        () async {
      when(employeeService.deleteEmployee(employee.id))
          .thenAnswer((_) async {
        return;
      });
      employeeDetailBloc.add(DeleteEmployeeEvent(employeeId: employee.id));
      await untilCalled(navigationStackManager.pop());
      verify(navigationStackManager.pop()).called(1);
    });
  });
}
