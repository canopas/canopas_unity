import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/space/space.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/account_service.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/space_service.dart';
import 'package:projectunity/ui/shared/appbar_drawer/drawer/bloc/app_drawer_bloc.dart';
import 'package:projectunity/ui/shared/appbar_drawer/drawer/bloc/app_drawer_event.dart';
import 'package:projectunity/ui/shared/appbar_drawer/drawer/bloc/app_drawer_state.dart';

import 'drawer_test.mocks.dart';

@GenerateMocks([
  SpaceService,
  UserStateNotifier,
  EmployeeService,
  AccountService,
])
void main() {
  late SpaceService spaceService;
  late UserStateNotifier userStateNotifier;
  late EmployeeService employeeService;
  late AccountService accountService;
  late DrawerBloc bloc;
  setUp(() {
    spaceService = MockSpaceService();
    userStateNotifier = MockUserStateNotifier();
    employeeService = MockEmployeeService();
    accountService = MockAccountService();
    bloc = DrawerBloc(spaceService, userStateNotifier, accountService,
        employeeService);
    when(userStateNotifier.userUID).thenReturn('uid');
    when(userStateNotifier.currentSpaceId).thenReturn('sid');
    when(accountService.fetchSpaceIds(uid: 'uid'))
        .thenAnswer((realInvocation) async => ['space-id']);
  });

  Space space = Space(
      id: "space-id",
      name: 'dummy space',
      createdAt: DateTime.now(),
      paidTimeOff: 12,
      ownerIds: const ['uid']);

  final Employee employee = Employee(
    uid: 'uid',
    name: 'dummy',
    email: 'dummy@canopas.com',
    role: Role.employee,
    dateOfJoining: DateTime(2000),
  );

  group('Drawer test', () {
    test('Fetch spaces success test', () {
      when(spaceService.getSpace('space-id')).thenAnswer((_) async => space);
      bloc.add(FetchSpacesEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            const DrawerState(fetchSpacesStatus: Status.loading),
            DrawerState(fetchSpacesStatus: Status.success, spaces: [space]),
          ]));
    });

    test('Fetch spaces failure test', () {
      when(spaceService.getSpace('space-id')).thenThrow(Exception('error'));
      bloc.add(FetchSpacesEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            const DrawerState(fetchSpacesStatus: Status.loading),
            const DrawerState(
                fetchSpacesStatus: Status.error,
                error: firestoreFetchDataError),
          ]));
    });

    test('Change space success test', () async {
      when(employeeService.getEmployeeBySpaceId(
              userId: 'uid', spaceId: space.id))
          .thenAnswer((_) async => employee);
      bloc.add(ChangeSpaceEvent(space));
      expect(
          bloc.stream,
          emitsInOrder([
            const DrawerState(changeSpaceStatus: Status.loading),
            const DrawerState(changeSpaceStatus: Status.success),
          ]));
      await untilCalled(userStateNotifier.setEmployeeWithSpace(
          space: space, spaceUser: employee));
      verify(userStateNotifier.setEmployeeWithSpace(
              space: space, spaceUser: employee))
          .called(1);
    });

    test('Change space failure test', () {
      when(employeeService.getEmployeeBySpaceId(
              userId: 'uid', spaceId: space.id))
          .thenThrow(Exception('error'));
      bloc.add(ChangeSpaceEvent(space));
      expect(
          bloc.stream,
          emitsInOrder([
            const DrawerState(changeSpaceStatus: Status.loading),
            const DrawerState(
                changeSpaceStatus: Status.error,
                error: firestoreFetchDataError),
          ]));
    });

    test("sign out successful test with navigation test", () async {
      bloc.add(SignOutFromSpaceEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            const DrawerState(signOutStatus: Status.loading),
            const DrawerState(signOutStatus: Status.success),
          ]));
      await untilCalled(userStateNotifier.removeEmployeeWithSpace());
      verify(userStateNotifier.removeEmployeeWithSpace()).called(1);
    });

    test("sign out failure test", () {
      when(userStateNotifier.removeEmployeeWithSpace()).thenThrow(Exception("error"));
      bloc.add(SignOutFromSpaceEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            const DrawerState(signOutStatus: Status.loading),
            const DrawerState(signOutStatus: Status.error, error: signOutError),
          ]));
    });
  });
}
