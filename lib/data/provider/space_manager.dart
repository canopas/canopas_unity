import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../pref/user_preference.dart';

@LazySingleton()
class SpaceManager extends ChangeNotifier{
  final UserPreference _userPreference;
  String? _currentSpaceId;

  SpaceManager(this._userPreference) {
    _currentSpaceId = _userPreference.getSpace()?.id ?? '';
  }

  String? get currentSpaceId => _currentSpaceId;

  Future<void> setCurrentSpaceId(String spaceId) async {
    print('set current space id: ${currentSpaceId == spaceId}');
    print('set current space id: ${currentSpaceId}');
    print('set  space id: ${spaceId}');
    if (currentSpaceId == spaceId) {
      return;
    }
    await _userPreference.setCurrentSpaceId(spaceId);
    _currentSpaceId = spaceId;
    notifyListeners();
  }

  Future<void> removeCurrentSpaceID() async {
    await _userPreference.removeCurrentSpaceId();
    _currentSpaceId = null;
    notifyListeners();
  }
}