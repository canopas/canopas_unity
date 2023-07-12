import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:projectunity/ui/user/members/detail/bloc/user_employee_detail_bloc.dart';
import 'package:projectunity/ui/user/members/detail/bloc/user_employee_detail_event.dart';
import 'package:projectunity/ui/user/members/detail/bloc/user_employee_detail_state.dart';

import 'user_employee_detail_bloc_test.mocks.dart';

@GenerateMocks([LeaveService])
void main() {
  late LeaveService leaveService;
  late UserEmployeeDetailBloc bloc;

  Leave upcomingApproveLeave = Leave(
      leaveId: 'leaveId',
      uid: 'uid',
      type: LeaveType.annualLeave,
      startDate: DateTime.now().add(const Duration(days: 2)).dateOnly,
      endDate: DateTime.now().add(const Duration(days: 1)).dateOnly,
      total: 2,
      reason: 'Suffering from viral fever',
      status: LeaveStatus.approved,
      appliedOn: DateTime.now().dateOnly,
      perDayDuration: const [
        LeaveDayDuration.firstHalfLeave,
        LeaveDayDuration.firstHalfLeave
      ]);

  setUp(() {
    leaveService = MockLeaveService();
    bloc = UserEmployeeDetailBloc(leaveService);
  });

  group('bloc state stream', () {
    test('emits UserEmployeeDetail Initial state as state of bloc', () {
      expect(bloc.state, UserEmployeeDetailInitialState());
    });

    test(
        'Emits loading state and success state after data is fetched successfully from firestore',
        () {
      when(leaveService.getUpcomingLeavesOfUser('uid'))
          .thenAnswer((_) async => [upcomingApproveLeave]);
      expectLater(
          bloc.stream,
          emitsInOrder([
            UserEmployeeDetailLoadingState(),
            UserEmployeeDetailSuccessState(
                upcomingLeaves: [upcomingApproveLeave])
          ]));
      bloc.add(UserEmployeeDetailFetchEvent(uid: 'uid'));
    });
    test(
        'Emits loading state and error state if exception is thrown from firestore',
        () {
      when(leaveService.getUpcomingLeavesOfUser('uid'))
          .thenThrow(Exception(firestoreFetchDataError));
      expectLater(
          bloc.stream,
          emitsInOrder([
            UserEmployeeDetailLoadingState(),
            UserEmployeeDetailErrorState(error: firestoreFetchDataError)
          ]));
      bloc.add(UserEmployeeDetailFetchEvent(uid: 'uid'));
    });
  });
}
