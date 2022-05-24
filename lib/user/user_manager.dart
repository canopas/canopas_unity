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

  String? getUserFullName() {
    final employee = getEmployee();
    String? fullName = employee?.name;
    List<String>? words = fullName?.split(" ");
    String name = words![0];

    return name;
  }

  String? getUserImage() {
    final employee = getEmployee();
    String? imageUrl = employee?.imageUrl;
    return imageUrl;
  }

  bool isUserLoggedIn() {
    return getEmployee() != null;
  }

  bool isOnBoardCompleted() {
    return _userPreference.getOnBoardCompleted() != null;
  }
}
