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

  Leave casualLeave = Leave(
      leaveId: 'Leave Id',
      uid: "user id",
      type: LeaveType.casualLeave,
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
      type: LeaveType.casualLeave,
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

  Leave urgentLeave = Leave(
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
                urgentLeaves: {},
                error: null,
                status: Status.initial));
      });

      test('Load initial leave success test', () {
        when(userStateNotifier.employeeId).thenReturn(employeeId);
        when(leaveRepo.leaves(
                uid: employeeId, leaveType: LeaveType.casualLeave))
            .thenAnswer((_) async =>
                PaginatedLeaves(leaves: [casualLeave], lastDoc: lastDoc));
        when(leaveRepo.leaves(
                uid: employeeId, leaveType: LeaveType.urgentLeave))
            .thenAnswer((_) async =>
                PaginatedLeaves(leaves: [urgentLeave], lastDoc: lastDoc));
        bloc.add(LoadInitialUserLeaves());
        expectLater(
            bloc.stream,
            emitsInOrder([
              const UserLeaveState(status: Status.loading),
              UserLeaveState(
                  status: Status.success,
                  casualLeaves: [casualLeave]
                      .groupByMonth((element) => element.startDate),
                  urgentLeaves: [urgentLeave]
                      .groupByMonth((element) => element.startDate)),
            ]));
      });

      test('Load initial leave failure test', () {
        when(userStateNotifier.employeeId).thenReturn(employeeId);
        when(leaveRepo.leaves(
                uid: employeeId, leaveType: LeaveType.casualLeave))
            .thenThrow(Exception('error'));
        when(leaveRepo.leaves(
                uid: employeeId, leaveType: LeaveType.urgentLeave))
            .thenAnswer((_) async =>
                PaginatedLeaves(leaves: [urgentLeave], lastDoc: lastDoc));
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
        when(leaveRepo.fetchLeave(leaveId: casualLeave.leaveId))
            .thenAnswer((realInvocation) async => casualLeave);
        bloc.add(UpdateLeave(leaveId: casualLeave.leaveId));
        expectLater(
            bloc.stream,
            emits(UserLeaveState(
                casualLeaves: [casualLeave]
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

      test('Load initial leave success test for casualLeave', () {
        when(userStateNotifier.employeeId).thenReturn(employeeId);
        when(leaveRepo.leaves(
                uid: employeeId, leaveType: LeaveType.casualLeave))
            .thenAnswer((_) async =>
                PaginatedLeaves(leaves: [casualLeave], lastDoc: lastDoc));
        when(leaveRepo.leaves(
                uid: employeeId, leaveType: LeaveType.urgentLeave))
            .thenAnswer((_) async =>
                PaginatedLeaves(leaves: [urgentLeave], lastDoc: lastDoc));
        bloc.add(LoadInitialUserLeaves());
        expectLater(
            bloc.stream,
            emitsInOrder([
              const UserLeaveState(status: Status.loading),
              UserLeaveState(
                  status: Status.success,
                  casualLeaves: [casualLeave]
                      .groupByMonth((element) => element.startDate),
                  urgentLeaves: [urgentLeave]
                      .groupByMonth((element) => element.startDate)),
            ]));
      });

      test('fetch more data leave success test for Casual leave', () {
        when(leaveRepo.leaves(
                uid: employeeId,
                lastDoc: lastDoc,
                leaveType: LeaveType.casualLeave))
            .thenAnswer((_) async => PaginatedLeaves(
                leaves: [casualLeave], lastDoc: moreDataLastDoc));
        when(leaveRepo.leaves(
                uid: employeeId, leaveType: LeaveType.urgentLeave))
            .thenAnswer((_) async =>
                PaginatedLeaves(leaves: [casualLeave], lastDoc: lastDoc));
        bloc.add(FetchMoreUserLeaves(LeaveType.casualLeave));
        expectLater(
            bloc.stream,
            emitsInOrder([
              UserLeaveState(
                  fetchMoreDataStatus: Status.loading,
                  status: Status.success,
                  casualLeaves: [casualLeave]
                      .groupByMonth((element) => element.startDate),
                  urgentLeaves: [urgentLeave]
                      .groupByMonth((element) => element.startDate)),
              UserLeaveState(
                  fetchMoreDataStatus: Status.success,
                  status: Status.success,
                  casualLeaves: [casualLeave, casualLeave]
                      .groupByMonth((element) => element.startDate),
                  urgentLeaves: [urgentLeave]
                      .groupByMonth((element) => element.startDate)),
            ]));
      });

      test('Update leaves on list test', () {
        when(leaveRepo.fetchLeave(leaveId: initialLeaveWithChange.leaveId))
            .thenAnswer((_) async => initialLeaveWithChange);
        bloc.add(UpdateLeave(leaveId: casualLeave.leaveId));
        expectLater(
            bloc.stream,
            emits(UserLeaveState(
                fetchMoreDataStatus: Status.success,
                status: Status.success,
                casualLeaves: [initialLeaveWithChange]
                    .groupByMonth((element) => element.startDate),
                urgentLeaves: [urgentLeave]
                    .groupByMonth((element) => element.startDate))));
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
        when(leaveRepo.leaves(
                uid: employeeId, leaveType: LeaveType.casualLeave))
            .thenAnswer((_) async =>
                PaginatedLeaves(leaves: [casualLeave], lastDoc: lastDoc));
        when(leaveRepo.leaves(
                uid: employeeId, leaveType: LeaveType.urgentLeave))
            .thenAnswer((_) async =>
                PaginatedLeaves(leaves: [urgentLeave], lastDoc: lastDoc));
        bloc.add(LoadInitialUserLeaves());
        expectLater(
            bloc.stream,
            emitsInOrder([
              const UserLeaveState(status: Status.loading),
              UserLeaveState(
                  status: Status.success,
                  casualLeaves: [casualLeave]
                      .groupByMonth((element) => element.startDate),
                  urgentLeaves: [urgentLeave]
                      .groupByMonth((element) => element.startDate)),
            ]));
      });

      test('fetch more data leave failure test', () {
        when(leaveRepo.leaves(
                uid: employeeId,
                lastDoc: lastDoc,
                leaveType: LeaveType.casualLeave))
            .thenThrow(Exception('error'));
        bloc.add(FetchMoreUserLeaves(LeaveType.casualLeave));
        expectLater(
            bloc.stream,
            emitsInOrder([
              UserLeaveState(
                  fetchMoreDataStatus: Status.loading,
                  status: Status.success,
                  casualLeaves: [casualLeave]
                      .groupByMonth((element) => element.startDate),
                  urgentLeaves: [urgentLeave]
                      .groupByMonth((element) => element.startDate)),
              UserLeaveState(
                  fetchMoreDataStatus: Status.error,
                  error: firestoreFetchDataError,
                  status: Status.success,
                  casualLeaves: [casualLeave]
                      .groupByMonth((element) => element.startDate),
                  urgentLeaves: [urgentLeave]
                      .groupByMonth((element) => element.startDate)),
            ]));
      });
    });
  });
}
