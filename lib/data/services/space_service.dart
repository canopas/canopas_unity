import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../model/space/space.dart';

@LazySingleton()
class SpaceService {
  final _spaceDb = FirebaseFirestore.instance
      .collection('spaces')
      .withConverter(
          fromFirestore: Space.fromFirestore,
          toFirestore: (Space space, _) => space.toFirestore());

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

  Future<void> deleteSpace(String workspaceId) async {
    await _spaceDb.doc(workspaceId).delete();
  }
}
