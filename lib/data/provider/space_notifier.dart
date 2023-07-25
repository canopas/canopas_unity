import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../pref/user_preference.dart';

@LazySingleton()
class SpaceNotifier extends ChangeNotifier {
  final UserPreference _userPreference;
  String? _currentSpaceId;

  SpaceNotifier(this._userPreference) {
    _currentSpaceId = _userPreference.getSpace()?.id ?? '';
  }

  String? get currentSpaceId => _currentSpaceId;

  Future<void> setCurrentSpaceId(String spaceId) async {
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