import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/utils/const/pref_key.dart';
import '../model/employee/employee.dart';
import '../model/space/space.dart';
import '../model/user/user.dart';

@Singleton()
class UserPreference {
  final SharedPreferences _preferences;

  UserPreference(this._preferences);

  Future<void> setUser(User user) async {
    await _preferences.setString(PrefKeys.user, jsonEncode(user.toJson()));
  }

  User? getUser() {
    final data = _preferences.getString(PrefKeys.user);
    return data == null ? null : User.fromJson(jsonDecode(data));
  }

  Future<void> removeUser() async {
    await _preferences.remove(PrefKeys.user);
  }

  Future<void> setSpace(Space space) async {
    await _preferences.setString(
        PrefKeys.space, jsonEncode(space.toFirestore()));
  }

  Space? getCurrentSpace() {
    final data = _preferences.getString(PrefKeys.space);
    return data == null ? null : Space.fromJson(jsonDecode(data));
  }

  Future<void> removeCurrentSpace() async {
    await _preferences.remove(PrefKeys.spaceUser);
  }

  Future<void> setCurrentUser(Employee user) async {
    await _preferences.setString(PrefKeys.spaceUser, jsonEncode(user.toJson()));
  }

  Employee? getCurrentUser() {
    final data = _preferences.getString(PrefKeys.spaceUser);
    return data == null ? null : Employee.fromJson(jsonDecode(data));
  }

  Future<void> removeCurrentUser() async {
    await _preferences.remove(PrefKeys.spaceUser);
  }

  Future<void> clearAll() async {
    await _preferences.clear();
  }
}
