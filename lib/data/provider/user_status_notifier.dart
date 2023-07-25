import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../model/account/account.dart';
import '../model/employee/employee.dart';
import '../model/space/space.dart';
import '../pref/user_preference.dart';

enum UserStatus { authenticated, unauthenticated, spaceJoined, update }

@Singleton()
class UserStatusNotifier with ChangeNotifier {
  final UserPreference _userPreference;
  UserStatus _userStatus = UserStatus.unauthenticated;

  UserStatus get state => _userStatus;

  UserStatusNotifier(this._userPreference) {
    getUserStatus();
  }

  void getUserStatus() async {
    if (_userPreference.getAccount() == null) {
      _userStatus = UserStatus.unauthenticated;
    } else if (_userPreference.getSpace() != null &&
        _userPreference.getEmployee() != null) {
      _userStatus = UserStatus.spaceJoined;
    } else if (_userPreference.getAccount() != null) {
      _userStatus = UserStatus.authenticated;
    }
  }

  Future<void> setUser(Account user) async {
    await _userPreference.setAccount(user);
    _userStatus = UserStatus.authenticated;
    notifyListeners();
  }

  Future<void> updateCurrentUser(Employee user)async {
    if (_userPreference.getEmployee() == null) {
      _userStatus = UserStatus.spaceJoined;
      await _userPreference.setEmployee(user);
      notifyListeners();
    }
    if (_userPreference.getEmployee()?.role != user.role) {
      _userStatus = UserStatus.update;
      await _userPreference.setEmployee(user);
      notifyListeners();
    }
    _userStatus = UserStatus.spaceJoined;
  }

  Future<void> updateSpace(Space space) async {
    await _userPreference.setSpace(space);
    notifyListeners();
  }

  Future<void> removeEmployeeWithSpace() async {
    await _userPreference.removeSpace();
    await _userPreference.removeEmployee();
    _userStatus = UserStatus.authenticated;
    notifyListeners();
  }

  Future<void> removeAll() async {
    await _userPreference.clearAll();
    _userStatus = UserStatus.unauthenticated;
    notifyListeners();
  }

  String? get userFirebaseAuthName => _userPreference.getAccount()?.name;

  String? get userUID => _userPreference.getAccount()?.uid;

  String? get userEmail => _userPreference.getAccount()?.email;

  Space? get currentSpace => _userPreference.getSpace();

  String? get currentSpaceId => _userPreference.getSpace()?.id;

  Employee? get _employee => _userPreference.getEmployee();

  String get employeeId => _employee!.uid;

  Employee? get employee => _employee;

  bool get isAdmin => _employee?.role == Role.admin;

  bool get isEmployee => _employee?.role == Role.employee;

  bool get isSpaceOwner => currentSpace?.ownerIds.contains(userUID) ?? false;

  bool get isHR => _employee?.role == Role.hr;
}
