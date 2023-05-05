import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/space/space.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/account_service.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/space_service.dart';
import 'package:projectunity/ui/space/change_space_sheet/bloc/change_space_bloc.dart';
import 'package:projectunity/ui/space/change_space_sheet/bloc/change_space_events.dart';
import 'package:projectunity/ui/space/change_space_sheet/bloc/change_space_state.dart';

import 'change_space_test.mocks.dart';

@GenerateMocks([SpaceService, UserManager, EmployeeService, AccountService])
void main() {
  late SpaceService spaceService;
  late UserManager userManager;
  late EmployeeService employeeService;
  late AccountService accountService;
  late ChangeSpaceBloc bloc;
  setUp(() {
    spaceService = MockSpaceService();
    userManager = MockUserManager();
    employeeService = MockEmployeeService();
    accountService = MockAccountService();
    bloc = ChangeSpaceBloc(
        userManager, spaceService, employeeService, accountService);
    when(userManager.userUID).thenReturn('uid');
    when(accountService.fetchSpaceIds(uid: 'uid'))
        .thenAnswer((realInvocation) async => ['space-id']);
  });

  Space space = Space(
      id: "space-id",
      name: 'dummy space',
      createdAt: DateTime.now(),
      paidTimeOff: 12,
      ownerIds: ['uid']);

  const Employee employee =
      Employee(uid: 'uid', name: 'dummy', email: 'dummy@canopas.com');

  group('Change space test', () {
    test('Fetch spaces success test', () {
      when(spaceService.getSpace('space-id')).thenAnswer((_) async => space);
      bloc.add(ChangeSpaceInitialLoadEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            const ChangeSpaceState(fetchSpaceStatus: Status.loading),
            ChangeSpaceState(fetchSpaceStatus: Status.success, spaces: [space]),
          ]));
    });

    test('Fetch spaces failure test', () {
      when(spaceService.getSpace('space-id')).thenThrow(Exception('error'));
      bloc.add(ChangeSpaceInitialLoadEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            const ChangeSpaceState(fetchSpaceStatus: Status.loading),
            const ChangeSpaceState(
                fetchSpaceStatus: Status.error, error: firestoreFetchDataError),
          ]));
    });

    test('Change space success test', () async {
      when(employeeService.getEmployeeBySpaceId(
              userId: 'uid', spaceId: space.id))
          .thenAnswer((_) async => employee);
      bloc.add(SelectSpaceEvent(space));
      expect(
          bloc.stream,
          emitsInOrder([
            const ChangeSpaceState(changeSpaceStatus: Status.loading),
            const ChangeSpaceState(changeSpaceStatus: Status.success),
          ]));
      await untilCalled(
          userManager.setSpace(space: space, spaceUser: employee));
      verify(userManager.setSpace(space: space, spaceUser: employee)).called(1);
    });

    test('Change space failure test', () {
      when(employeeService.getEmployeeBySpaceId(
              userId: 'uid', spaceId: space.id))
          .thenThrow(Exception('error'));
      bloc.add(SelectSpaceEvent(space));
      expect(
          bloc.stream,
          emitsInOrder([
            const ChangeSpaceState(changeSpaceStatus: Status.loading),
            const ChangeSpaceState(
                changeSpaceStatus: Status.error,
                error: firestoreFetchDataError),
          ]));
    });
  });
}
