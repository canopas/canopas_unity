import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/services/user/user_leave_service.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_bloc.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_event.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_state.dart';

import 'user_leave_detail_bloc_test.mocks.dart';

@GenerateMocks([UserLeaveService])
void main() {
  late UserLeaveService userLeaveService;
  late UserLeaveDetailBloc userLeaveDetailBloc;
  const String leaveId = 'leave-id';
  Leave? upcomingLeave;
  Leave? pastLeave;
  setUp(() {
    userLeaveService = MockUserLeaveService();
    userLeaveDetailBloc = UserLeaveDetailBloc(userLeaveService);
    upcomingLeave = Leave(
        leaveId: 'leaveId',
        uid: 'Uid',
        leaveType: 5,
        startDate: DateTime.now().add(const Duration(days: 2)).timeStampToInt,
        endDate: DateTime.now().add(const Duration(days: 3)).timeStampToInt,
        totalLeaves: 1,
        reason: 'Suffering from viral fever',
        leaveStatus: 1,
        appliedOn: DateTime.now().timeStampToInt,
        perDayDuration: const [1]);

    pastLeave = Leave(
        leaveId: 'leaveId',
        uid: 'Uid',
        leaveType: 5,
        startDate:
            DateTime.now().subtract(const Duration(days: 3)).timeStampToInt,
        endDate:
            DateTime.now().subtract(const Duration(days: 2)).timeStampToInt,
        totalLeaves: 1,
        reason: 'Suffering from viral fever',
        leaveStatus: 1,
        appliedOn:
            DateTime.now().subtract(const Duration(days: 4)).timeStampToInt,
        perDayDuration: const [1]);
  });

  group('User leave Detail bloc state', () {
    test('Emits initial state as state of bloc', () {
      expect(userLeaveDetailBloc.state, UserLeaveDetailInitialState());
    });

    test(
        'Emits Loading state and successState if leave data fetched successfully from firestore respectively ',
        () {
      userLeaveDetailBloc.add(FetchLeaveDetailEvent(leaveId: leaveId));

      when(userLeaveService.fetchLeave(leaveId))
          .thenAnswer((_) async => upcomingLeave);
      expectLater(
          userLeaveDetailBloc.stream,
          emitsInOrder([
            UserLeaveDetailLoadingState(),
            UserLeaveDetailSuccessState(
                leave: upcomingLeave!, showCancelButton: true)
          ]));
    });
    test(
        'Emits success state with showCancelButton flag as false if leave is in past days',
        () {
      userLeaveDetailBloc.add(FetchLeaveDetailEvent(leaveId: leaveId));

      when(userLeaveService.fetchLeave(leaveId))
          .thenAnswer((_) async => pastLeave);
      expectLater(
          userLeaveDetailBloc.stream,
          emitsInOrder([
            UserLeaveDetailLoadingState(),
            UserLeaveDetailSuccessState(
                leave: pastLeave!, showCancelButton: false)
          ]));
    });

    test(
        'Emits loading state and error state if exception is thrown from firestore',
        () {
      when(userLeaveService.fetchLeave(leaveId))
          .thenThrow(Exception(firestoreFetchDataError));
      userLeaveDetailBloc.add(FetchLeaveDetailEvent(leaveId: leaveId));
      expectLater(
          userLeaveDetailBloc.stream,
          emitsInOrder([
            UserLeaveDetailLoadingState(),
            UserLeaveDetailErrorState(error: firestoreFetchDataError)
          ]));
    });
    test(
        'Emits loading state and error state if leaveId is not matched with any document reference and found null from firestore',
        () {
      when(userLeaveService.fetchLeave(leaveId)).thenAnswer((_) async => null);
      userLeaveDetailBloc.add(FetchLeaveDetailEvent(leaveId: leaveId));
      expectLater(
          userLeaveDetailBloc.stream,
          emitsInOrder([
            UserLeaveDetailLoadingState(),
            UserLeaveDetailErrorState(error: firestoreFetchDataError)
          ]));
    });
  });
}
