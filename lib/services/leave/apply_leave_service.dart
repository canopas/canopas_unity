import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/model/leave/leave_request_data.dart';

@Singleton()
class ApplyLeaveService {
  final _collection = FirebaseFirestore.instance
      .collection('leaves')
      .withConverter(
          fromFirestore: LeaveRequestData.fromFireStore,
          toFirestore: (LeaveRequestData leaveRequestData, _) =>
              leaveRequestData.toFireStore(leaveRequestData));

  Future<void> applyForLeave(LeaveRequestData leaveRequestData) async {
    _collection
        .add(leaveRequestData)
        .then((value) => print(value.toString()))
        .onError((error, stackTrace) => print('Error' + error.toString()));
  }
}
