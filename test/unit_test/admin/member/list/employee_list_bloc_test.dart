import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/repo/employee_repo.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/invitation/invitation.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/invitation_services.dart';
import 'package:projectunity/ui/admin/members/list/bloc/member_list_bloc.dart';
import 'package:projectunity/ui/admin/members/list/bloc/member_list_event.dart';
import 'package:projectunity/ui/admin/members/list/bloc/member_list_state.dart';
import 'employee_list_bloc_test.mocks.dart';

@GenerateMocks([EmployeeRepo, UserStateNotifier, InvitationService])
void main() {
  late EmployeeRepo employeeRepo;
  late AdminMembersBloc bloc;
  late UserStateNotifier userStateNotifier;
  late InvitationService invitationService;

  final activeEmployee = Employee(
    uid: 'active-id',
    role: Role.admin,
    status: EmployeeStatus.active,
    name: 'Andrew jhone',
    employeeId: 'CA 1254',
    email: 'andrew.j@canopas.com',
    designation: 'Android developer',
    dateOfJoining: DateTime(2000),
  );

  final inactiveEmployee = Employee(
    uid: 'inactive-id',
    role: Role.employee,
    status: EmployeeStatus.inactive,
    name: 'Andrew jhone',
    employeeId: 'CA 1254',
    email: 'andrew.j@canopas.com',
    designation: 'Android developer',
    dateOfJoining: DateTime(2000),
  );

  const invitation = Invitation(
      id: 'id',
      spaceId: 'space-id',
      senderId: 'sender-id',
      receiverEmail: 'joi@canopas.com');

  setUp(() {
    employeeRepo = MockEmployeeRepo();
    invitationService = MockInvitationService();
    userStateNotifier = MockUserStateNotifier();
    bloc = AdminMembersBloc(employeeRepo, invitationService, userStateNotifier);
  });

  group('Employee List Bloc', () {
    test('Emits initial state after Employee list screen is open ', () {
      expect(bloc.state, const AdminMembersState());
    });

    test('Emits success after fetch data', () {
      when(userStateNotifier.currentSpaceId).thenReturn('space-id');
      when(employeeRepo.employees)
          .thenAnswer((_) => Stream.value([activeEmployee, inactiveEmployee]));
      when(invitationService.fetchSpaceInvitations(spaceId: 'space-id'))
          .thenAnswer((_) async => [invitation]);
      bloc.add(AdminMembersInitialLoadEvent());
      expectLater(
          bloc.stream,
          emitsInOrder([
            const AdminMembersState(
              invitationFetchStatus: Status.loading,
              memberFetchStatus: Status.loading,
            ),
            const AdminMembersState(
              invitationFetchStatus: Status.success,
              memberFetchStatus: Status.loading,
              invitation: [invitation],
            ),
            AdminMembersState(
                invitationFetchStatus: Status.success,
                memberFetchStatus: Status.success,
                activeMembers: [activeEmployee],
                inactiveMembers: [inactiveEmployee],
                invitation: const [invitation]),
          ]));
    });

    test('Emits failure state when Exception is thrown by invitation service',
        () {
      when(userStateNotifier.currentSpaceId).thenReturn('space-id');
      when(employeeRepo.employees)
          .thenAnswer((_) => Stream.value([activeEmployee, inactiveEmployee]));
      when(invitationService.fetchSpaceInvitations(spaceId: 'space-id'))
          .thenThrow(Exception());
      bloc.add(AdminMembersInitialLoadEvent());
      expectLater(
          bloc.stream,
          emitsInOrder([
            const AdminMembersState(
              invitationFetchStatus: Status.loading,
              memberFetchStatus: Status.loading,
            ),
            const AdminMembersState(
                invitationFetchStatus: Status.error,
                memberFetchStatus: Status.loading,
                error: firestoreFetchDataError),
            AdminMembersState(
              invitationFetchStatus: Status.error,
              memberFetchStatus: Status.success,
              activeMembers: [activeEmployee],
              inactiveMembers: [inactiveEmployee],
            ),
          ]));
    });

    test(
        'Emits failure state when Exception is thrown by real-time members service',
        () {
      when(userStateNotifier.currentSpaceId).thenReturn('space-id');
      when(employeeRepo.employees)
          .thenAnswer((_) => Stream.error(firestoreFetchDataError));
      when(invitationService.fetchSpaceInvitations(spaceId: 'space-id'))
          .thenAnswer((realInvocation) async => [invitation]);
      bloc.add(AdminMembersInitialLoadEvent());
      expectLater(
          bloc.stream,
          emitsInOrder([
            const AdminMembersState(
              invitationFetchStatus: Status.loading,
              memberFetchStatus: Status.loading,
            ),
            const AdminMembersState(
                invitationFetchStatus: Status.success,
                memberFetchStatus: Status.loading,
                invitation: [invitation]),
            const AdminMembersState(
                invitationFetchStatus: Status.success,
                memberFetchStatus: Status.error,
                invitation: [invitation],
                error: firestoreFetchDataError),
          ]));
    });

    test('Cancel invitation and fetch invitation success test', () {
      when(userStateNotifier.currentSpaceId).thenReturn('space-id');
      when(invitationService.fetchSpaceInvitations(spaceId: 'space-id'))
          .thenAnswer((realInvocation) async => [invitation]);
      bloc.add(CancelUserInvitation(invitation.id));
      expectLater(
          bloc.stream,
          emitsInOrder([
            const AdminMembersState(invitationFetchStatus: Status.loading),
            const AdminMembersState(
              invitationFetchStatus: Status.success,
              invitation: [invitation],
            ),
          ]));
    });
    test('Cancel invitation and fetch invitation failure test', () {
      when(userStateNotifier.currentSpaceId).thenReturn('space-id');
      when(invitationService.fetchSpaceInvitations(spaceId: 'space-id'))
          .thenThrow(Exception('error'));
      bloc.add(CancelUserInvitation(invitation.id));
      expectLater(
          bloc.stream,
          emitsInOrder([
            const AdminMembersState(invitationFetchStatus: Status.loading),
            const AdminMembersState(
              invitationFetchStatus: Status.error,
              error: firestoreFetchDataError,
            ),
          ]));
    });
  });
}
