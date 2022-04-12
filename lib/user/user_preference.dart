import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:projectunity/model/Employee/employee.dart';
import 'package:projectunity/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable()
class UserPreference {
  final SharedPreferences _preferences;

  UserPreference(this._preferences);

  void updateCurrentUser(String employee) {
    _preferences.setString(userPrefKeyUser, employee);
  }

  Employee? getCurrentUser() {
    final data = _preferences.getString(userPrefKeyUser) ?? "";
    if (data.isEmpty) return null;
    return Employee.fromJson(jsonDecode(data));
  }

  String? getAccessToken() {
    return _preferences.getString(userPrefKeyAccessToken);
  }

  void setAccessToken(String? accessToken) {
    _preferences.setString(userPrefKeyAccessToken, accessToken ?? "");
  }

  String? getRefreshToken() {
    return _preferences.getString(userPrefKeyRefreshToken);
  }

  void setRefreshToken(String? refreshToken) {
    _preferences.setString(userPrefKeyRefreshToken, refreshToken ?? "");
  }
}
