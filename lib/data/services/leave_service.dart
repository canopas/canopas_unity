import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/core/extensions/leave_extension.dart';
import 'package:rxdart/rxdart.dart';
import '../core/utils/const/firestore.dart';
import '../event_bus/events.dart';
import '../model/leave/leave.dart';

@Singleton()
class LeaveService {
  final _leaveDbCollection = FirebaseFirestore.instance
      .collection(FireStoreConst.leaves)
      .withConverter(
      fromFirestore: Leave.fromFireStore,
      toFirestore: (Leave leave, _) => leave.toFireStore(leave));

  StreamSubscription<List<Leave>>? _leaveStreamSubscription;
  final BehaviorSubject<List<Leave>> _leaves = BehaviorSubject();

  Stream<List<Leave>> get leaves => _leaves.stream;

  LeaveService() {
     fetchLeaves();
  }

  void fetchLeaves() {
    _leaveDbCollection
        .where(FireStoreConst.leaveStatus, isEqualTo: pendingLeaveStatus)
        .snapshots()
        .map((event) {
      final filteredLeaves = event.docs
          .map((doc) => doc.data())
          .where((leave) =>
          leave.startDate.toDate.areSameOrUpcoming(DateTime.now().dateOnly))
          .toList();
      return filteredLeaves;
    }).listen((event) {
      _leaves.add(event);
    });
  }

  Future<bool> checkLeaveAlreadyApplied(
      {required String userId,
        required Map<DateTime, int> dateDuration}) async {
    final leaves = await _leaveDbCollection
        .where(FireStoreConst.uid, isEqualTo: userId)
        .get();
    return leaves.docs
        .map((doc) => doc.data())
        .where((leave) =>
    leave.startDate >= dateDuration.keys.first.timeStampToInt &&
        leave.endDate <= dateDuration.keys.last.timeStampToInt)
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
    final allLeaves = await _leaveDbCollection
        .where(FireStoreConst.startLeaveDate,
        isGreaterThanOrEqualTo:
        DateTime(DateTime.now().year, DateTime.now().month)
            .timeStampToInt)
        .get();
    return allLeaves.docs
        .map((e) => e.data())
        .where((leave) =>
    leave.leaveStatus == approveLeaveStatus &&
        leave.startDate.toDate == DateTime.now().dateOnly)
        .toList();
  }

  Future<List<Leave>> getUpcomingLeaves() async {
    final data = await _leaveDbCollection
        .where(FireStoreConst.startLeaveDate,
        isGreaterThan: DateTime.now().dateOnly.timeStampToInt)
        .get();
    return data.docs
        .map((doc) => doc.data())
        .where((leave) => leave.leaveStatus == approveLeaveStatus)
        .toList();
  }

  Future<void> updateLeaveStatus(String id, Map<String, dynamic> map) async {
    await _leaveDbCollection.doc(id).update(map);
  }

  Future<List<Leave>> getAllLeaves() async {
    final allLeaves = await _leaveDbCollection
        .where(FireStoreConst.leaveStatus, isEqualTo: approveLeaveStatus)
        .get();
    return allLeaves.docs.map((e) => e.data()).toList();
  }

  Future<List<Leave>> getAllAbsence({DateTime? date}) async {
    date = date ?? DateTime.now();
    final data = await _leaveDbCollection
        .where(FireStoreConst.endLeaveDate,
        isGreaterThanOrEqualTo: date.dateOnly.timeStampToInt)
        .get();
    List<Leave> leaves = <Leave>[];
    for (var e in data.docs) {
      if (e.data().startDate <= date.timeStampToInt &&
          !date.dateOnly.isWeekend &&
          e.data().leaveStatus == approveLeaveStatus) {
        leaves.add(e.data());
      }
    }
    return leaves;
  }

  Future<void> applyForLeave(Leave leaveRequestData) async {
    final leaveUid = leaveRequestData.leaveId;
    _leaveDbCollection.doc(leaveUid).set(leaveRequestData);
  }

  Future<List<Leave>> getAllLeavesOfUser(String id) async {
    final data =
    await _leaveDbCollection.where(FireStoreConst.uid, isEqualTo: id).get();
    return data.docs.map((doc) => doc.data()).toList();
  }

  Future<List<Leave>> getRecentLeavesOfUser(String id) async {
    final data = await _leaveDbCollection
        .where(FireStoreConst.uid, isEqualTo: id)
        .where(FireStoreConst.leaveStatus, isEqualTo: approveLeaveStatus)
        .get();
    return data.docs
        .map((doc) => doc.data())
        .where((element) => element.endDate >= DateTime.now().timeStampToInt)
        .toList();
  }

  Future<List<Leave>> getPastLeavesOfUser(String id) async {
    final data =
    await _leaveDbCollection.where(FireStoreConst.uid, isEqualTo: id).get();
    return data.docs
        .where((e) => e.data().endDate <= DateTime.now().timeStampToInt)
        .map((doc) => doc.data())
        .toList();
  }

  Future<List<Leave>> getRequestedLeave(String id) async {
    final data = await _leaveDbCollection
        .where(FireStoreConst.uid, isEqualTo: id)
        .where(FireStoreConst.leaveStatus, isEqualTo: pendingLeaveStatus)
        .get();

    List<Leave> leaves = data.docs.map((doc) => doc.data()).toList();
    return leaves
        .where((element) =>
    element.startDate.dateOnly.isAfter(DateTime.now().dateOnly) ||
        element.startDate.dateOnly
            .isAtSameMomentAs(DateTime.now().dateOnly))
        .toList();
  }

  Future<List<Leave>> getUpcomingLeavesOfUser(String employeeId) async {
    final data = await _leaveDbCollection
        .where(FireStoreConst.uid, isEqualTo: employeeId)
        .get();
    return data.docs
        .map((doc) => doc.data())
        .where((leave) => leave.startDate >= DateTime.now().timeStampToInt)
        .where((leave) => leave.leaveStatus == approveLeaveStatus)
        .toList();
  }

  Future<void> deleteLeaveRequest(String leaveId) async {
    await _leaveDbCollection
        .doc(leaveId)
        .delete()
        .then((value) => eventBus.fire(CancelLeaveByUser()));
  }

  Future<double> getUserUsedLeaves(String id) async {
    DateTime currentTime = DateTime.now();

    final data = await _leaveDbCollection
        .where(FireStoreConst.uid, isEqualTo: id)
        .where(FireStoreConst.leaveStatus, isEqualTo: approveLeaveStatus)
        .get();

    List<Leave> approvedLeaves = data.docs.map((doc) => doc.data()).toList();
    double leaveCount = 0.0;
    approvedLeaves
        .where((leave) =>
    leave.startDate < currentTime.millisecondsSinceEpoch &&
        leave.startDate.toDate.year == currentTime.year)
        .forEach((leave) {
      leaveCount += leave.totalLeaves;
    });
    return leaveCount;
  }

  Future<void> deleteAllLeavesOfUser(String id) async {
    _leaveDbCollection
        .where(FireStoreConst.uid, isEqualTo: id)
        .get()
        .then((snapshot) async {
      for (var deleteLeaveDoc in snapshot.docs) {
        await deleteLeaveRequest(deleteLeaveDoc.id);
      }
    });
  }

  Future<Leave?> fetchLeave(String id) async {
    final data = await _leaveDbCollection.doc(id).get();
    return data.data();
  }

  @disposeMethod
  void dispose() async {
    await _leaves.close();
    await _leaveStreamSubscription?.cancel();
  }
}
