import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/Repo/employee_repo.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/provider/user_status_notifier.dart';
import 'package:projectunity/ui/shared/profile/view_profile/bloc/view_profile_bloc.dart';
import 'package:projectunity/ui/shared/profile/view_profile/bloc/view_profile_event.dart';
import 'package:projectunity/ui/shared/profile/view_profile/bloc/view_profile_state.dart';

import 'view_profile_bloc_test.mocks.dart';

@GenerateMocks([UserStatusNotifier, EmployeeRepo])
void main() {
  late ViewProfileBloc bloc;
  late UserStatusNotifier userStateNotifier;
  late EmployeeRepo employeeRepo;
  final employee = Employee(
      uid: 'uid',
      name: 'Andrew jhone',
      email: 'andrew.j@gmail.com',
      role: Role.employee,
      dateOfJoining: DateTime(2000));

  setUp(() {
    userStateNotifier = MockUserStateNotifier();
    employeeRepo = MockEmployeeRepo();
    bloc = ViewProfileBloc(userStateNotifier, employeeRepo);
  });

  test('Emits Initial state as default state of bloc', () {
    expect(bloc.state, ViewProfileInitialState());
  });

  test(
      'Should emit loading state and then success state when fetched data from firestore successfully',
      () {
    bloc.add(InitialLoadevent());
    when(userStateNotifier.employeeId).thenReturn('uid');
    when(employeeRepo.memberDetails('uid'))
        .thenAnswer((_) => Stream.value(employee));
    expectLater(
        bloc.stream,
        emitsInOrder(
            [ViewProfileLoadingState(), ViewProfileSuccessState(employee)]));
  });

  test('Should emit loading state and then Error state in case of Exception ',
      () {
    bloc.add(InitialLoadevent());
    when(userStateNotifier.employeeId).thenReturn('uid');
    when(employeeRepo.memberDetails('uid'))
        .thenThrow(Exception(firestoreFetchDataError));
    expectLater(
        bloc.stream,
        emitsInOrder([
          ViewProfileLoadingState(),
          ViewProfileErrorState(firestoreFetchDataError)
        ]));
  });

  test('Should emit loading state and then Error state in Stream have error ',
          () {
        bloc.add(InitialLoadevent());
        when(userStateNotifier.employeeId).thenReturn('uid');
        when(employeeRepo.memberDetails('uid'))
            .thenAnswer((_) => Stream.error(firestoreFetchDataError));
        expectLater(
            bloc.stream,
            emitsInOrder([
              ViewProfileLoadingState(),
              ViewProfileErrorState(firestoreFetchDataError)
            ]));
      });
}
