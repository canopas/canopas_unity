import 'package:injectable/injectable.dart';
import 'package:projectunity/model/Employee/employee.dart';
import 'package:projectunity/user/user_preference.dart';

@Singleton()
class UserManager {
  final UserPreference _userPreference;
  Employee? employee;

  UserManager(this._userPreference)
      : employee = _userPreference.getCurrentUser();

  String? getUserName() {
    String? name = employee?.name;
    return name;
  }

  String? getUserImage() {
    String? imageUrl = employee?.imageUrl;
    return imageUrl;
  }
}
