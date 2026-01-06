import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class StorageService {
  final FirebaseStorage firebaseStorage;

  StorageService(this.firebaseStorage);

  Future<String> uploadProfilePic({
    required String path,
    required String imagePath,
  }) async {
    final Reference storageRef = firebaseStorage.ref().child(path);
    final data = await XFile(imagePath).readAsBytes();
    await storageRef.putData(data);
    String downloadedURL = await storageRef.getDownloadURL();
    return downloadedURL;
  }

  Future<void> deleteProfileImage(String path) async {
    await firebaseStorage.ref().child(path).delete();
  }

  Future<void> deleteStorageFolder(String path) async {
    final ref = firebaseStorage.ref(path);
    await _deleteReference(ref);
  }

  Future<void> _deleteReference(Reference reference) async {
    final ListResult result = await reference.listAll();
    final List<Reference> allFiles = result.items;
    final List<Reference> allFolders = result.prefixes;

    for (final file in allFiles) {
      await file.delete();
    }

    for (final folder in allFolders) {
      await _deleteReference(folder);
    }
  }
}
