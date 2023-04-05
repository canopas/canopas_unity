import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../core/utils/const/firestore.dart';

@Singleton()
class PaidLeaveService {
  final _paidLeaves = FirebaseFirestore.instance
      .collection(FireStoreConst.paidLeavesCollection)
      .doc(FireStoreConst.totalLeavesDoc);

  Future<int> getPaidLeaves() async {
    return await _paidLeaves.get().then((val) {
      if (val.data() != null) {
        return val.data()?[FireStoreConst.leaves];
      }
      return 0;
    });
  }

  Future<void> updateLeaveCount(int leaveCount) async {
    return _paidLeaves.update({FireStoreConst.leaves: leaveCount});
  }
}
