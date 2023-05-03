import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../core/utils/const/firestore.dart';
import '../model/space/space.dart';

@LazySingleton()
class SpaceService {
  late final FirebaseFirestore fireStore;
  late final CollectionReference<Space> _spaceDb;
  late final CollectionReference<Map> _userDb;

  SpaceService(this.fireStore)
      : _spaceDb = fireStore
            .collection(FireStoreConst.spacesCollection)
            .withConverter(
                fromFirestore: Space.fromFirestore,
                toFirestore: (Space space, _) => space.toFirestore()),
        _userDb = fireStore.collection(FireStoreConst.accountsCollection);

  Future<Space?> getSpace(String spaceId) async {
    final spaceDoc = await _spaceDb.doc(spaceId).get();
    return spaceDoc.data();
  }

  Future<Space> createSpace({
    String? logo,
    required String name,
    String? domain,
    required int timeOff,
    required String ownerId,
  }) async {
    final id = _spaceDb.doc().id;

    final space = Space(
        logo: logo,
        id: id,
        name: name,
        domain: domain,
        createdAt: DateTime.now(),
        paidTimeOff: timeOff,
        ownerIds: [ownerId]);

    await _spaceDb.doc(id).set(space);
    await _userDb.doc(ownerId).update({
      FireStoreConst.spaces: FieldValue.arrayUnion([id]),
    });

    return space;
  }

  Future<void> updateSpace(Space space) async {
    await _spaceDb.doc(space.id).update(space.toFirestore());
  }

  Future<void> deleteSpace(String workspaceId, List<String> owners) async {
    final leavesDocs =
        await _spaceDb.doc(workspaceId).collection(FireStoreConst.leaves).get();
    for (var doc in leavesDocs.docs) {
      await doc.reference.delete();
    }

    final membersDocs = await _spaceDb
        .doc(workspaceId)
        .collection(FireStoreConst.membersCollection)
        .get();
    for (var doc in membersDocs.docs) {
      await doc.reference.delete();
    }

    await _spaceDb.doc(workspaceId).delete();

    for (String owner in owners) {
      await _userDb.doc(owner).update({
        FireStoreConst.spaces: FieldValue.arrayRemove([workspaceId]),
      });
    }
  }

  Future<List<Space>> getSpacesOfUser(String uid) async {
    final spaceData =
        await _spaceDb.where(FireStoreConst.ownerIds, arrayContains: uid).get();
    return spaceData.docs.map((space) => space.data()).toList();
  }

  Future<int> getPaidLeaves({required String spaceId}) async {
    return await _spaceDb.doc(spaceId).get().then((val) {
      if (val.data()?.paidTimeOff != null) {
        return val.data()!.paidTimeOff;
      }
      return 0;
    });
  }

  Future<void> updateLeaveCount(
      {required String spaceId, required int paidLeaveCount}) async {
    return _spaceDb
        .doc(spaceId)
        .update({FireStoreConst.paidTimeOff: paidLeaveCount});
  }
}
