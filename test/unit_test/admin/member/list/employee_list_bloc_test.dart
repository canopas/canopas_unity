import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
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
  late EmployeeListBloc employeeListBloc;
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

  setUpAll(() {
    employeeService = MockEmployeeService();
    invitationService = MockInvitationService();
    userStateNotifier = MockUserStateNotifier();
    employeeListBloc =
        EmployeeListBloc(employeeService, invitationService, userStateNotifier);
  });

  group('Employee List Bloc', () {
    test('Emits initial state after Employee list screen is open ', () {
      expect(employeeListBloc.state, EmployeeListInitialState());
    });

    test('Emits failure state when Exception is thrown from any cause', () {
      when(employeeService.getEmployees())
          .thenThrow(Exception(firestoreFetchDataError));
      EmployeeListState failureState =
          const EmployeeListFailureState(error: firestoreFetchDataError);
      employeeListBloc.add(EmployeeListInitialLoadEvent());
      expectLater(employeeListBloc.stream,
          emitsInOrder([EmployeeListLoadingState(), failureState]));
    });

    test(
        'Emits Loading state while fetching data from firestore and the Emits success state with list of employees and invitation',
        () {
      when(userStateNotifier.currentSpaceId).thenReturn('space-id');
      when(invitationService.fetchSpaceInvitations(spaceId: 'space-id'))
          .thenAnswer((_) async => [invitation]);
      when(employeeService.getEmployees())
          .thenAnswer((_) async => [employee, employee]);

      EmployeeListState successState = const EmployeeListSuccessState(
          employees: [employee, employee], invitation: [invitation]);

      employeeListBloc.add(EmployeeListInitialLoadEvent());
      expectLater(employeeListBloc.stream,
          emitsInOrder([EmployeeListLoadingState(), successState]));
    });
  });
}
