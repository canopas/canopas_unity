import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/extensions/leave_extension.dart';
import '../core/utils/const/firestore.dart';
import '../event_bus/events.dart';
import '../model/leave/leave.dart';
import '../provider/user_state.dart';

@LazySingleton()
class LeaveService {
  final UserStateNotifier _userManager;
  late final FirebaseFirestore fireStore;

  LeaveService(this._userManager, this.fireStore);

  CollectionReference<Leave> _leaveDb() {
    return fireStore
        .collection(FireStoreConst.spaces)
        .doc(_userManager.currentSpaceId!)
        .collection(FireStoreConst.leaves)
        .withConverter(
            fromFirestore: Leave.fromFireStore,
            toFirestore: (Leave leave, _) => leave.toFireStore(leave));
  }

  Future<List<Leave>> getLeaveRequestOfUsers() async {
    final requests = await _leaveDb()
        .where(FireStoreConst.leaveStatus, isEqualTo: LeaveStatus.pending.value)
        .get();
    return requests.docs.map((leave) => leave.data()).toList();
  }

  Future<bool> checkLeaveAlreadyApplied(
      {required String userId,
      required Map<DateTime, LeaveDayDuration> dateDuration}) async {
    final leaves =
        await _leaveDb().where(FireStoreConst.uid, isEqualTo: userId).get();
    return leaves.docs
        .map((doc) => doc.data())
        .where((leave) =>
            leave.startDate.isAfterOrSame(dateDuration.keys.first) &&
            leave.endDate.isBeforeOrSame(dateDuration.keys.last) &&
            leave.status != LeaveStatus.rejected &&
            leave.status != LeaveStatus.cancelled)
        .where((leave) => leave
            .getDateAndDuration()
            .entries
            .map((leaveDay) => dateDuration.entries
                .map((selectedDay) => leaveDay == selectedDay)
                .isNotEmpty)
            .isNotEmpty)
        .isNotEmpty;
  }

  Future<List<Leave>> getRecentLeaves() async {
    final allLeaves = await _leaveDb()
        .where(FireStoreConst.startLeaveDate,
            isGreaterThanOrEqualTo:
                DateTime(DateTime.now().year, DateTime.now().month)
                    .timeStampToInt)
        .get();
    return allLeaves.docs
        .map((e) => e.data())
        .where((leave) =>
            leave.status == LeaveStatus.approved &&
            leave.startDate.dateOnly == DateTime.now().dateOnly)
        .toList();
  }

  Future<List<Leave>> getUpcomingLeaves() async {
    final data = await _leaveDb()
        .where(FireStoreConst.startLeaveDate,
            isGreaterThan: DateTime.now().dateOnly.timeStampToInt)
        .get();
    return data.docs
        .map((doc) => doc.data())
        .where((leave) => leave.status == LeaveStatus.approved)
        .toList();
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

    await _leaveDb().doc(id).update(responseData);
  }

  Future<List<Leave>> getAllLeaves() async {
    final allLeaves = await _leaveDb().get();
    return allLeaves.docs.map((e) => e.data()).toList();
  }

  Future<List<Leave>> getAllApprovedLeaves() async {
    final allLeaves = await _leaveDb()
        .where(FireStoreConst.leaveStatus,
            isEqualTo: LeaveStatus.approved.value)
        .get();
    return allLeaves.docs.map((e) => e.data()).toList();
  }

  Future<List<Leave>> getAllAbsence({DateTime? date}) async {
    date = date ?? DateTime.now();
    final data = await _leaveDb().get();
    List<Leave> leaves = <Leave>[];
    for (var leaveDoc in data.docs) {
      final leave = leaveDoc.data();
      if (((leave.startDate.dateOnly.month == date.month &&
                  leave.startDate.dateOnly.year == date.year) ||
              (leave.endDate.dateOnly.month == date.month &&
                  leave.endDate.dateOnly.year == date.year)) &&
          leave.status == LeaveStatus.approved) {
        leaves.add(leave);
      }
    }
    return leaves;
  }

  String getNewLeaveId() {
    return _leaveDb().doc().id;
  }

  Future<void> applyForLeave(Leave leaveRequestData) async {
    final leaveId = leaveRequestData.leaveId;
    await _leaveDb().doc(leaveId).set(leaveRequestData);
  }

  Future<List<Leave>> getAllLeavesOfUser(String id) async {
    final data =
        await _leaveDb().where(FireStoreConst.uid, isEqualTo: id).get();
    return data.docs.map((doc) => doc.data()).toList();
  }

  Future<List<Leave>> getRecentLeavesOfUser(String id) async {
    final data = await _leaveDb()
        .where(FireStoreConst.uid, isEqualTo: id)
        .where(FireStoreConst.leaveStatus,
            isEqualTo: LeaveStatus.approved.value)
        .get();
    return data.docs
        .map((doc) => doc.data())
        .where((leave) => leave.endDate.isAfter(DateTime.now().dateOnly) || leave.endDate.isAtSameMomentAs(DateTime.now().dateOnly))
        .toList();
  }

  Future<List<Leave>> getRequestedLeave(String id) async {
    final data = await _leaveDb()
        .where(FireStoreConst.uid, isEqualTo: id)
        .where(FireStoreConst.leaveStatus, isEqualTo: LeaveStatus.pending.value)
        .get();

    return data.docs.map((doc) => doc.data()).toList();
  }

  Future<List<Leave>> getUpcomingLeavesOfUser(String employeeId) async {
    final data =
        await _leaveDb().where(FireStoreConst.uid, isEqualTo: employeeId).get();
    return data.docs
        .map((doc) => doc.data())
        .where((leave) =>
            leave.startDate.isAfter(DateTime.now().dateOnly) ||
            leave.startDate.isAtSameMomentAs(DateTime.now().dateOnly))
        .where((leave) => leave.status == LeaveStatus.approved)
        .toList();
  }

  Future<void> deleteLeaveRequest(String leaveId) async {
    await _leaveDb()
        .doc(leaveId)
        .delete()
        .then((value) => eventBus.fire(UpdateLeavesEvent()));
  }

  Future<double> getUserUsedLeaves(String id) async {
    DateTime currentTime = DateTime.now();

    final data = await _leaveDb()
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

  Future<void> deleteAllLeavesOfUser(String id) async {
    _leaveDb()
        .where(FireStoreConst.uid, isEqualTo: id)
        .get()
        .then((snapshot) async {
      for (var deleteLeaveDoc in snapshot.docs) {
        await deleteLeaveRequest(deleteLeaveDoc.id);
      }
    });
  }

  Future<Leave?> fetchLeave(String leaveId) async {
    final data = await _leaveDb().doc(leaveId).get();
    return data.data();
  }
}
