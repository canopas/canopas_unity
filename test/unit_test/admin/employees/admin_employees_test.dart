import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/services/admin/employee_service.dart';
import 'package:projectunity/ui/admin/admin_employees/bloc/admin_employee_state.dart';
import 'package:projectunity/ui/admin/admin_employees/bloc/admin_employees_bloc.dart';
import 'package:projectunity/ui/admin/admin_employees/bloc/admin_employees_event.dart';
import 'admin_employees_test.mocks.dart';



@GenerateMocks([EmployeeService])
void main() {
  late EmployeeService employeeService;
  late AdminEmployeesBloc adminEmployeesBloc;
  Employee employee = const Employee(
      id: 'id',
      roleType: 1,
      name: 'Andrew jhone',
      employeeId: 'CA 1254',
      email: 'andrew.j@canopas.com',
      designation: 'Android developer');

  setUpAll(() {
    employeeService = MockEmployeeService();
    adminEmployeesBloc = AdminEmployeesBloc(employeeService);
  });

  group('User Employees Bloc', () {
    test('Emits initial state after user employees screen are open', () {
      expect(adminEmployeesBloc.state, AdminEmployeesInitialState());
    });

    test('Emits failure state when Exception is thrown from any cause', () {
      when(employeeService.getEmployees()).thenThrow(Exception(firestoreFetchDataError));
      adminEmployeesBloc.add(FetchEmployeesEventAdminEmployeesEvent());
      expectLater(
          adminEmployeesBloc.stream,
          emitsInOrder([
            AdminEmployeesLoadingState(),
            AdminEmployeesFailureState(error: firestoreFetchDataError)
          ]));
    });
    test(
        'Emits Loading state while fetching data from database and the emits success state with list of employees',
            () {
          List<Employee> employees = [employee, employee];
          when(employeeService.getEmployees())
              .thenAnswer((_) => Future(() => employees));
          adminEmployeesBloc.add(FetchEmployeesEventAdminEmployeesEvent());
          expectLater(
              adminEmployeesBloc.stream,
              emitsInOrder([
                AdminEmployeesLoadingState(),
                AdminEmployeesSuccessState(employees: employees)
              ]));
        });
  });
}
