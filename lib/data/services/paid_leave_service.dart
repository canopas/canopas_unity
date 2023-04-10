import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../core/utils/const/firestore.dart';
import '../provider/user_data.dart';

@LazySingleton()
class PaidLeaveService {
  final UserManager _userManager;

  PaidLeaveService(this._userManager);

  DocumentReference<Map<String, dynamic>> _paidLeaves() =>
      FirebaseFirestore.instance
          .collection(FireStoreConst.spacesCollection)
          .doc(_userManager.currentSpaceId);

  Future<int> getPaidLeaves() async {
    return await _paidLeaves().get().then((val) {
      if (val.data() != null) {
        return val.data()?[FireStoreConst.paidTimeOff];
      }
      return 0;
    });
  }

  Future<void> updateLeaveCount(int leaveCount) async {
    return _paidLeaves().update({FireStoreConst.paidTimeOff: leaveCount});
  }
}
