import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/model/Pagination/pagination.dart';
import 'package:projectunity/data/model/leave/leave.dart';
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

  Future<LeavesPaginationData> leaves(
          {DocumentSnapshot<Leave>? lastDoc, String? uid}) async =>
      await _leaveService.leaves(
        limit: 5,
        uid: uid,
        lastDoc: lastDoc,
        spaceId: _userStateNotifier.currentSpaceId!,
      );

  Stream<List<Leave>> userLeaveRequest(String uid) =>
      _leaveService.userLeaveByStatus(
          uid: uid,
          status: LeaveStatus.pending,
          spaceId: _userStateNotifier.currentSpaceId!);

  Stream<List<Leave>> userLeavesByYear(String uid, int year) =>
      _leaveService.userYearlyLeave(
          uid: uid, year: year, spaceId: _userStateNotifier.currentSpaceId!);

  Stream<List<Leave>> leaveByMonth(DateTime date) =>
      Rx.combineLatest2<List<Leave>, List<Leave>, List<Leave>>(
        _leaveService
            .monthlyLeaveByStartDate(
                year: date.year,
                month: date.month,
                spaceId: _userStateNotifier.currentSpaceId!)
            .distinct(),
        _leaveService
            .monthlyLeaveByEndDate(
                year: date.year,
                month: date.month,
                spaceId: _userStateNotifier.currentSpaceId!)
            .distinct(),
        (leavesByStartDate, leavesByEndDate) {
          List<Leave> mergedList = leavesByStartDate;
          mergedList.addAll(leavesByEndDate.where((endDateLeave) =>
              !leavesByEndDate.any((startDateLeave) =>
                  startDateLeave.leaveId == endDateLeave.leaveId)));
          return mergedList;
        },
      ).distinct();
}
