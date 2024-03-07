import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/utils/const/pref_key.dart';
import '../model/account/account.dart';
import '../model/employee/employee.dart';
import '../model/space/space.dart';

@LazySingleton()
class UserPreference {
  final SharedPreferences _preferences;

  UserPreference(this._preferences);

  Future<void> setAccount(Account user) async {
    await _preferences.setString(PrefKeys.user, jsonEncode(user.toJson()));
  }

  Account? getAccount() {
    final data = _preferences.getString(PrefKeys.user);
    return data == null ? null : Account.fromJson(jsonDecode(data));
  }

  Future<void> removeAccount() async {
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

  Future<void> setEmployee(Employee user) async {
    await _preferences.setString(PrefKeys.spaceUser, jsonEncode(user.toJson()));
  }

  Employee? getEmployee() {
    final data = _preferences.getString(PrefKeys.spaceUser);
    return data == null ? null : Employee.fromJson(jsonDecode(data));
  }

  Future<void> removeEmployee() async {
    await _preferences.remove(PrefKeys.spaceUser);
  }

  Future<void> clearAll() async {
    await _preferences.clear();
  }
}
