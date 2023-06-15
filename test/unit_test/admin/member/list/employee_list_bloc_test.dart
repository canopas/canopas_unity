import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/model/invitation/invitation.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/invitation_services.dart';
import 'package:projectunity/ui/admin/members/list/bloc/member_list_bloc.dart';
import 'package:projectunity/ui/admin/members/list/bloc/member_list_state.dart';

import 'employee_list_bloc_test.mocks.dart';

@GenerateMocks([EmployeeService, UserStateNotifier, InvitationService])
void main() {
  late EmployeeService employeeService;
  late AdminMembersBloc employeeListBloc;
  late UserStateNotifier userStateNotifier;
  late InvitationService invitationService;

  const employee = Employee(
    uid: 'id',
    role: Role.admin,
    name: 'Andrew jhone',
    employeeId: 'CA 1254',
    email: 'andrew.j@canopas.com',
    designation: 'Android developer',
    dateOfJoining: 11,
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

    test('Emits initial state after member list screen is open ', () {
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
  });
}
