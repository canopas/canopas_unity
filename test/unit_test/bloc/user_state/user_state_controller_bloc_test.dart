import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/bloc/user_state/user_controller_state.dart';
import 'package:projectunity/data/bloc/user_state/user_state_controller_bloc.dart';
import 'package:projectunity/data/bloc/user_state/user_state_controller_event.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/space/space.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/space_service.dart';

import 'user_state_controller_bloc_test.mocks.dart';

@GenerateMocks([EmployeeService, SpaceService, UserStateNotifier])
void main() {
  late UserStateControllerBloc bloc;
  late EmployeeService employeeService;
  late SpaceService spaceService;
  late UserStateNotifier userStateNotifier;
  final employee = Employee(
      uid: 'uid',
      name: 'Andrew jhone',
      email: 'andrew.j@gmail.com',
      role: Role.admin,
      dateOfJoining: DateTime(2000));




  final Space space = Space(
      id: 'space_id',
      name: 'Google',
      createdAt: DateTime.fromMillisecondsSinceEpoch(20),
      paidTimeOff: 20,
      ownerIds: [employee.uid]);

  final Space newSpace = Space(
      id: 'space)id',
      name: 'Alphabet',
      createdAt: DateTime.fromMillisecondsSinceEpoch(20),
      paidTimeOff: 20,
      ownerIds: [employee.uid]);

  setUp(() {
    employeeService = MockEmployeeService();
    spaceService = MockSpaceService();
    userStateNotifier = MockUserStateNotifier();
    bloc = UserStateControllerBloc(
        employeeService, userStateNotifier, spaceService);
    when(userStateNotifier.currentSpaceId).thenReturn(space.id);
    when(userStateNotifier.userUID).thenReturn(employee.uid);
  });

  test('Should emit initial state as default state of bloc', () {
    expect(bloc.state, const UserControllerState());
  });

  test(
      'Fetch data of user and space from firestore and update it on CheckUserStatusEvent',
      () async {
        when(userStateNotifier.currentSpace)
            .thenReturn(space);
        when(userStateNotifier.employee)
            .thenReturn(employee);
        bloc.add(CheckUserStatus());
    when(employeeService.getEmployee(employee.uid))
        .thenAnswer((_) async => employee);
    when(spaceService.getSpace(space.id)).thenAnswer((_) async => newSpace);
    expectLater(bloc.stream,
        emits(const UserControllerState(userState: UserState.authenticated)));
    await untilCalled(userStateNotifier.setEmployeeWithSpace(
        space: newSpace, spaceUser: employee, redirect: false));
    verify(userStateNotifier.setEmployeeWithSpace(
            space: newSpace, spaceUser: employee,redirect: false))
        .called(1);
  });
  test(
      'Fetch data of user and space from firestore and if value found null then remove user from space',
      () async {
        bloc.add(CheckUserStatus());
    when(employeeService.getEmployee(employee.uid))
        .thenAnswer((_) async => employee);
    when(spaceService.getSpace(space.id)).thenAnswer((_) async => null);
    expectLater(bloc.stream,
        emits(const UserControllerState(userState: UserState.unauthenticated)));
  });

  test(
      'Fetch data of user and space from firestore and if exception is thrown then emits state as disable user',
      () async {
        bloc.add(CheckUserStatus());
    when(employeeService.getEmployee(employee.uid)).thenThrow(Exception());
    when(spaceService.getSpace(space.id)).thenAnswer((_) async => space);
    expectLater(bloc.stream,
        emits(const UserControllerState(userState: UserState.unauthenticated)));
  });
  test(
      'Clear data of user on ClearDataClearDataForDisableUser event when user status is disable',
      () async {
    when(userStateNotifier.state).thenReturn(UserState.update);
    bloc.add(ClearDataForDisableUser());
    await untilCalled(userStateNotifier.removeEmployeeWithSpace());
    verify(userStateNotifier.removeEmployeeWithSpace()).called(1);
    expectLater(userStateNotifier.state, UserState.update);
  });
}
