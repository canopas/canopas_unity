import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class WorkspaceService {
  //TODO: add json converter
  final _spaceDb = FirebaseFirestore.instance.collection('spaces');

  Future<void> deleteWorkspace(String workspaceId) async {
    await _spaceDb.doc(workspaceId).delete();
  }
}
