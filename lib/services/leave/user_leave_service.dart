import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/model/leave/leave.dart';

@Singleton()
class UserLeaveService {
  final _leaveDbCollection = FirebaseFirestore.instance
      .collection('leaves')
      .withConverter(
          fromFirestore: Leave.fromFireStore,
          toFirestore: (Leave leave, _) => leave.toFireStore(leave));


  Future<void> applyForLeave(Leave leaveRequestData) async {
    final leaveUid = leaveRequestData.leaveId;
    _leaveDbCollection.doc(leaveUid).set(leaveRequestData);
  }

  Future<List<Leave>> getAllLeavesOfUser(String id) async {
    final data = await _leaveDbCollection.where('uid', isEqualTo: id).get();
    return data.docs.map((doc) => doc.data()).toList();
  }

  Future<List<Leave>> getRequestedLeave(String id) async {
    final data = await _leaveDbCollection
        .where('uid', isEqualTo: id)
        .where('leave_status', isEqualTo: pendingLeaveStatus)
        .get();

    return data.docs.map((doc) => doc.data()).toList();
  }

  Future<List<Leave>> getUpcomingLeaves(String employeeId) async {
    final data = await _leaveDbCollection
        .where('uid', isEqualTo: employeeId)
        .where('leave_status', isEqualTo: approveLeaveStatus)
        .get();
    return data.docs.map((doc) => doc.data()).toList();
  }

  Future<void> deleteLeaveRequest(String leaveId) async {
    await _leaveDbCollection.doc(leaveId).delete();
  }

  Future<int> getUserUsedLeaveCount(String id) async {
   List<Leave> allLeaves = await getAllLeavesOfUser(id);
   int _leaveCount = 0;
   for (var element in allLeaves){
     if(element.leaveStatus == approveLeaveStatus && element.startDate < DateTime.now().millisecondsSinceEpoch){
       _leaveCount += element.totalLeaves.toInt();
     }
  }
  return _leaveCount;
  }

}