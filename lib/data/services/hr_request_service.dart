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

  Future<void> setHrRequest(HrRequest hrRequest) async {
    await _hrRequestDB().doc(hrRequest.id).set(hrRequest);
  }

  String get generateNewId => _hrRequestDB().doc().id;

  Future<List<HrRequest>> getHrRequests() async {
    final hrDeskRequestsCollection =
        await _hrRequestDB().get();
    return hrDeskRequestsCollection.docs.map((e) => e.data()).toList();
  }

  Future<List<HrRequest>> getHrRequestsOfUser(String uid) async {
    final hrDeskRequestsCollection = await _hrRequestDB()
        .where(FireStoreConst.uid, isEqualTo: uid)
        .get();
    return hrDeskRequestsCollection.docs.map((e) => e.data()).toList();
  }

  Future<void> setHrRequestDone(
      {required String id,
      required HrRequestStatus status,
      String response = ''}) async {
    Map<String, dynamic> data = <String, dynamic>{
      FireStoreConst.status: status.value,
    };

    if (response.trim().isNotEmpty) {
      data.addEntries([MapEntry(FireStoreConst.response, response)]);
    }

    await _hrRequestDB().doc(id).update(data);
  }
}
