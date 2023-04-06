import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/configs/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/utils/const/pref_key.dart';
import '../model/employee/employee.dart';

@Singleton()
class UserPreference {
  final SharedPreferences _preferences;

  UserPreference(this._preferences);

  void setCurrentUser(Employee user) {
    _preferences.setString(PrefKeys.userPrefKeyUser, jsonEncode(user.toJson()));
  }

  void setAuthenticationStatus(User? user) {
    _preferences.setString(PrefKeys.firebaseAuthenticationId, user!.uid);
  }

  String? getCurrentUid() {
    final data = _preferences.getString(PrefKeys.firebaseAuthenticationId);
    return data;
  }

  void setUserSpaceStatus(int status) {
    _preferences.setInt(PrefKeys.userSpaceStatus, status);
  }

  int? getUserSpaceStatus() {
    final data = _preferences.getInt(PrefKeys.userSpaceStatus);
    return data;
  }

  Employee? getCurrentUser() {
    final data = _preferences.getString(PrefKeys.userPrefKeyUser);
    return data == null ? null : Employee.fromJson(jsonDecode(data));
  }

  Future<void> removeCurrentUser() async {
    await _preferences.remove(PrefKeys.userPrefKeyUser);
  }

  Future<void> setToken(String token) async {
    await _preferences.setString(token, token);
  }

  String? getToken() {
    return _preferences.getString(token);
  }
}
