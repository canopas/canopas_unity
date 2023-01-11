import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:projectunity/model/employee/employee.dart';
import '../../provider/device_info.dart';
import '../../pref/user_preference.dart';
import '../../services/auth/auth_service.dart';

@Singleton()
class AuthManager {
  final AuthService _authService;
  final UserPreference _userPreference;

  AuthManager(this._userPreference, this._authService);

  Future<void> updateUser(Employee user) async {
    final session = await DeviceInfoProvider.getDeviceInfo();
    _authService.updateUserData(user, session);
    _userPreference.setCurrentUser(jsonEncode(user.toJson()));
  }

  Future<Employee?> getUser(String email) async {
    var employee = await _authService.getUserData(email);
    return employee;
  }
}
