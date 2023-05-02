import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/invitation/invitation.dart';
import 'package:projectunity/data/model/space/space.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/account_service.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/invitation_services.dart';
import 'package:projectunity/data/services/space_service.dart';
import 'package:projectunity/ui/space/join_space/bloc/join_space_bloc.dart';
import 'package:projectunity/ui/space/join_space/bloc/join_space_event.dart';
import 'package:projectunity/ui/space/join_space/bloc/join_space_state.dart';

import 'join_space_test.mocks.dart';

@GenerateMocks([
  InvitationService,
  SpaceService,
  UserManager,
  AccountService,
  EmployeeService
])
void main() {
  late SpaceService spaceService;
  late UserManager userManager;
  late EmployeeService employeeService;
  late InvitationService invitationService;
  late AccountService accountService;
  late JoinSpaceBloc bloc;
  final invitation = Invitation(
      id: 'id',
      spaceId: 'spaceId',
      senderId: 'senderId',
      receiverEmail: 'email');
  setUp(() {
    spaceService = MockSpaceService();
    userManager = MockUserManager();
    employeeService = MockEmployeeService();
    invitationService = MockInvitationService();
    accountService = MockAccountService();

    bloc = JoinSpaceBloc(
      invitationService,
      spaceService,
      userManager,
      accountService,
      employeeService,
    );
    when(userManager.userUID).thenReturn('uid');
    when(userManager.userEmail).thenReturn('email');
    when(invitationService.fetchSpacesForUserEmail('email'))
        .thenAnswer((_) async => [invitation]);
  });

  Space space = Space(
      id: "spaceId",
      name: 'dummy space',
      createdAt: DateTime.now(),
      paidTimeOff: 12,
      ownerIds: ['uid']);

  const Employee employee =
      Employee(uid: 'uid', name: 'dummy', email: 'dummy@canopas.com');

  group('Fetch requested spaces', () {
    test('Fetch spaces success test for requested spaces for user', () {
      when(spaceService.getSpace('spaceId')).thenAnswer((_) async => space);
      when(spaceService.getSpacesOfUser('uid')).thenAnswer((_) async => []);
      bloc.add(JoinSpaceInitialFetchEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            const JoinSpaceState(fetchSpaceStatus: Status.loading),
            JoinSpaceState(
                fetchSpaceStatus: Status.success, requestedSpaces: [space]),
          ]));
    });
    test('Should emit error state if exception is thrown by firestore', () {
      when(spaceService.getSpace('spaceId'))
          .thenThrow(Exception(firestoreFetchDataError));
      when(spaceService.getSpacesOfUser('uid')).thenAnswer((_) async => []);
      bloc.add(JoinSpaceInitialFetchEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            const JoinSpaceState(fetchSpaceStatus: Status.loading),
            const JoinSpaceState(
                fetchSpaceStatus: Status.error, error: firestoreFetchDataError),
          ]));
    });
  });

  group('Join space test', () {
    test('Fetch spaces success test of created space by user', () {
      when(spaceService.getSpace(space.id)).thenAnswer((_) async => null);
      when(spaceService.getSpacesOfUser('uid'))
          .thenAnswer((_) async => [space]);
      bloc.add(JoinSpaceInitialFetchEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            const JoinSpaceState(fetchSpaceStatus: Status.loading),
            JoinSpaceState(
                fetchSpaceStatus: Status.success, ownSpaces: [space]),
          ]));
    });

    test('Fetch spaces failure test for created space by user', () {
      when(spaceService.getSpacesOfUser('uid')).thenThrow(Exception('error'));
      when(spaceService.getSpace(space.id)).thenAnswer((_) async => space);
      bloc.add(JoinSpaceInitialFetchEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            const JoinSpaceState(fetchSpaceStatus: Status.loading),
            const JoinSpaceState(
                fetchSpaceStatus: Status.error, error: firestoreFetchDataError),
          ]));
    });
  });

  group('Select SPace test', () {
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
      await untilCalled(
          userManager.setSpace(space: space, spaceUser: employee));
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

  group('Select space from Requests test', () {
    test(
        'Should emit loading and success state if user select space from requested spaces',
        () {
      bloc.invitations = [invitation];
      when(employeeService.addEmployeeBySpaceId(
              employee: employee, spaceId: space.id))
          .thenAnswer((_) async {});
      when(accountService.updateSpaceOfUser(spaceID: space.id, uid: 'uid'))
          .thenAnswer((_) async {});
      when(invitationService.deleteInvitation(id: invitation.id))
          .thenAnswer((_) async {});
      when(userManager.setSpace(space: space, spaceUser: employee))
          .thenAnswer((_) async {});
      when(userManager.userFirebaseAuthName).thenReturn(employee.name);
      bloc.add(JoinRequestedSpaceEvent(space: space));
      expectLater(
          bloc.stream,
          emitsInOrder([
            const JoinSpaceState(selectSpaceStatus: Status.loading),
            const JoinSpaceState(selectSpaceStatus: Status.success)
          ]));
    });

    test(
        'Should emit loading and error state if user select space from requested spaces and firestore trows exception',
        () {
      bloc.invitations = [invitation];
      when(employeeService.addEmployeeBySpaceId(
              employee: employee, spaceId: space.id))
          .thenThrow(Exception(firestoreFetchDataError));
      when(accountService.updateSpaceOfUser(spaceID: space.id, uid: 'uid'))
          .thenThrow(Exception(firestoreFetchDataError));
      when(invitationService.deleteInvitation(id: invitation.id))
          .thenAnswer((_) async {});
      when(userManager.setSpace(space: space, spaceUser: employee))
          .thenAnswer((_) async {});
      when(userManager.userFirebaseAuthName).thenReturn(employee.name);
      bloc.add(JoinRequestedSpaceEvent(space: space));
      expectLater(
          bloc.stream,
          emitsInOrder([
            const JoinSpaceState(selectSpaceStatus: Status.loading),
            const JoinSpaceState(
                selectSpaceStatus: Status.error, error: firestoreFetchDataError)
          ]));
    });
  });
}
