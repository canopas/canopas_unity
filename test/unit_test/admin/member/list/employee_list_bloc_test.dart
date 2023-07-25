import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/Repo/employee_repo.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/invitation/invitation.dart';
import 'package:projectunity/data/provider/user_status_notifier.dart';
import 'package:projectunity/data/services/invitation_services.dart';
import 'package:projectunity/ui/admin/members/list/bloc/member_list_bloc.dart';
import 'package:projectunity/ui/admin/members/list/bloc/member_list_event.dart';
import 'package:projectunity/ui/admin/members/list/bloc/member_list_state.dart';
import 'employee_list_bloc_test.mocks.dart';

@GenerateMocks([EmployeeRepo, UserStatusNotifier, InvitationService])
void main() {
  late EmployeeRepo employeeRepo;
  late AdminMembersBloc bloc;
  late UserStatusNotifier userStateNotifier;
  late InvitationService invitationService;

  final employee = Employee(
    uid: 'id',
    role: Role.admin,
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
      when(employeeRepo.employees).thenAnswer((_) => Stream.value([employee]));
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
                members: [employee],
                invitation: const [invitation]),
          ]));
    });

    test('Emits failure state when Exception is thrown by invitation service',
        () {
      when(userStateNotifier.currentSpaceId).thenReturn('space-id');
      when(employeeRepo.employees).thenAnswer((_) => Stream.value([employee]));
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
                members: [employee],
                invitation: const []),
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
                members: [],
                invitation: [invitation],
                error: firestoreFetchDataError),
          ]));
    });
  });
}
