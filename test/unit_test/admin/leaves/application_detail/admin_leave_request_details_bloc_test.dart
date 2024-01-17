import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/model/leave_count.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/repo/leave_repo.dart';
import 'package:projectunity/data/services/mail_notification_service.dart';
import 'package:projectunity/data/services/space_service.dart';
import 'package:projectunity/ui/admin/leaves/details/bloc/admin_leave_details_bloc.dart';
import 'package:projectunity/ui/admin/leaves/details/bloc/admin_leave_details_event.dart';
import 'package:projectunity/ui/admin/leaves/details/bloc/admin_leave_details_state.dart';

import 'admin_leave_request_details_bloc_test.mocks.dart';

@GenerateMocks(
    [LeaveRepo, UserStateNotifier, SpaceService, NotificationService])
void main() {
  late LeaveRepo leaveRepo;
  late AdminLeaveDetailsBloc bloc;
  late NotificationService notificationService;

  setUp(() {
    leaveRepo = MockLeaveRepo();
    notificationService = MockNotificationService();
    bloc = AdminLeaveDetailsBloc(leaveRepo, notificationService);
  });

  group('Leave Application Detail bloc', () {
    group('test for Leave Count state', () {
      AdminLeaveDetailsState leaveCountLoadingState =
          const AdminLeaveDetailsState(
              adminReply: '',
              usedLeavesCount: LeaveCounts(),
              error: null,
              leaveCountStatus: Status.loading,
              actionStatus: Status.initial);

      test(
          'Emits loading state and success state respectively if leave counts are fetched successfully from firestore',
          () {
        when(leaveRepo.getUserUsedLeaves(uid: 'id')).thenAnswer(
            (_) async => const LeaveCounts(casualLeaves: 5, urgentLeaves: 5));
        AdminLeaveDetailsState successState = const AdminLeaveDetailsState(
            adminReply: '',
            usedLeavesCount: LeaveCounts(casualLeaves: 5, urgentLeaves: 5),
            error: null,
            actionStatus: Status.initial,
            leaveCountStatus: Status.success);
        expectLater(
            bloc.stream, emitsInOrder([leaveCountLoadingState, successState]));
        bloc.add(AdminLeaveDetailsFetchLeaveCountEvent(employeeId: 'id'));
      });

      test(
          'Emits loading state and error state if exception is thrown from any cause',
          () {
        when(leaveRepo.getUserUsedLeaves(uid: 'id'))
            .thenThrow(Exception('error'));
        AdminLeaveDetailsState errorState = const AdminLeaveDetailsState(
            adminReply: '',
            usedLeavesCount: LeaveCounts(),
            error: firestoreFetchDataError,
            actionStatus: Status.initial,
            leaveCountStatus: Status.error);
        expectLater(
            bloc.stream, emitsInOrder([leaveCountLoadingState, errorState]));
        bloc.add(AdminLeaveDetailsFetchLeaveCountEvent(employeeId: 'id'));
      });
    });

    group('Response to leave Application', () {
      AdminLeaveDetailsState responseLoadingState =
          const AdminLeaveDetailsState(
              adminReply: '',
              usedLeavesCount: LeaveCounts(),
              actionStatus: Status.loading,
              leaveCountStatus: Status.initial,
              error: null);
      test('Emits state with input of admin reply for reason', () {
        bloc.add(ReasonChangedEvent('Your leave request has been approved'));
        AdminLeaveDetailsState stateWithAdminReply =
            const AdminLeaveDetailsState(
                adminReply: 'Your leave request has been approved');
        expectLater(bloc.stream, emitsInOrder([stateWithAdminReply]));
      });

      test(
          "emits successState if leave application has been approved successfully",
          () {
        when(notificationService.leaveResponse(
                name: "dummy",
                receiver: "dummy@canopas.com",
                endDate: DateTime.now().dateOnly,
                startDate: DateTime.now().dateOnly,
                status: LeaveStatus.approved))
            .thenAnswer((realInvocation) async => true);
        bloc.add(LeaveResponseEvent(
            name: "dummy",
            email: "dummy@canopas.com",
            endDate: DateTime.now().dateOnly,
            startDate: DateTime.now().dateOnly,
            responseStatus: LeaveStatus.approved,
            leaveId: 'leave-id'));
        AdminLeaveDetailsState responseSuccessState =
            const AdminLeaveDetailsState(actionStatus: Status.success);
        expectLater(bloc.stream,
            emitsInOrder([responseLoadingState, responseSuccessState]));
      });

      test(
          "emits successState if leave application has been rejected successfully",
          () {
        when(notificationService.leaveResponse(
                name: "dummy",
                receiver: "dummy@canopas.com",
                endDate: DateTime.now().dateOnly,
                startDate: DateTime.now().dateOnly,
                status: LeaveStatus.rejected))
            .thenAnswer((realInvocation) async => true);
        bloc.add(LeaveResponseEvent(
            name: "dummy",
            email: "dummy@canopas.com",
            endDate: DateTime.now().dateOnly,
            startDate: DateTime.now().dateOnly,
            responseStatus: LeaveStatus.rejected,
            leaveId: 'leave-id'));
        AdminLeaveDetailsState responseSuccessState =
            const AdminLeaveDetailsState(actionStatus: Status.success);
        expectLater(bloc.stream,
            emitsInOrder([responseLoadingState, responseSuccessState]));
      });

      test(
          "emits successState if leave application has been cancelled successfully",
          () {
        when(notificationService.leaveResponse(
                name: "dummy",
                receiver: "dummy@canopas.com",
                endDate: DateTime.now().dateOnly,
                startDate: DateTime.now().dateOnly,
                status: LeaveStatus.cancelled))
            .thenAnswer((realInvocation) async => true);
        bloc.add(LeaveResponseEvent(
            name: "dummy",
            email: "dummy@canopas.com",
            endDate: DateTime.now().dateOnly,
            startDate: DateTime.now().dateOnly,
            responseStatus: LeaveStatus.cancelled,
            leaveId: 'leave-id'));
        AdminLeaveDetailsState responseSuccessState =
            const AdminLeaveDetailsState(actionStatus: Status.success);

        expectLater(bloc.stream,
            emitsInOrder([responseLoadingState, responseSuccessState]));
      });
      test(
          'Emits loading state and error state if exception is thrown from any cause while updating response',
          () {
        when(notificationService.leaveResponse(
                name: "dummy",
                receiver: "dummy@canopas.com",
                endDate: DateTime.now().dateOnly,
                startDate: DateTime.now().dateOnly,
                status: LeaveStatus.approved))
            .thenAnswer((realInvocation) async => true);
        when(leaveRepo.updateLeaveStatus(
                leaveId: "leave-id",
                status: LeaveStatus.approved,
                response: ''))
            .thenThrow(Exception(firestoreFetchDataError));
        bloc.add(LeaveResponseEvent(
            name: "dummy",
            email: "dummy@canopas.com",
            endDate: DateTime.now().dateOnly,
            startDate: DateTime.now().dateOnly,
            responseStatus: LeaveStatus.approved,
            leaveId: 'leave-id'));
        AdminLeaveDetailsState errorState = const AdminLeaveDetailsState(
            adminReply: '',
            usedLeavesCount: LeaveCounts(),
            error: firestoreFetchDataError,
            actionStatus: Status.error);
        expectLater(
            bloc.stream, emitsInOrder([responseLoadingState, errorState]));
      });
    });
  });
}
