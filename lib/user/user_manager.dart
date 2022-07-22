import 'package:injectable/injectable.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/user/user_preference.dart';

@Singleton()
class UserManager {
  final UserPreference _userPreference;
  late final Employee? _employee;

  UserManager(this._userPreference)
      : _employee = _userPreference.getCurrentUser();

  String? getUserName() {
    String? fullName = _employee?.name;
    List<String>? words = fullName?.split(" ");
    String name = words![0];

    return fullName;
  }

  String? getUserImage() {
    String? imageUrl = _employee?.imageUrl;
    return imageUrl;
  }

  String getId() {
    print(_employee!.id.toString());
    return _employee!.id!;
  }

  bool isUserLoggedIn() {
    return _employee != null;
  }

  bool isOnBoardCompleted() {
    return _userPreference.getOnBoardCompleted() != null;
  }

  bool isAdmin() {
    return _employee?.roleType == kRoleTypeAdmin;
  }
}
