import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:projectunity/configs/api.dart';
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
    final data = _preferences.getString(userPrefKeyUser);
    return data == null ? null : Employee.fromJson(jsonDecode(data));
  }

  Future<bool> removeCurrentUser() async {
    return await _preferences.remove(userPrefKeyUser);
  }

  Future<void> setToken(String token)async{
    await _preferences.setString(token, token);
  }

  String? getToken(){
    return _preferences.getString(token);
  }

}
