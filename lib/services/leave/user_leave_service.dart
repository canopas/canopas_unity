import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/model/leave/leave_request_data.dart';

@Singleton()
final leaveCollection = FirebaseFirestore.instance
    .collection('leaves')
    .withConverter(
        fromFirestore: LeaveRequestData.fromFireStore,
        toFirestore: (LeaveRequestData leaveRequestData, _) =>
            leaveRequestData.toFireStore(leaveRequestData));

class UserLeaveService {
  Future<void> applyForLeave(LeaveRequestData leaveRequestData) async {
    leaveCollection.add(leaveRequestData).then((value) {
      //check to see data is uploaded or not
    }).onError((error, stackTrace) {
      // print('Error' + error.toString());
    });
  }

  Future<List<LeaveRequestData>> getAllLeavesOfUser(String id) async {
    final data = await leaveCollection.where('uid', isEqualTo: id).get();
    return data.docs.map((doc) => doc.data()).toList();
  }

  Future<List<LeaveRequestData>> getAllRequests() async {
    final data =
        await leaveCollection.where('leave_status', isEqualTo: 1).get();
    return data.docs.map((doc) => doc.data()).toList();
  }
}
