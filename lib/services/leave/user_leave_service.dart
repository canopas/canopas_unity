import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/model/leave/leave_request_data.dart';

@Singleton()
class UserLeaveService {
  final _leaveCollection = FirebaseFirestore.instance
      .collection('leaves')
      .withConverter(
          fromFirestore: LeaveRequestData.fromFireStore,
          toFirestore: (LeaveRequestData leaveRequestData, _) =>
              leaveRequestData.toFireStore(leaveRequestData));

  Future<void> applyForLeave(LeaveRequestData leaveRequestData) async {
    final leaveUid = leaveRequestData.leaveId;
    _leaveCollection.doc(leaveUid).set(leaveRequestData);
  }

  Future<List<LeaveRequestData>> getAllLeavesOfUser(String id) async {
    final data = await _leaveCollection.where('uid', isEqualTo: id).get();
    return data.docs.map((doc) => doc.data()).toList();
  }

  Future<List<LeaveRequestData>> getAllRequests() async {
    final data =
        await _leaveCollection.where('leave_status', isEqualTo: 1).get();
    return data.docs.map((doc) => doc.data()).toList();
  }
}
