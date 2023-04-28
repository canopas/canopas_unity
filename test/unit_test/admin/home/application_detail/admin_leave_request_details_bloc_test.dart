import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/core/utils/const/firestore.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:projectunity/data/services/space_service.dart';
import 'package:projectunity/ui/admin/home/application_detail/bloc/admin_leave_application_detail_bloc.dart';
import 'package:projectunity/ui/admin/home/application_detail/bloc/admin_leave_application_detail_event.dart';
import 'package:projectunity/ui/admin/home/application_detail/bloc/admin_leave_application_detail_state.dart';

import 'admin_leave_request_details_bloc_test.mocks.dart';

@GenerateMocks([LeaveService, UserManager, SpaceService])
void main() {
  late LeaveService leaveService;
  late AdminLeaveApplicationDetailsBloc bloc;
  late UserManager userManager;
  late SpaceService spaceService;

  setUp(() {
    leaveService = MockLeaveService();
    userManager = MockUserManager();
    spaceService = MockSpaceService();
    bloc = AdminLeaveApplicationDetailsBloc(leaveService, userManager,spaceService);
  });

  group('Leave Application Detail bloc', () {
    group('test for Leave Count state', () {
      AdminLeaveApplicationDetailsState leaveCountLoadingState =
          const AdminLeaveApplicationDetailsState(
              adminReply: '',
              paidLeaveCount: 0,
              usedLeaves: 0.0,
              error: null,
              adminLeaveCountStatus: Status.loading,
              status: Status.initial);

      test(
          'Emits loading state and success state respectively if leave counts are fetched successfully from firestore',
          () {
        when(leaveService.getUserUsedLeaves('id')).thenAnswer((_) async => 10);
        when(userManager.currentSpaceId).thenReturn('space-id');
        when(spaceService.getPaidLeaves(spaceId: 'space-id'))
            .thenAnswer((_) async => 12);

        AdminLeaveApplicationDetailsState successState =
            const AdminLeaveApplicationDetailsState(
                adminReply: '',
                paidLeaveCount: 12,
                usedLeaves: 10,
                error: null,
                status: Status.initial,
                adminLeaveCountStatus: Status.success);
        expectLater(
            bloc.stream, emitsInOrder([leaveCountLoadingState, successState]));
        bloc.add(AdminLeaveApplicationFetchLeaveCountEvent(employeeId: 'id'));
      });

      test(
          'Emits loading state and error state if exception is thrown from any cause',
          () {
            when(leaveService.getUserUsedLeaves('id')).thenAnswer((_) async => 10);
        when(userManager.currentSpaceId).thenReturn('space-id');
        when(spaceService.getPaidLeaves(spaceId: 'space-id'))
            .thenThrow(Exception(firestoreFetchDataError));
        AdminLeaveApplicationDetailsState errorState =
            const AdminLeaveApplicationDetailsState(
                adminReply: '',
                paidLeaveCount: 0,
                usedLeaves: 0,
                error: firestoreFetchDataError,
                status: Status.initial,
                adminLeaveCountStatus: Status.error);
        expectLater(
            bloc.stream, emitsInOrder([leaveCountLoadingState, errorState]));
        bloc.add(AdminLeaveApplicationFetchLeaveCountEvent(employeeId: 'id'));
      });
    });

    group('Response to leave Application', () {
      AdminLeaveApplicationDetailsState responseLoadingState =
          const AdminLeaveApplicationDetailsState(
              adminReply: '',
              paidLeaveCount: 0,
              usedLeaves: 0,
              status: Status.loading,
              adminLeaveCountStatus: Status.initial,
              error: null);
      test('Emits state with input of admin reply for reason', () {
        bloc.add(AdminLeaveApplicationReasonChangedEvent(
            'Your leave request has been approved'));
        AdminLeaveApplicationDetailsState stateWithAdminReply =
            const AdminLeaveApplicationDetailsState(
                adminReply: 'Your leave request has been approved');
        expectLater(bloc.stream, emitsInOrder([stateWithAdminReply]));
      });

      test(
          "emits successState if leave application has been approved successfully",
          () {
            when(leaveService.updateLeaveStatus("leave-id", {
          'leave_status': approveLeaveStatus,
          'rejection_reason': "Your leave request has been approved",
        })).thenAnswer((_) async => {});
        AdminLeaveApplicationDetailsState responseSuccessState =
            const AdminLeaveApplicationDetailsState(status: Status.success);

        expectLater(bloc.stream,
            emitsInOrder([responseLoadingState, responseSuccessState]));
        bloc.add(AdminLeaveResponseEvent(
            response: AdminLeaveResponse.approve, leaveId: 'leave-id'));
      });
      test(
          "emits successState if leave application has been rejected successfully",
          () {
            when(leaveService.updateLeaveStatus("leave-id", {
          'leave_status': rejectLeaveStatus,
          'rejection_reason': "Your leave request has not been approved",
        })).thenAnswer((_) async => {});
        AdminLeaveApplicationDetailsState responseSuccessState =
            const AdminLeaveApplicationDetailsState(status: Status.success);

        expectLater(bloc.stream,
            emitsInOrder([responseLoadingState, responseSuccessState]));
        bloc.add(AdminLeaveResponseEvent(
            response: AdminLeaveResponse.reject, leaveId: 'leave-id'));
      });
      test(
          'Emits loading state and error state if exception is thrown from any cause while updating response',
          () {
            when(leaveService.updateLeaveStatus("leaveId", {
          FireStoreConst.leaveStatus: approveLeaveStatus,
          FireStoreConst.rejectionReason: '',
        })).thenThrow(Exception(firestoreFetchDataError));
        AdminLeaveApplicationDetailsState errorState =
            const AdminLeaveApplicationDetailsState(
                adminReply: '',
                paidLeaveCount: 0,
                usedLeaves: 0,
                error: firestoreFetchDataError,
                status: Status.loading,
                adminLeaveCountStatus: Status.error);
        expectLater(
            bloc.stream, emitsInOrder([responseLoadingState, errorState]));
        bloc.add(AdminLeaveResponseEvent(
            response: AdminLeaveResponse.approve, leaveId: 'leaveId'));
      });
    });
  });
}
