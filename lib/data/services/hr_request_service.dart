import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../core/utils/const/firestore.dart';
import '../model/hr_request/hr_request.dart';
import '../provider/user_state.dart';

@LazySingleton()
class HrRequestService {
  final UserStateNotifier _userManager;
  late final FirebaseFirestore fireStore;

  HrRequestService(this._userManager, this.fireStore);

  CollectionReference<HrRequest> _hrRequestDB() {
    return fireStore
        .collection(FireStoreConst.spaces)
        .doc(_userManager.currentSpaceId!)
        .collection(FireStoreConst.hrRequestsCollection)
        .withConverter(
            fromFirestore: HrRequest.fromFireStore,
            toFirestore: (HrRequest hrRequest, options) =>
                hrRequest.toFireStore());
  }

  Future<void> setHrRequest(
      HrRequest hrDeskRequest) async {
    await _hrRequestDB().doc(hrDeskRequest.id).set(hrDeskRequest);
  }

  String get generateNewId => _hrRequestDB().doc().id;

  Future<List<HrRequest>> getHrRequests() async {
    final hrDeskRequestsCollection = await _hrRequestDB().get();
    return hrDeskRequestsCollection.docs.map((e) => e.data()).toList();
  }

  Future<List<HrRequest>> getHrRequestsOfUser(
      String uid) async {
    final hrDeskRequestsCollection = await _hrRequestDB()
        .where(FireStoreConst.uid, isEqualTo: uid)
        .get();
    return hrDeskRequestsCollection.docs.map((e) => e.data()).toList();
  }

  Future<void> setHrRequestDone(String id) async {
    await _hrRequestDB().doc(id).update({
      FireStoreConst.status: HrRequestStatus.done,
    });
  }
}
