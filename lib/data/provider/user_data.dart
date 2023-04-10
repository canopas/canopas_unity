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

  UserManager(this._userPreference) {
    hasLoggedIn();
  }

  Future<void> setUser(User user) async {
    await _userPreference.setUser(user);
    hasLoggedIn();
  }

  Future<void> setSpace({required Space space, required Employee admin}) async {
    await _userPreference.setSpace(space);
    await _userPreference.setCurrentUser(admin);
    hasLoggedIn();
  }

  Future<void> removeSpace() async {
    await _userPreference.removeCurrentSpace();
    await _userPreference.removeCurrentUser();
    hasLoggedIn();
  }

  Future<void> removeAll() async {
    await _userPreference.clearAll();
    hasLoggedIn();
  }

  void hasLoggedIn() async {
    loggedIn = _userPreference.getUser() != null;
    spaceSelected = _userPreference.getCurrentSpace() != null;
    spaceUserExist = _userPreference.getCurrentUser() != null;
    notifyListeners();
  }

  String? get userUID => _userPreference.getUser()?.uid;

  String? get userEmail => _userPreference.getUser()?.email;

  Space? get currentSpace => _userPreference.getCurrentSpace();

  String? get currentSpaceId => _userPreference.getCurrentSpace()?.id;

  Employee? get _employee => _userPreference.getCurrentUser();

  String get userName => _employee?.name ?? "";

  String get email => _employee?.email ?? "";

  String? get userImage => _employee?.imageUrl;

  String get employeeId => _employee!.id;

  Employee get employee => _employee!;

  String get employeeDesignation => _employee!.designation;

  bool get isAdmin => _employee?.roleType == kRoleTypeAdmin;

  bool get isHR => _employee?.roleType == kRoleTypeHR;
}
