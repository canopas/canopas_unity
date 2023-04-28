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

  Space? getSpace() {
    final data = _preferences.getString(PrefKeys.space);
    return data == null ? null : Space.fromJson(jsonDecode(data));
  }

  Future<void> removeSpace() async {
    await _preferences.remove(PrefKeys.space);
  }

  Future<void> setSpaceUser(Employee user) async {
    await _preferences.setString(PrefKeys.spaceUser, jsonEncode(user.toJson()));
  }

  Employee? getSpaceUser() {
    final data = _preferences.getString(PrefKeys.spaceUser);
    return data == null ? null : Employee.fromJson(jsonDecode(data));
  }

  Future<void> removeSpaceUser() async {
    await _preferences.remove(PrefKeys.spaceUser);
  }

  Future<void> clearAll() async {
    await _preferences.clear();
  }
}
