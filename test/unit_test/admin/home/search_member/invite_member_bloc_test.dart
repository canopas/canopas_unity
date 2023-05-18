import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/employee_service.dart';
import 'package:projectunity/data/services/invitation_services.dart';
import 'package:projectunity/ui/admin/home/invite_member/bloc/invite_member_bloc.dart';
import 'package:projectunity/ui/admin/home/invite_member/bloc/invite_member_event.dart';
import 'package:projectunity/ui/admin/home/invite_member/bloc/invite_member_state.dart';
import 'invite_member_bloc_test.mocks.dart';

@GenerateMocks([InvitationService, UserManager, EmployeeService])
void main() {
  late InviteMemberBloc inviteMemberBloc;
  late InvitationService invitationService;
  late EmployeeService employeeService;
  late UserManager userManager;

    setUp(() {
      userManager = MockUserManager();
      invitationService = MockInvitationService();
      employeeService = MockEmployeeService();
      inviteMemberBloc =
          InviteMemberBloc(invitationService, userManager, employeeService);
    });

    test('Should emit state initial state as default state ', () {
      expect(inviteMemberBloc.state,
          const InviteMemberState(status: Status.initial));
    });

    test(
        'Should emit state with emailError false if user has not added any input',
        () {
      expect(
          inviteMemberBloc.state, const InviteMemberState(emailError: false));
    });

    test(
        'Should emit state with input that contains properly formatted email if user add any input in textField',
        () {
      inviteMemberBloc.add(AddEmailEvent('Andrew.j@google.com'));
      expect(
          inviteMemberBloc.stream,
          emits(const InviteMemberState(
              email: 'Andrew.j@google.com', emailError: false)));
    });

    test(
        'Should emit error state with input that contains does not  properly formatted email if user add any input in textField',
        () {
      inviteMemberBloc.add(AddEmailEvent('Andrew'));
      expect(inviteMemberBloc.stream,
          emits(const InviteMemberState(email: 'Andrew', emailError: true)));
    });

    test(
        'Should emit loading and error state if email input is not valid on InviteMemberEvent',
        () {
      inviteMemberBloc.add(InviteMemberEvent());
      expect(
          inviteMemberBloc.stream,
          emitsInOrder([
            const InviteMemberState(status: Status.loading),
            const InviteMemberState(
                status: Status.error, error: provideRequiredInformation)
          ]));
    });

    test(
        'Should emit loading state and success state  if email input is valid on InviteMemberEvent',
        () async {
      when(userManager.userUID).thenReturn('uid');
      when(userManager.currentSpaceId).thenReturn('space_id');
      when(employeeService.hasUser('andrew.j@google.com'))
          .thenAnswer((realInvocation) async => false);
      when(invitationService.checkMemberInvitationAlreadyExist(
              spaceId: 'space_id', email: 'andrew.j@google.com'))
          .thenAnswer((realInvocation) async => false);
      when(invitationService.addInvitation(
              senderId: 'uid',
              spaceId: 'space_id',
              receiverEmail: 'andrew.j@google.com'))
          .thenAnswer((_) async => {});
      inviteMemberBloc.add(AddEmailEvent('andrew.j@google.com'));
      inviteMemberBloc.add(InviteMemberEvent());
      expectLater(
          inviteMemberBloc.stream,
          emitsInOrder([
            const InviteMemberState(
                status: Status.initial, email: 'andrew.j@google.com'),
            const InviteMemberState(
                status: Status.loading, email: 'andrew.j@google.com'),
            const InviteMemberState(
                status: Status.success, email: 'andrew.j@google.com')
          ]));
    });

    test(
        'Should emit loading state and error state  if Exception is thrown by firestore',
        () {
      when(invitationService.addInvitation(
              senderId: 'uid',
              spaceId: 'space_id',
              receiverEmail: 'andrew.j@google.com'))
          .thenThrow(Exception(firestoreFetchDataError));
      when(userManager.userUID).thenReturn('uid');
      when(userManager.currentSpaceId).thenReturn('space_id');
      when(employeeService.hasUser('andrew.j@google.com'))
          .thenAnswer((realInvocation) async => false);
      when(invitationService.checkMemberInvitationAlreadyExist(
              spaceId: 'space_id', email: 'andrew.j@google.com'))
          .thenAnswer((realInvocation) async => false);
      inviteMemberBloc.add(AddEmailEvent('andrew.j@google.com'));
      inviteMemberBloc.add(InviteMemberEvent());

      expectLater(
          inviteMemberBloc.stream,
          emitsInOrder([
            const InviteMemberState(
                status: Status.initial, email: 'andrew.j@google.com'),
            const InviteMemberState(
                status: Status.loading, email: 'andrew.j@google.com'),
            const InviteMemberState(
                status: Status.error,
                email: 'andrew.j@google.com',
                error: firestoreFetchDataError)
          ]));
    });

    test(
        'Should emit loading state and error state if user already invited exception',
        () {
      when(invitationService.addInvitation(
              senderId: 'uid',
              spaceId: 'space_id',
              receiverEmail: 'andrew.j@google.com'))
          .thenThrow(Exception(firestoreFetchDataError));
      when(userManager.userUID).thenReturn('uid');
      when(userManager.currentSpaceId).thenReturn('space_id');
      when(employeeService.hasUser('andrew.j@google.com'))
          .thenAnswer((realInvocation) async => true);
      when(invitationService.checkMemberInvitationAlreadyExist(
              spaceId: 'space_id', email: 'andrew.j@google.com'))
          .thenAnswer((realInvocation) async => true);
      inviteMemberBloc.add(AddEmailEvent('andrew.j@google.com'));
      inviteMemberBloc.add(InviteMemberEvent());

      expectLater(
          inviteMemberBloc.stream,
          emitsInOrder([
            const InviteMemberState(
                status: Status.initial, email: 'andrew.j@google.com'),
            const InviteMemberState(
                status: Status.loading, email: 'andrew.j@google.com'),
            const InviteMemberState(
                status: Status.error,
                email: 'andrew.j@google.com',
                error: userAlreadyInvited)
          ]));
    });
}
