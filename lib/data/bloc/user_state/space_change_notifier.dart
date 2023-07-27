import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SpaceChangeNotifier extends ChangeNotifier {
  String? currentSpaceId;

  void setSpaceId({required String spaceId}) {
    currentSpaceId = spaceId;
    notifyListeners();
  }

  void removeSpaceId() {
    currentSpaceId = null;
    notifyListeners();
  }
}
