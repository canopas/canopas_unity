import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class StorageService {
  final FirebaseStorage firebaseStorage;

  StorageService(this.firebaseStorage);

  Future<String> uploadProfilePic(
      {required String path, required File file}) async {
    final Reference storageRef = firebaseStorage.ref().child(path);
    await storageRef.putFile(file);
    String downloadedURL = await storageRef.getDownloadURL();
    return downloadedURL;
  }

  Future<void> deleteProfileImage(String path) async {
    final Reference storageRef = firebaseStorage.ref().child(path);
    await storageRef.delete();
  }
}
