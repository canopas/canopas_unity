import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../core/utils/const/firestore.dart';
import '../model/space/space.dart';

@LazySingleton()
class SpaceService {
  final _spaceDb = FirebaseFirestore.instance
      .collection(FireStoreConst.spacesCollection)
      .withConverter(
          fromFirestore: Space.fromFirestore,
          toFirestore: (Space space, _) => space.toFirestore());

  final _usersDb =
      FirebaseFirestore.instance.collection(FireStoreConst.accountsCollection);

  Future<Space> createSpace(
      {required String name,
      required String domain,
      required int timeOff,
      required String ownerId,
      required String ownerEmail}) async {
    final id = _spaceDb.doc().id;

    final space = Space(
        id: id,
        name: name,
        createdAt: DateTime.now(),
        paidTimeOff: timeOff,
        ownerIds: [ownerId]);

    await _spaceDb.doc(id).set(space);

    await _usersDb.doc(ownerId).update({
      FireStoreConst.spaces: FieldValue.arrayUnion([id]),
    });

    return space;
  }

  Future<void> deleteSpace(String workspaceId, List<String> owners) async {
    await _spaceDb.doc(workspaceId).delete();
    for (String owner in owners) {
      await _usersDb.doc(owner).update({
        FireStoreConst.spaces: FieldValue.arrayRemove([workspaceId]),
      });
    }
  }

  Future<List<Space>> getSpacesOfUser(String uid) async {
    final spaceData =
        await _spaceDb.where(FireStoreConst.ownerIds, arrayContains: uid).get();
    return spaceData.docs.map((space) => space.data()).toList();
  }
}
