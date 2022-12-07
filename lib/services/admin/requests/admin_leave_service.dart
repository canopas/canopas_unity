import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/core/extensions/leave_extension.dart';
import '../../../core/utils/const/firestore.dart';
import '../../../core/utils/const/leave_time_constants.dart';
import '../../../model/leave/leave.dart';

@Singleton()
class AdminLeaveService {

  final _leaveDbCollection = FirebaseFirestore.instance.collection(FirestoreConst.leaves).withConverter(
      fromFirestore: Leave.fromFireStore,
      toFirestore: (Leave leaveRequestData, _) =>
          leaveRequestData.toFireStore(leaveRequestData));

  final StreamController<List<Leave>> _leaveStreamController = StreamController();
  late StreamSubscription<List<Leave>> _leaveStreamSubscription;

  AdminLeaveService(){
    _leaveStreamSubscription = _leaveDbCollection.where(FirestoreConst.leaveStatus,isEqualTo: pendingLeaveStatus).snapshots()
        .map((event) {
      return event.docs
          .map((doc) => doc.data())
          .where((leave) =>
          leave.startDate.toDate.areSameOrUpcoming(DateTime.now().dateOnly))
          .toList();
    }).listen((event) {
      _leaveStreamController.add(event);
    });
  }



  Future<void> updateLeaveStatus(String id, Map<String, dynamic> map) async {
    await _leaveDbCollection.doc(id).update(map);
  }

  Future<List<Leave>> getAllLeaves() async {
    final allLeaves = await _leaveDbCollection.where('leave_status',isEqualTo: approveLeaveStatus).get();
    return allLeaves.docs.map((e) => e.data()).toList();
  }


  Stream<List<Leave>> get getLeaveStream => _leaveStreamController.stream;


  Future<List<Leave>> getAllAbsence() async {
    int todayDate = DateTime.now().timeStampToInt;
    final data = await _leaveDbCollection
        .where(FirestoreConst.endLeaveDate, isGreaterThan: todayDate)
        .get();
    List<Leave> leaves = <Leave>[];

    for (var e in data.docs) {
      if (e.data().startDate < todayDate && !todayDate.dateOnly.isWeekend && e.data().leaveStatus == approveLeaveStatus) {
        int duration = e.data().getDateAndDuration()[todayDate.dateOnly]!;
        if(duration == fullLeave){
          leaves.add(e.data());
        } else if((duration == firstHalfLeave &&  todayDate.isFirstHalf) || (duration == secondHalfLeave && todayDate.isSecondHalf)){
          leaves.add(e.data());
        }
      }
    }
    return leaves;
  }

  @disposeMethod
  void dispose(){
    _leaveStreamController.close();
    _leaveStreamSubscription.cancel();
  }

}
