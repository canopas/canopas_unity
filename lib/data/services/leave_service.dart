import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/extensions/leave_extension.dart';
import 'package:projectunity/data/model/pagination/pagination.dart';
import '../core/utils/const/firestore.dart';
import '../model/leave/leave.dart';
import '../provider/user_state.dart';

@LazySingleton()
class LeaveService {
  final UserStateNotifier _userManager;
  late final FirebaseFirestore fireStore;

  LeaveService(this._userManager, this.fireStore);

  CollectionReference<Leave> _leaveDb({required String spaceId}) {
    return fireStore
        .collection(FireStoreConst.spaces)
        .doc(spaceId)
        .collection(FireStoreConst.leaves)
        .withConverter(
            fromFirestore: Leave.fromFireStore,
            toFirestore: (Leave leave, _) => leave.toFireStore(leave));
  }

  Stream<List<Leave>> allPendingLeaveRequests({required String spaceId}) =>
      _leaveDb(spaceId: spaceId)
          .where(FireStoreConst.leaveStatus,
              isEqualTo: LeaveStatus.pending.value)
          .snapshots()
          .asyncMap((event) => event.docs.map((e) => e.data()).toList());

  Future<PaginatedLeaves> leaves(
      {DocumentSnapshot<Leave>? lastDoc,
      String? uid,
      required String spaceId,
      required int limit}) async {
    Query<Leave> query = _leaveDb(spaceId: spaceId)
        .orderBy(FireStoreConst.appliedOn, descending: true);

    if (uid != null) {
      query = query.where(FireStoreConst.uid, isEqualTo: uid);
    }

    if (lastDoc != null) {
      query = query.startAfterDocument(lastDoc);
    }

    final leavesDoc = await query.limit(limit).get();

    return PaginatedLeaves(
        leaves: leavesDoc.docs.map((e) => e.data()).toList(),
        lastDoc: leavesDoc.docs.isNotEmpty ? leavesDoc.docs.last : null);
  }

  Stream<List<Leave>> monthlyLeaveByStartDate(
          {required int year, required int month, required String spaceId}) =>
      _leaveDb(spaceId: spaceId)
          .where(FireStoreConst.leaveStatus,
              isEqualTo: LeaveStatus.approved.value)
          .where(FireStoreConst.startLeaveDate,
              isGreaterThanOrEqualTo: DateTime(year, month).timeStampToInt)
          .where(FireStoreConst.startLeaveDate,
              isLessThan: DateTime(year, month + 1).timeStampToInt)
          .snapshots()
          .map((event) => event.docs.map((leave) => leave.data()).toList());

  Stream<List<Leave>> monthlyLeaveByEndDate(
          {required int year, required int month, required String spaceId}) =>
      _leaveDb(spaceId: spaceId)
          .where(FireStoreConst.leaveStatus,
              isEqualTo: LeaveStatus.approved.value)
          .where(FireStoreConst.endLeaveDate,
              isGreaterThanOrEqualTo: DateTime(year, month).timeStampToInt)
          .where(FireStoreConst.endLeaveDate,
              isLessThan: DateTime(year, month + 1).timeStampToInt)
          .snapshots()
          .asyncMap((event) => event.docs
              .map((leave) => leave.data())
              .where((leave) => leave.startDate.isBefore(DateTime(year, month)))
              .toList());

  Stream<List<Leave>> userLeaveByStatus(
          {required String uid,
          required LeaveStatus status,
          required String spaceId}) =>
      _leaveDb(spaceId: spaceId)
          .where(FireStoreConst.uid, isEqualTo: uid)
          .where(FireStoreConst.leaveStatus, isEqualTo: status.value)
          .snapshots()
          .map((event) => event.docs.map((leave) => leave.data()).toList());

  Future<bool> checkLeaveAlreadyApplied({
    required String userId,
    required Map<DateTime, LeaveDayDuration> dateDuration,
  }) async {
    final leaves = await _leaveDb(spaceId: _userManager.currentSpaceId!)
        .where(FireStoreConst.uid, isEqualTo: userId)
        .where(FireStoreConst.leaveStatus, isNotEqualTo: LeaveStatus.rejected)
        .where(FireStoreConst.leaveStatus, isNotEqualTo: LeaveStatus.cancelled)
        .get();

    return leaves.docs
        .map((doc) => doc.data())
        .where((leave) {
      final leaveDuration = leave.getDateAndDuration();
      return leaveDuration.entries.any((existLeaveDay) => dateDuration.entries
          .any((applyLeaveDay) =>
              applyLeaveDay.key.isAtSameMomentAs(existLeaveDay.key) &&
              applyLeaveDay.value == existLeaveDay.value));
    }).isNotEmpty;
  }

  Future<void> updateLeaveStatus(
      {required String id,
      required LeaveStatus status,
      String response = ''}) async {
    Map<String, dynamic> responseData = <String, dynamic>{
      FireStoreConst.leaveStatus: status.value,
    };

    if (response.trim().isNotEmpty) {
      responseData.addEntries([MapEntry(FireStoreConst.response, response)]);
    }

    await _leaveDb(spaceId: _userManager.currentSpaceId!)
        .doc(id)
        .update(responseData);
  }

  String get generateLeaveId =>
      _leaveDb(spaceId: _userManager.currentSpaceId!).doc().id;

  Future<void> applyForLeave(Leave leaveRequestData) async {
    final leaveId = leaveRequestData.leaveId;
    await _leaveDb(spaceId: _userManager.currentSpaceId!)
        .doc(leaveId)
        .set(leaveRequestData);
  }

  Future<List<Leave>> getUpcomingLeavesOfUser(String employeeId) async {
    final data = await _leaveDb(spaceId: _userManager.currentSpaceId!)
        .where(FireStoreConst.uid, isEqualTo: employeeId)
        .where(FireStoreConst.leaveStatus,
            isEqualTo: LeaveStatus.approved.value)
        .where(FireStoreConst.startLeaveDate,
            isGreaterThanOrEqualTo: DateTime.now().dateOnly.timeStampToInt)
        .get();
    return data.docs.map((doc) => doc.data()).toList();
  }

  Future<double> getUserUsedLeaves(String id) async {
    DateTime currentTime = DateTime.now();

    final data = await _leaveDb(spaceId: _userManager.currentSpaceId!)
        .where(FireStoreConst.uid, isEqualTo: id)
        .where(FireStoreConst.leaveStatus,
            isEqualTo: LeaveStatus.approved.value)
        .get();

    List<Leave> approvedLeaves = data.docs.map((doc) => doc.data()).toList();
    double leaveCount = 0.0;
    approvedLeaves
        .where((leave) =>
            leave.startDate.isBefore(currentTime) &&
            leave.startDate.year == currentTime.year)
        .forEach((leave) {
      leaveCount += leave.total;
    });
    return leaveCount;
  }

  Future<Leave?> fetchLeave(String leaveId) async {
    final data = await _leaveDb(spaceId: _userManager.currentSpaceId!)
        .doc(leaveId)
        .get();
    return data.data();
  }
}
