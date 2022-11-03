import 'package:injectable/injectable.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/pref/user_preference.dart';
import '../core/utils/const/role.dart';

@Singleton()
class UserManager {
  final UserPreference _userPreference;

  UserManager(this._userPreference);

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

  bool get isOnBoardCompleted => _userPreference.getOnBoardCompleted() != null;

  bool get isAdmin => _employee?.roleType == kRoleTypeAdmin;
}
