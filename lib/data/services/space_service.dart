import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../core/utils/const/firestore.dart';
import '../model/space/space.dart';

@LazySingleton()
class SpaceService {
  late final FirebaseFirestore fireStore;
  late final CollectionReference<Space> _spaceDb;
  late final CollectionReference<Map> _accountsDb;

  SpaceService(this.fireStore)
      : _spaceDb = fireStore
            .collection(FireStoreConst.spacesCollection)
            .withConverter(
                fromFirestore: Space.fromFirestore,
                toFirestore: (Space space, _) => space.toFirestore()),
        _accountsDb = fireStore.collection(FireStoreConst.accountsCollection);

  Future<Space?> getSpace(String spaceId) async {
    final spaceDoc = await _spaceDb.doc(spaceId).get();
    return spaceDoc.data();
  }

  String get generateNewSpaceId => _spaceDb.doc().id;

  Future<void> createSpace({required Space space}) async {
    await _spaceDb.doc(space.id).set(space);
    for (final String ownerId in space.ownerIds) {
      await _accountsDb.doc(ownerId).update({
        FireStoreConst.spaces: FieldValue.arrayUnion([space.id]),
      });
    }
  }

  Future<void> updateSpace(Space space) async {
    await _spaceDb.doc(space.id).update(space.toFirestore());
  }

  Future<void> deleteSpace(
      {required String spaceId,
      required List<String> owners,
      required String uid}) async {
    final leavesDocs =
        await _spaceDb.doc(spaceId).collection(FireStoreConst.leaves).get();
    for (var doc in leavesDocs.docs) {
      await doc.reference.delete();
    }

    final membersDocs = await _spaceDb
        .doc(spaceId)
        .collection(FireStoreConst.membersCollection)
        .where(FireStoreConst.uid, isNotEqualTo: uid)
        .get();

    for (var doc in membersDocs.docs) {
      await doc.reference.delete();
    }

    final currentMemberDoc = await _spaceDb
        .doc(spaceId)
        .collection(FireStoreConst.membersCollection)
        .where(FireStoreConst.uid, isEqualTo: uid)
        .get();

    await currentMemberDoc.docs.first.reference.delete();

    await _spaceDb.doc(spaceId).delete();

    for (String owner in owners) {
      await _accountsDb.doc(owner).update({
        FireStoreConst.spaces: FieldValue.arrayRemove([spaceId]),
      });
    }
  }

  Future<int> getPaidLeaves({required String spaceId}) async {
    return await _spaceDb.doc(spaceId).get().then((val) {
      if (val.data()?.paidTimeOff != null) {
        return val.data()!.paidTimeOff;
      }
      return 0;
    });
  }
}
