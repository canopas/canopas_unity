import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../pref/user_preference.dart';

@LazySingleton()
class SpaceManager extends ChangeNotifier{
  final UserPreference _userPreference;
  late String _currentSpaceId='';
  SpaceManager(this._userPreference){
    _currentSpaceId= _userPreference.getCurrentSpaceId()??'';
  }

  String get currentSpaceId=>_currentSpaceId;

  void setCurrentSpaceId(String spaceId){
    print('$spaceId in SPACEMANAGER');
    _currentSpaceId= spaceId;
    notifyListeners();
  }
}