import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_bloc.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_event.dart';
import 'package:projectunity/ui/user/leaves/detail/bloc/user_leave_detail_state.dart';

import 'user_leave_detail_bloc_test.mocks.dart';

@GenerateMocks([LeaveService])
void main() {
  late LeaveService leaveService;
  late UserLeaveDetailBloc userLeaveDetailBloc;
  const String leaveId = 'leave-id';
  Leave? upcomingLeave;
  Leave? pastLeave;
  setUp(() {
    leaveService = MockLeaveService();
    userLeaveDetailBloc = UserLeaveDetailBloc(leaveService);
    upcomingLeave = Leave(
        leaveId: 'leaveId',
        uid: 'Uid',
        type: 5,
        startDate: DateTime.now().add(const Duration(days: 2)).timeStampToInt,
        endDate: DateTime.now().add(const Duration(days: 3)).timeStampToInt,
        total: 1,
        reason: 'Suffering from viral fever',
        status: LeaveStatus.pending,
        appliedOn: DateTime.now().timeStampToInt,
        perDayDuration: const [LeaveDayDuration.firstHalfLeave]);

    pastLeave = Leave(
        leaveId: 'leaveId',
        uid: 'Uid',
        type: 5,
        startDate:
            DateTime.now().subtract(const Duration(days: 3)).timeStampToInt,
        endDate:
            DateTime.now().subtract(const Duration(days: 2)).timeStampToInt,
        total: 1,
        reason: 'Suffering from viral fever',
        status: LeaveStatus.pending,
        appliedOn:
            DateTime.now().subtract(const Duration(days: 4)).timeStampToInt,
        perDayDuration: const [LeaveDayDuration.firstHalfLeave]);
  });

  group('User leave Detail bloc state', () {
    test('Emits initial state as state of bloc', () {
      expect(userLeaveDetailBloc.state, UserLeaveDetailInitialState());
    });

    test(
        'Emits Loading state and successState if leave data fetched successfully from firestore respectively ',
        () {
      userLeaveDetailBloc.add(FetchLeaveDetailEvent(leaveId: leaveId));

      when(leaveService.fetchLeave(leaveId))
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

      when(leaveService.fetchLeave(leaveId)).thenAnswer((_) async => pastLeave);
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
      when(leaveService.fetchLeave(leaveId))
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
      when(leaveService.fetchLeave(leaveId)).thenAnswer((_) async => null);
      userLeaveDetailBloc.add(FetchLeaveDetailEvent(leaveId: leaveId));
      expectLater(
          userLeaveDetailBloc.stream,
          emitsInOrder([
            UserLeaveDetailLoadingState(),
            UserLeaveDetailErrorState(error: firestoreFetchDataError)
          ]));
    });

    test('Emit success state if leave canceled', () {
      userLeaveDetailBloc.add(CancelLeaveApplicationEvent(leaveId: leaveId));
      expectLater(
          userLeaveDetailBloc.stream,
          emitsInOrder(
              [UserLeaveDetailLoadingState(), UserCancelLeaveSuccessState()]));
    });

    test('Emit failure state if leave canceled', () {
      when(leaveService.updateLeaveStatus(id: leaveId, status: LeaveStatus.cancelled)).thenThrow(Exception('error'));
      userLeaveDetailBloc.add(CancelLeaveApplicationEvent(leaveId: leaveId));
      expectLater(
          userLeaveDetailBloc.stream,
          emitsInOrder(
              [UserLeaveDetailLoadingState(), UserLeaveDetailErrorState(error: firestoreFetchDataError)]));
    });
  });
}
