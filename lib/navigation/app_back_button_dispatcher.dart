import 'package:flutter/cupertino.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';

class AppBackButtonDispatcher extends RootBackButtonDispatcher {
  final NavigationStackManager _navigationStackManager;

  AppBackButtonDispatcher(this._navigationStackManager);

  @override
  Future<bool> didPopRoute() {
    if (_navigationStackManager.pages.length > 1) {
      _navigationStackManager.pop();
      return Future.value(true);
    }
    return super.didPopRoute();
  }
}
