import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/extensions/list.dart';
import 'package:projectunity/data/model/pagination/pagination.dart';
import 'package:projectunity/data/repo/leave_repo.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_bloc.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_event.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/bloc/leaves/user_leave_state.dart';

import 'user_leave_bloc_test.mocks.dart';

@GenerateMocks([LeaveRepo, UserStateNotifier, DocumentSnapshot])
void main() {
  late LeaveRepo leaveRepo;
  late UserStateNotifier userStateNotifier;
  late UserLeaveBloc bloc;

  const String employeeId = 'CA 1044';
  DateTime today = DateTime.now().dateOnly;

  Leave initialLeave = Leave(
      leaveId: 'Leave Id',
      uid: "user id",
      type: LeaveType.urgentLeave,
      startDate: today.add(const Duration(days: 1)),
      endDate: today.add(const Duration(days: 2)),
      total: 2,
      reason: 'Suffering from viral fever',
      status: LeaveStatus.pending,
      appliedOn: today,
      perDayDuration: const [
        LeaveDayDuration.firstHalfLeave,
        LeaveDayDuration.firstHalfLeave
      ]);

  Leave initialLeaveWithChange = Leave(
      leaveId: 'Leave Id',
      uid: "user id",
      type: LeaveType.urgentLeave,
      startDate: today.add(const Duration(days: 1)),
      endDate: today.add(const Duration(days: 2)),
      total: 2,
      reason: 'Suffering from viral fever',
      status: LeaveStatus.cancelled,
      appliedOn: today,
      perDayDuration: const [
        LeaveDayDuration.firstHalfLeave,
        LeaveDayDuration.firstHalfLeave
      ]);

  Leave moreLeave = Leave(
      leaveId: 'Leave-Id',
      uid: "user id",
      type: LeaveType.urgentLeave,
      startDate: today.subtract(const Duration(days: 2)),
      endDate: today.subtract(const Duration(days: 1)),
      total: 1,
      reason: 'Suffering from viral fever',
      status: LeaveStatus.approved,
      appliedOn: today,
      perDayDuration: const [LeaveDayDuration.firstHalfLeave]);

  group('User Leaves Test', () {
    group('User Leave initial fetch data test', () {
      final lastDoc = MockDocumentSnapshot<Leave>();

      setUp(() {
        leaveRepo = MockLeaveRepo();
        userStateNotifier = MockUserStateNotifier();
        bloc = UserLeaveBloc(userStateNotifier, leaveRepo);
      });

      tearDown(() async {
        await bloc.close();
      });

      test('Emits initial state of UserLeavesBloc', () {
        expect(
            bloc.state,
            const UserLeaveState(
                fetchMoreDataStatus: Status.initial,
                casualLeaves: {},
                error: null,
                status: Status.initial));
      });

      test('Load initial leave success test', () {
        when(userStateNotifier.employeeId).thenReturn(employeeId);
        when(leaveRepo.leaves(uid: employeeId)).thenAnswer((_) async =>
            PaginatedLeaves(leaves: [initialLeave], lastDoc: lastDoc));
        bloc.add(LoadInitialUserLeaves());
        expectLater(
            bloc.stream,
            emitsInOrder([
              const UserLeaveState(status: Status.loading),
              UserLeaveState(
                  status: Status.success,
                  casualLeaves: [initialLeave]
                      .groupByMonth((element) => element.appliedOn)),
            ]));
      });

      test('Load initial leave failure test', () {
        when(userStateNotifier.employeeId).thenReturn(employeeId);
        when(leaveRepo.leaves(uid: employeeId)).thenThrow(Exception('error'));
        bloc.add(LoadInitialUserLeaves());
        expectLater(
            bloc.stream,
            emitsInOrder([
              const UserLeaveState(status: Status.loading),
              const UserLeaveState(
                  status: Status.error, error: firestoreFetchDataError),
            ]));
      });

      test('Add applied leaves on leave list test', () {
        when(leaveRepo.fetchLeave(leaveId: initialLeave.leaveId))
            .thenAnswer((realInvocation) async => initialLeave);
        bloc.add(UpdateLeave(leaveId: initialLeave.leaveId));
        expectLater(
            bloc.stream,
            emits(UserLeaveState(
                casualLeaves: [initialLeave]
                    .groupByMonth((element) => element.appliedOn))));
      });
    });

    group('User Leave fetch more data success test', () {
      final lastDoc = MockDocumentSnapshot<Leave>();
      final moreDataLastDoc = MockDocumentSnapshot<Leave>();

      setUpAll(() {
        leaveRepo = MockLeaveRepo();
        userStateNotifier = MockUserStateNotifier();
        bloc = UserLeaveBloc(userStateNotifier, leaveRepo);
      });

      tearDownAll(() async {
        await bloc.close();
      });

      test('Load initial leave success test', () {
        when(userStateNotifier.employeeId).thenReturn(employeeId);
        when(leaveRepo.leaves(uid: employeeId)).thenAnswer((_) async =>
            PaginatedLeaves(leaves: [initialLeave], lastDoc: lastDoc));
        bloc.add(LoadInitialUserLeaves());
        expectLater(
            bloc.stream,
            emitsInOrder([
              const UserLeaveState(status: Status.loading),
              UserLeaveState(
                  status: Status.success,
                  casualLeaves: [initialLeave]
                      .groupByMonth((element) => element.appliedOn)),
            ]));
      });

      test('fetch more data leave success test', () {
        when(leaveRepo.leaves(uid: employeeId, lastDoc: lastDoc)).thenAnswer(
            (_) async =>
                PaginatedLeaves(leaves: [moreLeave], lastDoc: moreDataLastDoc));
        bloc.add(FetchMoreUserLeaves());
        expectLater(
            bloc.stream,
            emitsInOrder([
              UserLeaveState(
                  fetchMoreDataStatus: Status.loading,
                  status: Status.success,
                  casualLeaves: [initialLeave]
                      .groupByMonth((element) => element.appliedOn)),
              UserLeaveState(
                  fetchMoreDataStatus: Status.success,
                  status: Status.success,
                  casualLeaves: [initialLeave, moreLeave]
                      .groupByMonth((element) => element.appliedOn)),
            ]));
      });

      test('Update leaves on list test', () {
        when(leaveRepo.fetchLeave(leaveId: initialLeave.leaveId))
            .thenAnswer((realInvocation) async => initialLeaveWithChange);
        bloc.add(UpdateLeave(leaveId: initialLeave.leaveId));
        expectLater(
            bloc.stream,
            emits(UserLeaveState(
                fetchMoreDataStatus: Status.success,
                status: Status.success,
                casualLeaves: [moreLeave, initialLeaveWithChange]
                    .groupByMonth((element) => element.appliedOn))));
      });
    });

    group('User Leave fetch more data failure test', () {
      final lastDoc = MockDocumentSnapshot<Leave>();

      setUpAll(() {
        leaveRepo = MockLeaveRepo();
        userStateNotifier = MockUserStateNotifier();
        bloc = UserLeaveBloc(userStateNotifier, leaveRepo);
      });

      tearDownAll(() async {
        await bloc.close();
      });

      test('Load initial leave success test', () {
        when(userStateNotifier.employeeId).thenReturn(employeeId);
        when(leaveRepo.leaves(uid: employeeId)).thenAnswer((_) async =>
            PaginatedLeaves(leaves: [initialLeave], lastDoc: lastDoc));
        bloc.add(LoadInitialUserLeaves());
        expectLater(
            bloc.stream,
            emitsInOrder([
              const UserLeaveState(status: Status.loading),
              UserLeaveState(
                  status: Status.success,
                  casualLeaves: [initialLeave]
                      .groupByMonth((element) => element.appliedOn)),
            ]));
      });

      test('fetch more data leave failure test', () {
        when(leaveRepo.leaves(uid: employeeId, lastDoc: lastDoc))
            .thenThrow(Exception('error'));
        bloc.add(FetchMoreUserLeaves());
        expectLater(
            bloc.stream,
            emitsInOrder([
              UserLeaveState(
                  fetchMoreDataStatus: Status.loading,
                  status: Status.success,
                  casualLeaves: [initialLeave]
                      .groupByMonth((element) => element.appliedOn)),
              UserLeaveState(
                  fetchMoreDataStatus: Status.error,
                  error: firestoreFetchDataError,
                  status: Status.success,
                  casualLeaves: [initialLeave]
                      .groupByMonth((element) => element.appliedOn)),
            ]));
      });
    });
  });
}
