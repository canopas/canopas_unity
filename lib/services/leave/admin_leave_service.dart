import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../model/leave/leave.dart';

@Injectable()
class AdminLeaveService {
  final _leaveCollection = FirebaseFirestore.instance
      .collection('leaves')
      .withConverter(
          fromFirestore: Leave.fromFireStore,
          toFirestore: (Leave leaveRequestData, _) =>
              leaveRequestData.toFireStore(leaveRequestData));

  Future<void> updateLeaveStatus(String id, Map<String, dynamic> map) async {
    await _leaveCollection.doc(id).update(map);
  }
}
