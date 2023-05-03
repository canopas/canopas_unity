import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:projectunity/data/model/session/session.dart';
import 'package:projectunity/data/provider/device_info.dart';
import '../core/utils/const/firestore.dart';
import '../model/user/user.dart';

@LazySingleton()
class AccountService {
  final FirebaseFirestore fireStore;
  final DeviceInfoProvider deviceInfoProvider;
  final CollectionReference<User> _accountsDb;

  AccountService(this.fireStore, this.deviceInfoProvider)
      : _accountsDb = fireStore
            .collection(FireStoreConst.accountsCollection)
            .withConverter(
                fromFirestore: User.fromFireStore,
                toFirestore: (User user, _) => user.toJson());

  Future<User> getUser(firebase_auth.User authData) async {
    final userDataDoc = await _accountsDb.doc(authData.uid).get();
    final User user;
    final User? userData = userDataDoc.data();
    if (userData != null) {
      user = userData;
    } else {
      user = User(
          uid: authData.uid,
          email: authData.email!,
          name: authData.displayName);
      await _accountsDb.doc(authData.uid).set(user);
    }
    await _setUserSession(authData.uid);
    return user;
  }

  Future<void> _setUserSession(String uid) async {
    final Session? session = await deviceInfoProvider.getDeviceInfo();
    if (session != null) {
      await _accountsDb
          .doc(uid)
          .collection(FireStoreConst.session)
          .doc(FireStoreConst.session)
          .set(session.toJson());
    }
  }

  Future<void> updateSpaceOfUser(
      {required String spaceID, required String uid}) async {
    await _accountsDb.doc(uid).update({
      FireStoreConst.spaces: FieldValue.arrayUnion([spaceID])
    });
  }

  Future<List<String>> fetchSpaceIds({required String uid}) async {
    final userDoc = await _accountsDb.doc(uid).get();
    if (userDoc.data() == null) {
      return [];
    } else {
      return userDoc.data()!.spaces;
    }
  }
}
