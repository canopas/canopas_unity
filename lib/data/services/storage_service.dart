import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class StorageService {
  final FirebaseStorage firebaseStorage;

  StorageService(this.firebaseStorage);

  Future<String> uploadProfilePic(
      {required String path, required String imagePath}) async {
    final Reference storageRef = firebaseStorage.ref().child(path);
    final data = await XFile(imagePath).readAsBytes();
    await storageRef.putData(data);
    String downloadedURL = await storageRef.getDownloadURL();
    return downloadedURL;
  }

  Future<void> deleteProfileImage(String path) async {
    final Reference storageRef = firebaseStorage.ref().child(path);
    await storageRef.delete();
  }
}
