import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/model/leave/leave_request_data.dart';

@Singleton()
class UserLeaveService {
  final _collection = FirebaseFirestore.instance
      .collection('leaves')
      .withConverter(
          fromFirestore: LeaveRequestData.fromFireStore,
          toFirestore: (LeaveRequestData leaveRequestData, _) =>
              leaveRequestData.toFireStore(leaveRequestData));

  Future<void> applyForLeave(LeaveRequestData leaveRequestData) async {
    _collection
        .add(leaveRequestData)
        .then((value) {})
        .onError((error, stackTrace) {
      // print('Error' + error.toString());
    });
  }

  Future<List<LeaveRequestData>> getAllLeavesOfUser(String id) async {
    final data = await _collection.where('uid', isEqualTo: id).get();
    return data.docs.map((doc) => doc.data()).toList();
  }
}
