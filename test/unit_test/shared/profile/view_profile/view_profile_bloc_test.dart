import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/ui/shared/profile/view_profile/bloc/view_profile_bloc.dart';
import 'package:projectunity/ui/shared/profile/view_profile/bloc/view_profile_event.dart';
import 'package:projectunity/ui/shared/profile/view_profile/bloc/view_profile_state.dart';

import 'view_profile_bloc_test.mocks.dart';

@GenerateMocks([UserStateNotifier, EmployeeService])
void main() {
  late ViewProfileBloc bloc;
  late UserStateNotifier userStateNotifier;
  late EmployeeService employeeService;
  const Employee employee = Employee(
      uid: 'uid',
      name: 'Andrew jhone',
      email: 'andrew.j@gmail.com',
      role: Role.employee,
      dateOfJoining: 10);

  setUp(() {
    userStateNotifier = MockUserStateNotifier();
    employeeService = MockEmployeeService();
    bloc = ViewProfileBloc(userStateNotifier, employeeService);
  });

  test('Emits Initial state as default state of bloc', () {
    expect(bloc.state, ViewProfileInitialState());
  });
  test(
      'Should emit loading state and then success state when fetched data from firestore successfully',
      () {
        bloc.add(InitialLoadevent());
    when(userStateNotifier.userUID).thenReturn('uid');
    when(employeeService.getEmployee(employee.uid))
        .thenAnswer((_) async => employee);
    expectLater(
        bloc.stream,
        emitsInOrder(
            [ViewProfileLoadingState(), ViewProfileSuccessState(employee)]));
  });
  test('Should emit loading state and then Error state in case of Exception ',
      () {
        bloc.add(InitialLoadevent());
    when(userStateNotifier.userUID).thenReturn('uid');
    when(employeeService.getEmployee(employee.uid))
        .thenThrow(Exception(firestoreFetchDataError));
    expectLater(
        bloc.stream,
        emitsInOrder([
          ViewProfileLoadingState(),
          ViewProfileErrorState(firestoreFetchDataError)
        ]));
  });
}
