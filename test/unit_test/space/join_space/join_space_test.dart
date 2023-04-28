import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/space/space.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/space_service.dart';
import 'package:projectunity/ui/space/join_space/bloc/join_space_bloc.dart';
import 'package:projectunity/ui/space/join_space/bloc/join_space_event.dart';
import 'package:projectunity/ui/space/join_space/bloc/join_space_state.dart';

import 'join_space_test.mocks.dart';

@GenerateMocks([SpaceService, UserManager, EmployeeService])
void main() {
  late SpaceService spaceService;
  late UserManager userManager;
  late EmployeeService employeeService;
  late JoinSpaceBloc bloc;
  setUp(() {
    spaceService = MockSpaceService();
    userManager = MockUserManager();
    employeeService = MockEmployeeService();
    bloc = JoinSpaceBloc(spaceService, userManager, employeeService);
    when(userManager.userUID).thenReturn('uid');
  });

  Space space = Space(
      id: "space-id",
      name: 'dummy space',
      createdAt: DateTime.now(),
      paidTimeOff: 12,
      ownerIds: ['uid']);

  const Employee employee =
      Employee(uid: 'uid', name: 'dummy', email: 'dummy@canopas.com');

  group('Join space test', () {
    test('Fetch spaces success test', () {
      when(spaceService.getSpacesOfUser('uid'))
          .thenAnswer((_) async => [space]);
      bloc.add(JoinSpaceInitialFetchEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            const JoinSpaceState(fetchSpaceStatus: Status.loading),
            JoinSpaceState(fetchSpaceStatus: Status.success, spaces: [space]),
          ]));
    });

    test('Fetch spaces failure test', () {
      when(spaceService.getSpacesOfUser('uid')).thenThrow(Exception('error'));
      bloc.add(JoinSpaceInitialFetchEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            const JoinSpaceState(fetchSpaceStatus: Status.loading),
            const JoinSpaceState(
                fetchSpaceStatus: Status.error, error: firestoreFetchDataError),
          ]));
    });

    test('Change space success test', () async {
      when(employeeService.getEmployeeBySpaceId(
              userId: 'uid', spaceId: space.id))
          .thenAnswer((_) async => employee);
      bloc.add(SelectSpaceEvent(space: space));
      expect(
          bloc.stream,
          emitsInOrder([
            const JoinSpaceState(selectSpaceStatus: Status.loading),
            const JoinSpaceState(selectSpaceStatus: Status.success),
          ]));
      await untilCalled(userManager.setSpace(space: space, spaceUser: employee));
      verify(userManager.setSpace(space: space, spaceUser: employee)).called(1);
    });

    test('Change space failure test', () {
      when(employeeService.getEmployeeBySpaceId(
              userId: 'uid', spaceId: space.id))
          .thenThrow(Exception('error'));
      bloc.add(SelectSpaceEvent(space: space));
      expect(
          bloc.stream,
          emitsInOrder([
            const JoinSpaceState(selectSpaceStatus: Status.loading),
            const JoinSpaceState(
                selectSpaceStatus: Status.error,
                error: firestoreFetchDataError),
          ]));
    });
  });
}
