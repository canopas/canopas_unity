import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/utils/const/pref_key.dart';

@Injectable()
class UserPreference {
  final SharedPreferences _preferences;

  UserPreference(this._preferences);

  void setCurrentUser(String employee) {
    _preferences.setString(userPrefKeyUser, employee);
  }

  Employee? getCurrentUser() {
    final data = _preferences.getString(userPrefKeyUser) ?? "";
    if (data.isEmpty) return null;
    return Employee.fromJson(jsonDecode(data));
  }

  bool? getOnBoardCompleted() {
    return _preferences.getBool(onBoardCompleted);
  }

  void setOnBoardCompleted(bool isComplete) {
    _preferences.setBool(onBoardCompleted, isComplete);
  }
}
