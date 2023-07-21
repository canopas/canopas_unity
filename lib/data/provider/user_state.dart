import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/Repo/employee_repo.dart';
import 'package:projectunity/data/Repo/leave_repo.dart';
import '../di/service_locator.dart';
import '../model/account/account.dart';
import '../model/employee/employee.dart';
import '../model/space/space.dart';
import '../pref/user_preference.dart';

enum UserState { authenticated, unauthenticated, spaceJoined, update }

@Singleton()
class UserStateNotifier with ChangeNotifier {
  final UserPreference _userPreference;
  UserState _userState = UserState.unauthenticated;

  UserState get state => _userState;

  UserStateNotifier(this._userPreference) {
    getUserStatus();
  }

  void getUserStatus() async {
    if (_userPreference.getAccount() == null) {
      _userState = UserState.unauthenticated;
    } else if (_userPreference.getSpace() != null &&
        _userPreference.getEmployee() != null) {
      _userState = UserState.spaceJoined;
    } else if (_userPreference.getAccount() != null) {
      _userState = UserState.authenticated;
    }
  }

  Future<void> setUser(Account user) async {
    await _userPreference.setAccount(user);
    _userState = UserState.authenticated;
    notifyListeners();
  }

  Future<void> setEmployeeWithSpace(
      {required Space space,
      required Employee spaceUser,
      bool redirect = true}) async {
    await _userPreference.setSpace(space);
    await _userPreference.setEmployee(spaceUser);
    if (redirect) {
      _userState = UserState.update;
      notifyListeners();
      _userState = UserState.spaceJoined;
      await getIt<LeaveRepo>().reset();
      await getIt<EmployeeRepo>().reset();
    }
  }

  Future<void> updateSpace(Space space) async {
    await _userPreference.setSpace(space);
    notifyListeners();
  }

  Future<void> removeEmployeeWithSpace() async {
    await getIt<LeaveRepo>().dispose();
    await getIt<EmployeeRepo>().dispose();
    await _userPreference.removeSpace();
    await _userPreference.removeEmployee();
    _userState = UserState.authenticated;
    notifyListeners();
  }

  Future<void> removeAll() async {
    await _userPreference.clearAll();
    _userState = UserState.unauthenticated;
    notifyListeners();
  }

  String? get userFirebaseAuthName => _userPreference.getAccount()?.name;

  String? get userUID => _userPreference.getAccount()?.uid;

  String? get userEmail => _userPreference.getAccount()?.email;

  Space? get currentSpace => _userPreference.getSpace();

  String? get currentSpaceName => _userPreference.getSpace()?.name;

  String? get currentSpaceId => _userPreference.getSpace()?.id;

  Employee? get _employee => _userPreference.getEmployee();

  String get employeeId => _employee!.uid;

  Employee get employee => _employee!;

  bool get isAdmin => _employee?.role == Role.admin;

  bool get isEmployee => _employee?.role == Role.employee;

  bool get isSpaceOwner => currentSpace?.ownerIds.contains(userUID) ?? false;

  bool get isHR => _employee?.role == Role.hr;
}
