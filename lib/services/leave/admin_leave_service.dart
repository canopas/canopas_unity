import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../model/leave/leave.dart';

@Injectable()
class AdminLeaveService {
  final _leaveDbCollection = FirebaseFirestore.instance
      .collection('leaves')
      .withConverter(
          fromFirestore: Leave.fromFireStore,
          toFirestore: (Leave leaveRequestData, _) =>
              leaveRequestData.toFireStore(leaveRequestData));

  Future<void> updateLeaveStatus(String id, Map<String, dynamic> map) async {
    await _leaveDbCollection.doc(id).update(map);
  }

  Future<List<Leave>> getAllRequests() async {
    final data =
        await _leaveDbCollection.where('leave_status', isEqualTo: 1).get();
    return data.docs.map((doc) => doc.data()).toList();
  }
}
