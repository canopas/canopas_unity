import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/utils/const/firestore.dart';
import '../../../model/leave/leave.dart';

@Injectable()
class AdminLeaveService {
  final _leaveDbCollection = FirebaseFirestore.instance
      .collection(FirestoreConst.leaves)
      .withConverter(
          fromFirestore: Leave.fromFireStore,
          toFirestore: (Leave leaveRequestData, _) =>
              leaveRequestData.toFireStore(leaveRequestData));

  Future<void> updateLeaveStatus(String id, Map<String, dynamic> map) async {
    await _leaveDbCollection.doc(id).update(map);
  }


  Stream<List<Leave>> getAllRequests() {
    final BehaviorSubject<List<Leave>> leaves = BehaviorSubject<List<Leave>>();
    _leaveDbCollection
        .where(FirestoreConst.leaveStatus, isEqualTo: pendingLeaveStatus)
        .snapshots()
        .listen((event) {
      final request = event.docs
          .map((doc) => doc.data())
          .where((element) => element.startDate.dateOnly
              .areSameOrUpcoming(DateTime.now().dateOnly))
          .toList();
      leaves.add(request);
    }, onError: (error) {
      leaves.addError(error);
    });
    return leaves.stream;
  }

  Future<List<Leave>> getAllAbsence() async {
    int todayDate = DateTime.now().timeStampToInt;
    final data = await _leaveDbCollection
        .where(FirestoreConst.endLeaveDate, isGreaterThan: todayDate)
        .get();
    List<Leave> leaves = <Leave>[];

    for (var e in data.docs) {
      if (e.data().startDate < todayDate &&
          e.data().leaveStatus == approveLeaveStatus) {
        leaves.add(e.data());
      }
    }
    return leaves;
  }


}
