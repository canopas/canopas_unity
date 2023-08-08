import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/extensions/list.dart';
import 'package:projectunity/data/core/utils/bloc_status.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/model/pagination/pagination.dart';
import 'package:projectunity/data/repo/leave_repo.dart';
import 'package:projectunity/ui/admin/members/details_leaves/bloc/admin_employee_details_leave_bloc.dart';
import 'package:projectunity/ui/admin/members/details_leaves/bloc/admin_employee_details_leave_events.dart';
import 'package:projectunity/ui/admin/members/details_leaves/bloc/admin_employee_details_leave_state.dart';

import 'admin_employee_details_leaves_test.mocks.dart';

@GenerateMocks([LeaveRepo, DocumentSnapshot])
void main() {
  late LeaveRepo leaveRepo;
  late AdminEmployeeDetailsLeavesBLoc bloc;

  const String employeeId = 'CA 1044';
  DateTime today = DateTime.now().dateOnly;

  Leave initialLeave = Leave(
      leaveId: 'Leave Id',
      uid: "user id",
      type: LeaveType.sickLeave,
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
      type: LeaveType.sickLeave,
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
      type: LeaveType.sickLeave,
      startDate: today.subtract(const Duration(days: 2)),
      endDate: today.subtract(const Duration(days: 1)),
      total: 1,
      reason: 'Suffering from viral fever',
      status: LeaveStatus.approved,
      appliedOn: today,
      perDayDuration: const [LeaveDayDuration.firstHalfLeave]);

  group('Admin member details time-off leave test', () {
    group('Initial fetch data test', () {
      final lastDoc = MockDocumentSnapshot<Leave>();

      setUp(() {
        leaveRepo = MockLeaveRepo();
        bloc = AdminEmployeeDetailsLeavesBLoc(leaveRepo);
      });

      tearDown(() async {
        await bloc.close();
      });

      test('Emits initial state test', () {
        expect(
            bloc.state,
            const AdminEmployeeDetailsLeavesState(
                fetchMoreDataStatus: Status.initial,
                leavesMap: {},
                error: null,
                status: Status.initial));
      });

      test('Load initial leave success test', () {
        when(leaveRepo.leaves(uid: employeeId)).thenAnswer((_) async =>
            PaginatedLeaves(leaves: [initialLeave], lastDoc: lastDoc));
        bloc.add(LoadInitialLeaves(employeeId: employeeId));
        expectLater(
            bloc.stream,
            emitsInOrder([
              const AdminEmployeeDetailsLeavesState(status: Status.loading),
              AdminEmployeeDetailsLeavesState(
                  status: Status.success,
                  leavesMap: [initialLeave]
                      .groupByMonth((element) => element.appliedOn)),
            ]));
      });

      test('Load initial leave failure test', () {
        when(leaveRepo.leaves(uid: employeeId)).thenThrow(Exception('error'));
        bloc.add(LoadInitialLeaves(employeeId: employeeId));
        expectLater(
            bloc.stream,
            emitsInOrder([
              const AdminEmployeeDetailsLeavesState(status: Status.loading),
              const AdminEmployeeDetailsLeavesState(
                  status: Status.error, error: firestoreFetchDataError),
            ]));
      });
    });

    group('Fetch more data success test', () {
      final lastDoc = MockDocumentSnapshot<Leave>();
      final moreDataLastDoc = MockDocumentSnapshot<Leave>();

      setUpAll(() {
        leaveRepo = MockLeaveRepo();
        bloc = AdminEmployeeDetailsLeavesBLoc(leaveRepo);
      });

      tearDownAll(() async {
        await bloc.close();
      });

      test('Load initial leave success test', () {
        when(leaveRepo.leaves(uid: employeeId)).thenAnswer((_) async =>
            PaginatedLeaves(leaves: [initialLeave], lastDoc: lastDoc));
        bloc.add(LoadInitialLeaves(employeeId: employeeId));
        expectLater(
            bloc.stream,
            emitsInOrder([
              const AdminEmployeeDetailsLeavesState(status: Status.loading),
              AdminEmployeeDetailsLeavesState(
                  status: Status.success,
                  leavesMap: [initialLeave]
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
              AdminEmployeeDetailsLeavesState(
                  fetchMoreDataStatus: Status.loading,
                  status: Status.success,
                  leavesMap: [initialLeave]
                      .groupByMonth((element) => element.appliedOn)),
              AdminEmployeeDetailsLeavesState(
                  fetchMoreDataStatus: Status.success,
                  status: Status.success,
                  leavesMap: [initialLeave, moreLeave]
                      .groupByMonth((element) => element.appliedOn)),
            ]));
      });

      test('Update leaves on list test', () {
        when(leaveRepo.fetchLeave(leaveId: initialLeave.leaveId))
            .thenAnswer((realInvocation) async => initialLeaveWithChange);
        bloc.add(UpdateLeave(leaveId: initialLeave.leaveId));
        expectLater(
            bloc.stream,
            emits(AdminEmployeeDetailsLeavesState(
                fetchMoreDataStatus: Status.success,
                status: Status.success,
                leavesMap: [moreLeave, initialLeaveWithChange]
                    .groupByMonth((element) => element.appliedOn))));
      });
    });
    group('Fetch more data failure test', () {
      final lastDoc = MockDocumentSnapshot<Leave>();

      setUpAll(() {
        leaveRepo = MockLeaveRepo();
        bloc = AdminEmployeeDetailsLeavesBLoc(leaveRepo);
      });

      tearDownAll(() async {
        await bloc.close();
      });

      test('Initial data setup', () {
        when(leaveRepo.leaves(uid: employeeId)).thenAnswer((_) async =>
            PaginatedLeaves(leaves: [initialLeave], lastDoc: lastDoc));
        bloc.add(LoadInitialLeaves(employeeId: employeeId));
        expectLater(
            bloc.stream,
            emitsInOrder([
              const AdminEmployeeDetailsLeavesState(status: Status.loading),
              AdminEmployeeDetailsLeavesState(
                  status: Status.success,
                  leavesMap: [initialLeave]
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
              AdminEmployeeDetailsLeavesState(
                  fetchMoreDataStatus: Status.loading,
                  status: Status.success,
                  leavesMap: [initialLeave]
                      .groupByMonth((element) => element.appliedOn)),
              AdminEmployeeDetailsLeavesState(
                  fetchMoreDataStatus: Status.error,
                  error: firestoreFetchDataError,
                  status: Status.success,
                  leavesMap: [initialLeave]
                      .groupByMonth((element) => element.appliedOn)),
            ]));
      });
    });
  });
}
