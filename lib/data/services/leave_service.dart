import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/extensions/leave_extension.dart';
import '../core/utils/const/firestore.dart';
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

  Stream<List<Leave>> get leaves => _leaveDb()
      .snapshots()
      .map((event) => event.docs.map((leave) => leave.data()).toList());

  Future<bool> checkLeaveAlreadyApplied({
    required String userId,
    required Map<DateTime, LeaveDayDuration> dateDuration,
  }) async {
    final leaves =
        await _leaveDb().where(FireStoreConst.uid, isEqualTo: userId).get();

    return leaves.docs
        .map((doc) => doc.data())
        .where((leave) =>
            leave.status != LeaveStatus.rejected &&
            leave.status != LeaveStatus.cancelled)
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

    await _leaveDb().doc(id).update(responseData);
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
    final data = await _leaveDb()
        .where(FireStoreConst.leaveStatus,
            isEqualTo: LeaveStatus.approved.value)
        .get();
    List<Leave> leaves = <Leave>[];
    for (var leaveDoc in data.docs) {
      final leave = leaveDoc.data();
      if (((leave.startDate.dateOnly.month == date.month &&
              leave.startDate.dateOnly.year == date.year) ||
          (leave.endDate.dateOnly.month == date.month &&
              leave.endDate.dateOnly.year == date.year))) {
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

  Future<List<Leave>> getUpcomingLeavesOfUser(String employeeId) async {
    final data = await _leaveDb()
        .where(FireStoreConst.uid, isEqualTo: employeeId)
        .where(FireStoreConst.leaveStatus,
            isEqualTo: LeaveStatus.approved.value)
        .get();
    return data.docs
        .map((doc) => doc.data())
        .where((leave) =>
            leave.startDate.isAfter(DateTime.now().dateOnly) ||
            leave.startDate.isAtSameMomentAs(DateTime.now().dateOnly))
        .toList();
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

  Future<Leave?> fetchLeave(String leaveId) async {
    final data = await _leaveDb().doc(leaveId).get();
    return data.data();
  }
}
