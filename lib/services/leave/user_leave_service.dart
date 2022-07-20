import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/model/leave/leave_request_data.dart';

final leaveCollection = FirebaseFirestore.instance
    .collection('leaves')
    .withConverter(
        fromFirestore: LeaveRequestData.fromFireStore,
        toFirestore: (LeaveRequestData leaveRequestData, _) =>
            leaveRequestData.toFireStore(leaveRequestData));

final leaveId = leaveCollection.doc().id;

@Singleton()
class UserLeaveService {
  Future<void> applyForLeave(LeaveRequestData leaveRequestData) async {
    leaveCollection.add(leaveRequestData).then((value) {
      print(value.id);
    }).onError((error, stackTrace) {
      // print('Error' + error.toString());
    });
  }

  Future<List<LeaveRequestData>> getAllLeavesOfUser(String id) async {
    final data = await leaveCollection.where('uid', isEqualTo: id).get();
    return data.docs.map((doc) => doc.data()).toList();
  }
}
