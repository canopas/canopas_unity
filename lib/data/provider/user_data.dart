import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../core/utils/const/role.dart';
import '../model/employee/employee.dart';
import '../model/space/space.dart';
import '../model/user/user.dart';
import '../pref/user_preference.dart';

@Singleton()
class UserManager with ChangeNotifier {
  final UserPreference _userPreference;

  bool loggedIn = false;
  bool spaceSelected = false;
  bool spaceUserExist = false;
  bool spaceChanged = false;

  UserManager(this._userPreference) {
    hasLoggedIn();
  }

  Future<void> setUser(User user) async {
    await _userPreference.setUser(user);
    hasLoggedIn();
  }

  Future<void> setSpace(
      {required Space space, required Employee spaceUser}) async {
    await _userPreference.setSpace(space);
    await _userPreference.setSpaceUser(spaceUser);
    spaceChanged = true;
    hasLoggedIn();
    spaceChanged = false;
  }
  String? get userFirebaseAuthName => _userPreference.getUser()?.name;

  Future<void> updateSpaceDetails(Space space) async {
    await _userPreference.setSpace(space);
  }

  Future<void> removeSpace() async {
    await _userPreference.removeSpace();
    await _userPreference.removeSpaceUser();
    hasLoggedIn();
  }

  Future<void> removeAll() async {
    await _userPreference.clearAll();
    hasLoggedIn();
  }

  void hasLoggedIn() async {
    loggedIn = _userPreference.getUser() != null;
    spaceSelected = _userPreference.getSpace() != null;
    spaceUserExist = _userPreference.getSpaceUser() != null;
    notifyListeners();
  }

  String? get userUID => _userPreference.getUser()?.uid;

  String? get userEmail => _userPreference.getUser()?.email;

  Space? get currentSpace => _userPreference.getSpace();

  String? get currentSpaceId => _userPreference.getSpace()?.id;

  Employee? get _employee => _userPreference.getSpaceUser();

  String get userName => _employee?.name ?? "";

  String get email => _employee?.email ?? "";

  String? get userImage => _employee?.imageUrl;

  String get employeeId => _employee!.uid;

  Employee get employee => _employee!;

  String get employeeDesignation => _employee!.designation ?? '';

  bool get isAdmin => _employee?.role == kRoleTypeAdmin;

  bool get isHR => _employee?.role == kRoleTypeHR;
}
