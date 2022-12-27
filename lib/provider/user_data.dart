import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/pref/user_preference.dart';
import '../core/utils/const/role.dart';

@Singleton()
class UserManager with ChangeNotifier {
  final UserPreference _userPreference;
   bool onBoarded= false;
   bool loggedIn= false;

  UserManager(this._userPreference){
    onBoarded= _userPreference.getOnBoardCompleted()!=null;
    loggedIn= _userPreference.getCurrentUser()!=null;
  }

  Employee? get _employee => _userPreference.getCurrentUser();

  String? getUserName() {
    String? fullName = _employee?.name;
    return fullName;
  }

  String? get userImage => _employee?.imageUrl;

  String get employeeId => _employee!.id;

  Employee get employee => _employee!;

  String get employeeDesignation => _employee!.designation;

  String get userName => getUserName()!;

  bool get isUserLoggedIn => _employee != null;

  void hasOnBoarded(){
    onBoarded= _userPreference.getOnBoardCompleted()!=null;
    notifyListeners();
  }
  void hasLoggedIn(){
    loggedIn= _employee !=null;
    notifyListeners();
  }

  bool get isAdmin => _employee?.roleType == kRoleTypeAdmin;
}
