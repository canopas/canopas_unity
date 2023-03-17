import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/ui/user/employees/list/bloc/user_employees_bloc.dart';
import 'package:projectunity/ui/user/employees/list/bloc/user_employees_event.dart';
import 'package:projectunity/ui/user/employees/list/bloc/user_employees_state.dart';

import 'user_employees_test.mocks.dart';

@GenerateMocks([EmployeeService, UserManager])
void main() {
  late EmployeeService employeeService;
  late UserEmployeesBloc userEmployeesBloc;
  late UserManager userManager;
  Employee employee = const Employee(
      id: 'id',
      roleType: 1,
      name: 'Andrew jhone',
      employeeId: 'CA 1254',
      email: 'andrew.j@canopas.com',
      designation: 'Android developer');

  setUpAll(() {
    employeeService = MockEmployeeService();
    userManager = MockUserManager();
    userEmployeesBloc = UserEmployeesBloc(employeeService, userManager);
  });

  group('User Employees Bloc', () {
    test('Emits initial state after user employees screen are open', () {
      expect(userEmployeesBloc.state, UserEmployeesInitialState());
    });

    test('Emits failure state when Exception is thrown from any cause', () {
      when(employeeService.getEmployees())
          .thenThrow(Exception(firestoreFetchDataError));
      when(userManager.employeeId).thenReturn(employee.id);
      userEmployeesBloc.add(FetchEmployeesEvent());
      expectLater(
          userEmployeesBloc.stream,
          emitsInOrder([
            UserEmployeesLoadingState(),
            UserEmployeesFailureState(error: firestoreFetchDataError)
          ]));
    });
    test(
        'Emits Loading state while fetching data from database and the emits success state with list of employees',
        () {
      List<Employee> employees = [employee, employee];
      when(employeeService.getEmployees()).thenAnswer((_) async => employees);
      when(userManager.employeeId).thenReturn('uid');
      userEmployeesBloc.add(FetchEmployeesEvent());
      expectLater(
          userEmployeesBloc.stream,
          emitsInOrder([
            UserEmployeesLoadingState(),
            UserEmployeesSuccessState(employees: employees)
          ]));
    });
  });
}
