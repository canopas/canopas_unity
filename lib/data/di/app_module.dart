import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';


@module
abstract class AppModule {
  @preResolve
  Future<SharedPreferences> get preferences => SharedPreferences.getInstance();
  @LazySingleton()
  Connectivity get connectivity => Connectivity();
  @Injectable()
  ImagePicker get  imagePicker =>ImagePicker();
  @LazySingleton()
  FirebaseStorage get firebaseStorage => FirebaseStorage.instance;
}