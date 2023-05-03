import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../core/utils/const/firestore.dart';
import '../model/user/user.dart';

@LazySingleton()
class AccountService {
  final FirebaseFirestore fireStore;
  final CollectionReference<User> accountsDb;

  AccountService(this.fireStore)
      : accountsDb = fireStore.collection('accounts').withConverter(
            fromFirestore: User.fromFireStore,
            toFirestore: (User user, _) => user.toJson());

  Future<void> updateSpaceOfUser(
      {required String spaceID, required String uid}) async {
    await accountsDb.doc(uid).update({
      FireStoreConst.spaces: FieldValue.arrayUnion([spaceID])
    });
  }

  Future<List<String>> fetchSpaceIds({required String uid}) async {
    final userDoc = await accountsDb.doc(uid).get();
    if (userDoc.data() == null) {
      return [];
    } else {
      return userDoc.data()!.spaces;
    }
  }
}
