import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/extensions/leave_extension.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/utils/const/firestore.dart';
import '../../core/utils/const/leave_time_constants.dart';
import '../../model/leave/leave.dart';

@Singleton()
class AdminLeaveService {

  final _leaveDbCollection = FirebaseFirestore.instance.collection(FirestoreConst.leaves).withConverter(
      fromFirestore: Leave.fromFireStore,
      toFirestore: (Leave leaveRequestData, _) =>
          leaveRequestData.toFireStore(leaveRequestData));

   StreamSubscription<List<Leave>>? _leaveStreamSubscription;
  final BehaviorSubject<List<Leave>> _leaves= BehaviorSubject();
  Stream<List<Leave>> get leaves=>_leaves.stream;
  AdminLeaveService(){
    fetchLeaves();
  }

  void fetchLeaves(){
    _leaveDbCollection.where(FirestoreConst.leaveStatus,isEqualTo: pendingLeaveStatus).snapshots().map((event) {
    final filteredLeaves=  event.docs.map((doc) => doc.data()).where((leave) => leave.startDate.toDate.areSameOrUpcoming(DateTime.now().dateOnly)).toList();
    return filteredLeaves;
    }).listen((event) {
      _leaves.add(event);
    });
  }

  Future<List<Leave>> getRecentLeaves() async {
    final allLeaves = await _leaveDbCollection
        .where(FirestoreConst.startLeaveDate,
            isGreaterThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month).timeStampToInt)
        .get();
    return allLeaves.docs.map((e) => e.data()).where((leave) => leave.leaveStatus == approveLeaveStatus && leave.startDate <= DateTime.now().dateOnly.timeStampToInt).toList();
  }

  Future<List<Leave>> getUpcomingLeaves() async {
    final data = await _leaveDbCollection
        .where(FirestoreConst.startLeaveDate,
            isGreaterThan: DateTime.now().dateOnly.timeStampToInt)
        .get();
    return data.docs.map((doc) => doc.data()).where((leave) => leave.leaveStatus == approveLeaveStatus).toList();
  }

  Future<void> updateLeaveStatus(String id, Map<String, dynamic> map) async {
    await _leaveDbCollection.doc(id).update(map);
  }

  Future<List<Leave>> getAllLeaves() async {
    final allLeaves = await _leaveDbCollection.where('leave_status',isEqualTo: approveLeaveStatus).get();
    return allLeaves.docs.map((e) => e.data()).toList();
  }



  Future<List<Leave>> getAllAbsence({DateTime? date}) async {
    date = date ?? DateTime.now();
    final data = await _leaveDbCollection
        .where(FirestoreConst.endLeaveDate, isGreaterThanOrEqualTo: date.dateOnly.timeStampToInt)
        .get();
    List<Leave> leaves = <Leave>[];
    for (var e in data.docs) {
      if (e.data().startDate < date.timeStampToInt && !date.dateOnly.isWeekend && e.data().leaveStatus == approveLeaveStatus) {
        int duration = e.data().getDateAndDuration()[date.dateOnly]!;
        if(duration == fullLeave || !date.dateOnly.isAtSameMomentAs(DateTime.now().dateOnly)){
          leaves.add(e.data());
        } else if((duration == firstHalfLeave &&  date.timeStampToInt.isFirstHalf) || (duration == secondHalfLeave && date.timeStampToInt.isSecondHalf)){
          leaves.add(e.data());
        }
      }
    }
    return leaves;
  }

  @disposeMethod
  void dispose() async {
    await _leaves.close();
    await _leaveStreamSubscription?.cancel();
  }
}
