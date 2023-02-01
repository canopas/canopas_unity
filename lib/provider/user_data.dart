import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/pref/user_preference.dart';
import '../core/utils/const/role.dart';

@Singleton()
class UserManager with ChangeNotifier {
  final UserPreference _userPreference;
   bool loggedIn= false;

  UserManager(this._userPreference){
    loggedIn= _userPreference.getCurrentUser()!=null;
  }

  Employee? get _employee => _userPreference.getCurrentUser();

  String get userName => _employee?.name ?? "";

  String get email => _employee?.email ?? "";

  String? get userImage => _employee?.imageUrl;

  String get employeeId => _employee!.id;

  Employee get employee => _employee!;

  String get employeeDesignation => _employee!.designation;

  void hasLoggedIn()async{
    loggedIn= _employee !=null;
    notifyListeners();
  }

  bool get isAdmin => _employee?.roleType == kRoleTypeAdmin;
}
