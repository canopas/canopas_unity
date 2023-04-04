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

  Future<void> createSpace(Space spaceData) async {
    await _spaceDb.add(spaceData);
  }
}
