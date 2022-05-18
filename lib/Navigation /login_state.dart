import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/user/user_manager.dart';

@Singleton()
class LoginState extends ChangeNotifier {
  final UserManager _userManager;

  bool _isLogin = false;

  LoginState(this._userManager) {
    _isLogin = _userManager.isUserLoggedIn();
  }

  bool get isLogin => _isLogin;

  void setUserLogin(bool login) {
    _isLogin = login;
    notifyListeners();
  }
}
