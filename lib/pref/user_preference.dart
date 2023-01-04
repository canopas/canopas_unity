import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/utils/const/pref_key.dart';

@Singleton()
class UserPreference {
  final SharedPreferences _preferences;

  UserPreference(this._preferences);

  void setCurrentUser(String employee) {
    _preferences.setString(PrefKeys.userPrefKeyUser, employee);
  }

  Employee? getCurrentUser() {
    final data = _preferences.getString(PrefKeys.userPrefKeyUser);
    return data == null ? null : Employee.fromJson(jsonDecode(data));
  }

  Future<void> removeCurrentUser() async {
     await _preferences.remove(PrefKeys.userPrefKeyUser);
  }

}
