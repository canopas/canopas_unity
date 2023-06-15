import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/ui/user/members/members_screen/bloc/user_members_bloc.dart';
import 'package:projectunity/ui/user/members/members_screen/bloc/user_members_event.dart';
import 'package:projectunity/ui/user/members/members_screen/bloc/user_members_state.dart';
import 'user_employees_test.mocks.dart';

@GenerateMocks([EmployeeService])
void main() {
  late EmployeeService employeeService;
  late UserEmployeesBloc userEmployeesBloc;
  final employee = Employee(
    uid: 'id',
    role: Role.admin,
    name: 'Andrew jhone',
    employeeId: 'CA 1254',
    email: 'andrew.j@canopas.com',
    designation: 'Android developer',
    dateOfJoining: DateTime(2000),
  );

  setUpAll(() {
    employeeService = MockEmployeeService();
    userEmployeesBloc = UserEmployeesBloc(employeeService);
  });

  group('User Employees Bloc', () {
    test('Emits initial state after user employees screen are open', () {
      expect(userEmployeesBloc.state, UserEmployeesInitialState());
    });

    test('Emits failure state when Exception is thrown from any cause', () {
      when(employeeService.getEmployees())
          .thenThrow(Exception(firestoreFetchDataError));
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
