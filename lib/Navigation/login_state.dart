import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/user/user_manager.dart';

@Singleton()
class LoginState extends ChangeNotifier {
  final UserManager _userManager;
  bool _onBoardComplete = false;

  bool _isLogin = false;

  LoginState(this._userManager) {
    _isLogin = _userManager.isUserLoggedIn();
    _onBoardComplete = _userManager.isOnBoardCompleted();
  }

  bool get isLogin => _isLogin;

  void setUserLogin(bool login) {
    _isLogin = login;
    notifyListeners();
  }

  bool get onBoardComplete => _onBoardComplete;

  void setOnBoardComplete(bool complete) {
    _onBoardComplete = complete;
    notifyListeners();
  }
}
