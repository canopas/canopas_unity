import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class PaidLeaveService {
  final _paidLeaves =
      FirebaseFirestore.instance.collection('paidLeaves').doc("totalLeaves");

  Future<int> getPaidLeaves() async {
    return await _paidLeaves.get().then((val) {
      if (val.data() != null) {
        return val.data()?['leaves'];
      }
      return 0;
    });
  }

  Future<void> updateLeaveCount(int leaveCount) async {
    return _paidLeaves.update({'leaves': leaveCount});
  }
}
