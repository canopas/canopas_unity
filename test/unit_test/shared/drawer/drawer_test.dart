import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/space/space.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/account_service.dart';
import 'package:projectunity/data/services/auth_service.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/space_service.dart';

import 'package:projectunity/ui/shared/appbar_drawer/drawer/bloc/app_drawer_bloc.dart';
import 'package:projectunity/ui/shared/appbar_drawer/drawer/bloc/app_drawer_event.dart';
import 'package:projectunity/ui/shared/appbar_drawer/drawer/bloc/app_drawer_state.dart';

import 'drawer_test.mocks.dart';

@GenerateMocks(
    [SpaceService, UserManager, EmployeeService, AccountService, AuthService])
void main() {
  late SpaceService spaceService;
  late UserManager userManager;
  late EmployeeService employeeService;
  late AccountService accountService;
  late AuthService authService;
  late DrawerBloc bloc;
  setUp(() {
    spaceService = MockSpaceService();
    userManager = MockUserManager();
    employeeService = MockEmployeeService();
    accountService = MockAccountService();
    authService = MockAuthService();
    bloc = DrawerBloc(spaceService, userManager, accountService,
        employeeService, authService);
    when(userManager.userUID).thenReturn('uid');
    when(userManager.currentSpaceId).thenReturn('sid');
    when(accountService.fetchSpaceIds(uid: 'uid'))
        .thenAnswer((realInvocation) async => ['space-id']);
  });

  Space space = Space(
      id: "space-id",
      name: 'dummy space',
      createdAt: DateTime.now(),
      paidTimeOff: 12,
      ownerIds: ['uid']);

  const Employee employee = Employee(
    uid: 'uid',
    name: 'dummy',
    email: 'dummy@canopas.com',
    role: Role.employee,
    dateOfJoining: 11,
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
      await untilCalled(
          userManager.setSpace(space: space, spaceUser: employee));
      verify(userManager.setSpace(space: space, spaceUser: employee)).called(1);
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
      when(authService.signOutWithGoogle())
          .thenAnswer((_) => Future(() => true));
      bloc.add(SignOutEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            const DrawerState(signOutStatus: Status.loading),
            const DrawerState(signOutStatus: Status.success),
          ]));
      await untilCalled(userManager.removeAll());
      verify(userManager.removeAll()).called(1);
    });

    test("sign out failure test", () {
      when(authService.signOutWithGoogle())
          .thenAnswer((_) => Future(() => false));
      bloc.add(SignOutEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            const DrawerState(signOutStatus: Status.loading),
            const DrawerState(signOutStatus: Status.error, error: signOutError),
          ]));
    });
  });
}
