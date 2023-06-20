import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/invitation/invitation.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/invitation_services.dart';
import 'package:projectunity/ui/admin/members/list/bloc/member_list_bloc.dart';
import 'package:projectunity/ui/admin/members/list/bloc/member_list_event.dart';
import 'package:projectunity/ui/admin/members/list/bloc/member_list_state.dart';

import 'employee_list_bloc_test.mocks.dart';

@GenerateMocks([EmployeeService, UserStateNotifier, InvitationService])
void main() {
  late EmployeeService employeeService;
  late AdminMembersBloc employeeListBloc;
  late UserStateNotifier userStateNotifier;
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
    employeeService = MockEmployeeService();
    invitationService = MockInvitationService();
    userStateNotifier = MockUserStateNotifier();
  });

  group('Employee List Bloc', () {
    test('Emits initial state after member list screen is open ', () {
      when(employeeService.memberDBSnapshot())
          .thenAnswer((realInvocation) => Stream.value([employee]));
      employeeListBloc = AdminMembersBloc(
          employeeService, invitationService, userStateNotifier);
      expect(employeeListBloc.state, const AdminMembersState());
    });

    test(
        'Emits fetch members success state after listen database real-time updates',
        () {
      when(employeeService.memberDBSnapshot())
          .thenAnswer((realInvocation) => Stream.value([employee]));
      employeeListBloc = AdminMembersBloc(
          employeeService, invitationService, userStateNotifier);
      expect(employeeListBloc.state, const AdminMembersState());
      expectLater(
          employeeListBloc.stream,
          emitsInOrder([
            const AdminMembersState(
                members: [employee], fetchMemberStatus: Status.success)
          ]));
    });

    test(
        'Emits error members success state after listen database real-time updates',
        () {
      when(employeeService.memberDBSnapshot()).thenAnswer(
          (realInvocation) => Stream.error(firestoreFetchDataError));
      employeeListBloc = AdminMembersBloc(
          employeeService, invitationService, userStateNotifier);
      expect(employeeListBloc.state, const AdminMembersState());
      expectLater(
          employeeListBloc.stream,
          emitsInOrder([
            const AdminMembersState(
                error: firestoreFetchDataError, fetchMemberStatus: Status.error)
          ]));
    });

    test('Emits success status on fetch invitation test', () {
      when(userStateNotifier.currentSpaceId).thenReturn('space-id');
      when(invitationService.fetchSpaceInvitations(spaceId: 'space-id'))
          .thenAnswer((realInvocation) async => [invitation]);
      when(employeeService.memberDBSnapshot())
          .thenAnswer((realInvocation) => Stream.value([employee]));
      employeeListBloc = AdminMembersBloc(
          employeeService, invitationService, userStateNotifier);
      employeeListBloc.add(FetchInvitationEvent());
      expectLater(
          employeeListBloc.stream,
          emitsInOrder([
            const AdminMembersState(
              fetchInvitationStatus: Status.loading,
            ),
            const AdminMembersState(
              invitation: [invitation],
              fetchInvitationStatus: Status.success,
            ),
            const AdminMembersState(
                members: [employee],
                invitation: [invitation],
                fetchInvitationStatus: Status.success,
                fetchMemberStatus: Status.success)
          ]));
    });

    test('Emits failure status on fetch invitation test', () {
      when(userStateNotifier.currentSpaceId).thenReturn('space-id');
      when(invitationService.fetchSpaceInvitations(spaceId: 'space-id'))
          .thenThrow(Exception('error'));
      when(employeeService.memberDBSnapshot())
          .thenAnswer((realInvocation) => Stream.value([employee]));
      employeeListBloc = AdminMembersBloc(
          employeeService, invitationService, userStateNotifier);
      employeeListBloc.add(FetchInvitationEvent());
      expectLater(
          employeeListBloc.stream,
          emitsInOrder([
            const AdminMembersState(
              fetchInvitationStatus: Status.loading,
            ),
            const AdminMembersState(
              error: firestoreFetchDataError,
              fetchInvitationStatus: Status.error,
            ),
            const AdminMembersState(
                members: [employee],
                fetchInvitationStatus: Status.error,
                fetchMemberStatus: Status.success)
          ]));
    });
  });
}
