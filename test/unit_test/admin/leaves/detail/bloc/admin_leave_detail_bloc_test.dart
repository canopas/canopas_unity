import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/services/admin/leave_service.dart';
import 'package:projectunity/services/admin/paid_leave_service.dart';
import 'package:projectunity/services/user/user_leave_service.dart';
import 'package:projectunity/ui/admin/leaves/detail/bloc/admin_leave_detail_bloc.dart';
import 'package:projectunity/ui/admin/leaves/detail/bloc/admin_leave_detail_event.dart';
import 'package:projectunity/ui/admin/leaves/detail/bloc/admin_leave_detail_state.dart';

import 'admin_leave_detail_bloc_test.mocks.dart';

@GenerateMocks(
    [UserLeaveService, AdminLeaveService, UserManager, PaidLeaveService])
void main() {
  late UserLeaveService userLeaveService;
  late UserManager userManager;
  late AdminLeaveDetailBloc bloc;
  late PaidLeaveService paidLeaveService;

  setUp(() {
    userLeaveService = MockUserLeaveService();
    userManager = MockUserManager();
    paidLeaveService = MockPaidLeaveService();
    bloc = AdminLeaveDetailBloc(userLeaveService, paidLeaveService);
    when(userManager.employeeId).thenReturn("id");
  });

  group('Leave Application Detail bloc', () {
    test('Emits LeaveApplicationInitialState as state of bloc', () {
      expect(bloc.state, AdminLeaveDetailInitialState());
    });
    test(
        'Emits loading state and success state respectively if leave counts are fetched successfully from firestore',
        () {
      when(userLeaveService.getUserUsedLeaveCount('id'))
          .thenAnswer((_) async => 10);
      when(paidLeaveService.getPaidLeaves()).thenAnswer((_) async => 12);
      expectLater(
          bloc.stream,
          emitsInOrder([
            AdminLeaveDetailLoadingState(),
            AdminLeaveDetailSuccessState(usedLeaves: 10, paidLeaves: 12)
          ]));
      bloc.add(FetchLeaveApplicationDetailEvent(employeeId: 'id'));
    });
  });

  test(
      'Emits loading state and failure state respectively if Exception is thrown from firestore',
      () {
    when(userLeaveService.getUserUsedLeaveCount('id'))
        .thenThrow(Exception(firestoreFetchDataError));
    when(paidLeaveService.getPaidLeaves()).thenAnswer((_) async => 12);
    expectLater(
        bloc.stream,
        emitsInOrder([
          AdminLeaveDetailLoadingState(),
          AdminLeaveDetailFailureState(error: firestoreFetchDataError)
        ]));
    bloc.add(FetchLeaveApplicationDetailEvent(employeeId: 'id'));
  });

  group("delete Leave Application", () {
    test(
        'Emits Loading state and success state when application is deleted successfully from firestore',
        () {
      when(userLeaveService.deleteLeaveRequest('leaveId'))
          .thenAnswer((_) async => {});
      expectLater(
          bloc.stream,
          emitsInOrder([
            DeleteLeaveApplicationLoadingState(),
            DeleteLeaveApplicationSuccessState()
          ]));
      bloc.add(DeleteLeaveApplicationEvent('leaveId'));
    });

    test(
        'Emits Loading state and error state when exception is thrown from firestore',
        () {
      when(userLeaveService.deleteLeaveRequest('leaveId'))
          .thenThrow(Exception(firestoreFetchDataError));
      expectLater(
          bloc.stream,
          emitsInOrder([
            DeleteLeaveApplicationLoadingState(),
            AdminLeaveDetailFailureState(error: firestoreFetchDataError)
          ]));
      bloc.add(DeleteLeaveApplicationEvent('leaveId'));
    });
  });
}
