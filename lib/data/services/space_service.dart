import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../core/utils/const/firestore.dart';
import '../model/space/space.dart';

///Its provide space service like create space, delete space edit space details and get space form database.
@LazySingleton()
class SpaceService {
  final _spaceDb = FirebaseFirestore.instance
      .collection(FirestoreConst.spacesCollection)
      .withConverter(
          fromFirestore: Space.fromFirestore,
          toFirestore: (Space space, _) => space.toFirestore());

  ///For create space in database. you will be admin on your created workspace.
  Future<void> createSpace(
      {required String name,
      required String domain,
      required int timeOff,
      required String ownerId}) async {
    final id = _spaceDb.doc().id;

    await _spaceDb.doc(id).set(Space(
        id: id,
        name: name,
        createdAt: DateTime.now(),
        paidTimeOff: timeOff,
        ownerIds: [ownerId]));
  }

  ///Delete space from database
  Future<void> deleteSpace(String workspaceId) async {
    await _spaceDb.doc(workspaceId).delete();
  }

  ///It will return user space's own created spaces and joined spaces from database.
  Future<List<Space>> getSpacesOfUser(String uid) async {
    final spaceData =
        await _spaceDb.where("owner_ids", arrayContains: uid).get();
    return spaceData.docs.map((space) => space.data()).toList();
  }
}
