import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/model/hr_desk_request/hr_desk_request.dart';
import '../core/utils/const/firestore.dart';
import '../provider/user_state.dart';

@LazySingleton()
class LeaveService {
  final UserStateNotifier _userManager;
  late final FirebaseFirestore fireStore;

  LeaveService(this._userManager, this.fireStore);

  CollectionReference<HrDeskRequest> _hrDeskRequestDB() {
    return fireStore
        .collection(FireStoreConst.spaces)
        .doc(_userManager.currentSpaceId!)
        .collection(FireStoreConst.hrDeskRequestCollection)
        .withConverter(
        fromFirestore: HrDeskRequest.fromFireStore,
        toFirestore: (HrDeskRequest hrDeskRequest, options) =>
            hrDeskRequest.toFireStore());
  }


  Future<void> newHrDeskRequest(HrDeskRequest hrDeskRequest) async {
    await _hrDeskRequestDB().add(hrDeskRequest);
  }

  Future<List<HrDeskRequest>> fetchHrDeskRequest() async {
    final hrDeskRequestsCollection = await _hrDeskRequestDB().get();
    return hrDeskRequestsCollection.docs.map((e) => e.data()).toList();
  }

}
