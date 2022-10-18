import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/core/utils/const/firestore.dart';

@Injectable()
class PaidLeaveService {
  final _paidLeaves = FirebaseFirestore.instance
      .collection(FirestoreConst.paidLeavesCollection)
      .doc(FirestoreConst.totalLeavesDoc);

  Future<int> getPaidLeaves() async {
    return await _paidLeaves.get().then((val) {
      if (val.data() != null) {
        return val.data()?[FirestoreConst.leaves];
      }
      return 0;
    });
  }

  Future<void> updateLeaveCount(int leaveCount) async {
    return _paidLeaves.update({FirestoreConst.leaves: leaveCount});
  }
}
