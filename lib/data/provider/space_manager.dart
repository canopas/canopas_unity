import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../pref/user_preference.dart';

@LazySingleton()
class SpaceManager extends ChangeNotifier{
  final UserPreference _userPreference;
  late String _currentSpaceId='';
  SpaceManager(this._userPreference) {
    _currentSpaceId = _userPreference.getSpace()?.id ?? '';
  }

  String get currentSpaceId=>_currentSpaceId;

  Future<void> setCurrentSpaceId(String spaceId) async {
    if (currentSpaceId == spaceId) {
      return;
    }
    _currentSpaceId = spaceId;
    notifyListeners();
  }

  Future<void> removeCurrentSpaceID() async {
    _currentSpaceId = '';
    notifyListeners();
  }
}