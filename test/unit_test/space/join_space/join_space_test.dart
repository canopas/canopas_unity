import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/invitation/invitation.dart';
import 'package:projectunity/data/model/space/space.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/account_service.dart';
import 'package:projectunity/data/services/auth_service.dart';
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
  UserStateNotifier,
  AccountService,
  EmployeeService,
  AuthService
])
void main() {
  late SpaceService spaceService;
  late UserStateNotifier userStateNotifier;
  late EmployeeService employeeService;
  late InvitationService invitationService;
  late AccountService accountService;
  late AuthService authService;
  late JoinSpaceBloc bloc;
  const invitation = Invitation(
      id: 'id',
      spaceId: 'spaceId',
      senderId: 'senderId',
      receiverEmail: 'email');
  setUp(() {
    authService = MockAuthService();
    spaceService = MockSpaceService();
    userStateNotifier = MockUserStateNotifier();
    employeeService = MockEmployeeService();
    invitationService = MockInvitationService();
    accountService = MockAccountService();

    bloc = JoinSpaceBloc(invitationService, spaceService, userStateNotifier,
        accountService, employeeService, authService);
    when(userStateNotifier.userUID).thenReturn('uid');
    when(userStateNotifier.userEmail).thenReturn('email');
  });

  Space space = Space(
      id: "spaceId",
      name: 'dummy space',
      createdAt: DateTime.now(),
      paidTimeOff: 12,
      ownerIds: const ['uid']);

  final employee = Employee(
    uid: 'uid',
    name: 'dummy',
    email: 'dummy@canopas.com',
    role: Role.employee,
    dateOfJoining: DateTime(2000),
  );

  group('Fetch requested spaces', () {
    setUp(() {
      when(accountService.fetchSpaceIds(uid: 'uid'))
          .thenAnswer((_) async => []);
      when(invitationService.fetchSpaceInvitationsForUserEmail('email'))
          .thenAnswer((_) async => [invitation]);
    });
    test('Fetch spaces success test for requested spaces for user', () {
      when(spaceService.getSpace('spaceId')).thenAnswer((_) async => space);

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
    setUp(() {
      when(accountService.fetchSpaceIds(uid: 'uid'))
          .thenAnswer((_) async => [space.id]);
      when(invitationService.fetchSpaceInvitationsForUserEmail('email'))
          .thenAnswer((_) async => []);
    });
    test('Fetch spaces success test of created space by user', () {
      when(spaceService.getSpace(space.id)).thenAnswer((_) async => space);
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
      when(spaceService.getSpace(space.id))
          .thenThrow(Exception(firestoreFetchDataError));
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
      when(userStateNotifier.setEmployeeWithSpace(
              space: space, spaceUser: employee))
          .thenAnswer((_) async {});
      when(userStateNotifier.userFirebaseAuthName).thenReturn(employee.name);
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
      when(userStateNotifier.setEmployeeWithSpace(
              space: space, spaceUser: employee))
          .thenAnswer((_) async {});
      when(userStateNotifier.userFirebaseAuthName).thenReturn(employee.name);
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
  group("sign out test ", () {
    test("sign out successful test with navigation test", () async {
      when(authService.signOutWithGoogle())
          .thenAnswer((_) => Future(() => true));
      bloc.add(SignOutEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            const JoinSpaceState(signOutStatus: Status.loading),
            const JoinSpaceState(signOutStatus: Status.success),
          ]));
      await untilCalled(userStateNotifier.removeAll());
      verify(userStateNotifier.removeAll()).called(1);
    });

    test("sign out failure test", () {
      when(authService.signOutWithGoogle())
          .thenAnswer((_) => Future(() => false));
      bloc.add(SignOutEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            const JoinSpaceState(signOutStatus: Status.loading),
            const JoinSpaceState(
                signOutStatus: Status.error, error: signOutError),
          ]));
    });

    test("sign out failure test on exception", () {
      when(authService.signOutWithGoogle()).thenThrow(Exception(signOutError));
      bloc.add(SignOutEvent());
      expect(
          bloc.stream,
          emitsInOrder([
            const JoinSpaceState(signOutStatus: Status.loading),
            const JoinSpaceState(
                signOutStatus: Status.error, error: signOutError),
          ]));
    });
  });
}
