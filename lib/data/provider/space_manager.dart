import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../pref/user_preference.dart';

@LazySingleton()
class SpaceManager extends ChangeNotifier{
  final UserPreference _userPreference;
  late String _currentSpaceId='';
  SpaceManager(this._userPreference) {
    _currentSpaceId = _userPreference.getSpace()?.id ?? '';
    print('CURRENT SPACE ID: ======================= $currentSpaceId');
  }

  String get currentSpaceId=>_currentSpaceId;

  Future<void> setCurrentSpaceId(String spaceId) async {
    if (currentSpaceId == spaceId) {
      print('${spaceId == currentSpaceId} in SPACE  ẓMANAGER');
      //return;
    }
    print('$spaceId in SPACE  ẓMANAGER');
    _currentSpaceId = spaceId;
    notifyListeners();
  }

  Future<void> removeCurrentSpaceID() async {
    _currentSpaceId = '';
    notifyListeners();
  }
}