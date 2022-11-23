import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/services/admin/employee/employee_service.dart';
import 'package:projectunity/ui/admin/employee/list/bloc/employee_list_bloc.dart';
import 'package:projectunity/ui/admin/employee/list/bloc/employee_list_event.dart';
import 'package:projectunity/ui/admin/employee/list/bloc/employee_list_state.dart';

import 'employee_list_bloc_test.mocks.dart';


@GenerateMocks([EmployeeService,NavigationStackManager])
void main(){
late NavigationStackManager navigationStackManager;
late EmployeeService employeeService;
late EmployeeListBloc employeeListBloc;
Employee employee= Employee(id: 'id', roleType: 1, name: 'Andrew jhone', employeeId: 'CA 1254', email: 'andrew.j@canopas.com', designation: 'Android developer');

setUpAll(() {
navigationStackManager= MockNavigationStackManager();
employeeService= MockEmployeeService();
employeeListBloc= EmployeeListBloc(employeeService, navigationStackManager);


});

group('Employee List Bloc', () {
  test('Emits initial state after Employee list screen is open ', () {

    expect(employeeListBloc.state, EmployeeListInitialState());
  });
  test('Emits failure state when Exception is thrown from any cause', ()  {
    when(employeeService.getEmployees()).thenThrow(Exception(firestoreFetchDataError));
    EmployeeListState failureState= EmployeeListFailureState(error: firestoreFetchDataError);
    employeeListBloc.add(EmployeeListInitialLoadEvent());
    expectLater(employeeListBloc.stream,emitsInOrder([EmployeeListLoadingState(),failureState]));
  });
  test('Emits Loading state while fetching data from firestore and the Emits success state with list of employees', (){
    List<Employee> employees= [employee,employee];
    EmployeeListState successState = EmployeeListLoadedState(employees: employees);
    when(employeeService.getEmployees()).thenAnswer((_)=>Future(() => employees) );
    employeeListBloc.add(EmployeeListInitialLoadEvent());
    expectLater(employeeListBloc.stream, emitsInOrder([EmployeeListLoadingState(),successState]));
  });
});

group('Navigation event tests', () {
  test('Navigate to Employee detail screen on EmployeeListNavigateToDetail', ()async {
    final state= NavStackItem.employeeDetailState(id:employee.id);
    employeeListBloc.add(EmployeeListNavigationToEmployeeDetailEvent(employee.id));
    await untilCalled(navigationStackManager.push(state));
    verify(navigationStackManager.push(state)).called(1);
  });
});
}