import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/configs/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/utils/const/pref_key.dart';
import '../model/employee/employee.dart';
import '../model/space/space.dart';
import '../model/user/user.dart';

///Its is provide all preferences services.
@Singleton()
class UserPreference {
  final SharedPreferences _preferences;

  UserPreference(this._preferences);

  ///Set user data in preferences
  Future<void> setUser(User user) async {
    await _preferences.setString(PrefKeys.userPrefKeyUser, jsonEncode(user.toJson()));
  }

  ///Get signed user data its null if your not signed in from preferences
  User? getUser() {
    final data = _preferences.getString(PrefKeys.userPrefKeyUser);
    return data == null ? null : User.fromJson(jsonDecode(data));
  }

  ///Set Selected Space
  Future<void> setSpace(Space space) async {
    await _preferences.setString(
        PrefKeys.spacePrefKeyUser, jsonEncode(space.toFirestore()));
  }

  ///Its provide current selected space, its null if user not signed in with space.
  Space? getCurrentSpace() {
    final data = _preferences.getString(PrefKeys.spacePrefKeyUser);
    return data == null ? null : Space.fromJson(jsonDecode(data));
  }

  //OLD

  void setCurrentUser(Employee user) {
    _preferences.setString(
        PrefKeys.spaceUserPrefKeyUser, jsonEncode(user.toJson()));
  }

  void setUserSpaceStatus(int status) {
    _preferences.setInt(PrefKeys.userSpaceStatus, status);
  }

  int? getUserSpaceStatus() {
    final data = _preferences.getInt(PrefKeys.userSpaceStatus);
    return data;
  }

  Employee? getCurrentUser() {
    final data = _preferences.getString(PrefKeys.spaceUserPrefKeyUser);
    return data == null ? null : Employee.fromJson(jsonDecode(data));
  }

  Future<void> removeCurrentUser() async {
    await _preferences.remove(PrefKeys.spaceUserPrefKeyUser);
  }

  Future<void> setToken(String token) async {
    await _preferences.setString(token, token);
  }

  String? getToken() {
    return _preferences.getString(token);
  }
}
