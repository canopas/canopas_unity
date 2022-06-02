import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:projectunity/model/Employee/employee.dart';

import '../user/user_preference.dart';
import 'auth_service.dart';
import 'login/device_info_provider.dart';

@Singleton()
class AuthManager {
  final AuthService _authService;
  final UserPreference _userPreference;

  AuthManager(this._userPreference, this._authService);

  updateUser(Employee user) async {
    final session = await DeviceInfoProvider.getDeviceInfo();
    _authService.updateUserData(user, session);
    _userPreference.updateCurrentUser(jsonEncode(user.employeeToJson()));
  }

  Future<Employee?> getUser(String email) async {
    var employee = await _authService.getUserData(email);
    return employee;
  }
}
