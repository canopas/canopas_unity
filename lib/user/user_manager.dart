import 'package:injectable/injectable.dart';
import 'package:projectunity/model/Employee/employee.dart';
import 'package:projectunity/user/user_preference.dart';

@Singleton()
class UserManager {
  final UserPreference _userPreference;

  UserManager(this._userPreference);

  Employee? getEmployee() {
    final employee = _userPreference.getCurrentUser();
    return employee;
  }

  String? getUserName() {
    final employee = getEmployee();
    String? name = employee?.name;
    return name;
  }

  String? getUserImage() {
    final employee = getEmployee();
    String? imageUrl = employee?.imageUrl;
    return imageUrl;
  }

  bool isUserLoggedIn() {
    return getEmployee() == null ? false : true;
  }
}
