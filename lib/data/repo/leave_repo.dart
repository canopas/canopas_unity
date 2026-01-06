import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/data/model/leave_count.dart';
import 'package:projectunity/data/model/pagination/pagination.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/data/services/leave_service.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton()
class LeaveRepo {
  final LeaveService _leaveService;
  final UserStateNotifier _userStateNotifier;

  LeaveRepo(this._leaveService, this._userStateNotifier);

  Stream<List<Leave>> get pendingLeaves => _leaveService
      .allPendingLeaveRequests(spaceId: _userStateNotifier.currentSpaceId!);

  Future<PaginatedLeaves> leaves({
    DocumentSnapshot<Leave>? lastDoc,
    String? uid,
    LeaveType? leaveType,
  }) async => await _leaveService.leaves(
    leaveType,
    limit: 8,
    uid: uid,
    lastDoc: lastDoc,
    spaceId: _userStateNotifier.currentSpaceId!,
  );

  Stream<List<Leave>> userLeaveRequest(String uid) =>
      _leaveService.userLeaveByStatus(
        uid: uid,
        status: LeaveStatus.pending,
        spaceId: _userStateNotifier.currentSpaceId!,
      );

  Stream<List<Leave>> leaveByMonth(
    DateTime date,
  ) => Rx.combineLatest2<List<Leave>, List<Leave>, List<Leave>>(
    _leaveService
        .monthlyLeaveByStartDate(
          year: date.year,
          month: date.month,
          spaceId: _userStateNotifier.currentSpaceId!,
        )
        .distinct(),
    _leaveService
        .monthlyLeaveByEndDate(
          year: date.year,
          month: date.month,
          spaceId: _userStateNotifier.currentSpaceId!,
        )
        .distinct(),
    (leavesByStartDate, leavesByEndDate) {
      List<Leave> mergedList = leavesByStartDate;
      mergedList.addAll(
        leavesByEndDate.where(
          (endDateLeave) => !leavesByStartDate.any(
            (startDateLeave) => startDateLeave.leaveId == endDateLeave.leaveId,
          ),
        ),
      );
      return mergedList;
    },
  ).distinct();

  Future<bool> checkLeaveAlreadyApplied({
    required String uid,
    required Map<DateTime, LeaveDayDuration> dateDuration,
  }) async => await _leaveService.checkLeaveAlreadyApplied(
    uid: uid,
    dateDuration: dateDuration,
    spaceId: _userStateNotifier.currentSpaceId!,
  );

  Future<void> updateLeaveStatus({
    required String leaveId,
    required LeaveStatus status,
    String response = '',
  }) async => await _leaveService.updateLeaveStatus(
    leaveId: leaveId,
    status: status,
    spaceId: _userStateNotifier.currentSpaceId!,
    response: response,
  );

  String get generateLeaveId =>
      _leaveService.generateLeaveId(_userStateNotifier.currentSpaceId!);

  Future<void> applyForLeave({required Leave leave}) async =>
      await _leaveService.applyForLeave(
        leave: leave,
        spaceId: _userStateNotifier.currentSpaceId!,
      );

  Future<List<Leave>> getUpcomingLeavesOfUser({required String uid}) async =>
      await _leaveService.getUpcomingLeavesOfUser(
        uid: uid,
        spaceId: _userStateNotifier.currentSpaceId!,
      );

  Future<LeaveCounts> getUserUsedLeaves({required String uid}) async =>
      await _leaveService.getUserUsedLeaves(
        uid: uid,
        spaceId: _userStateNotifier.currentSpaceId!,
      );

  Future<Leave?> fetchLeave({required String leaveId}) async =>
      await _leaveService.fetchLeave(
        leaveId: leaveId,
        spaceId: _userStateNotifier.currentSpaceId!,
      );
}
