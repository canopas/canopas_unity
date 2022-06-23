import 'dart:core';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/user/user_manager.dart';

import 'navigation_stack_item.dart';

@Singleton()
class NavigationStackManager extends ChangeNotifier {
  final UserManager _userManager;
  List<NavigationStackItem> _screens = [];
  bool _showBottomBar = true;

  bool get showBottomBar => _showBottomBar;

  NavigationStackManager(this._userManager)
      : _screens = [
          if (_userManager.isAdmin())
            const NavigationStackItem.adminHomeState()
          else
            const NavigationStackItem.employeeHomeState()
        ];

  void setBottomBar(bool show) {
    _showBottomBar = show;
    notifyListeners();
  }

  set screens(List<NavigationStackItem> newItems) {
    _screens = List.from(newItems);
    notifyListeners();
  }

  NavigationStackItem get currentState => _screens.last;

  List<NavigationStackItem> get screens => _screens;

  void push(NavigationStackItem item) {
    _screens.add(item);
    notifyListeners();
  }

  void clearAndPush(NavigationStackItem item) {
    _screens.clear();
    _screens.add(item);
    notifyListeners();
  }

  NavigationStackItem? pop() {
    try {
      final poppedItem = _screens.removeLast();
      notifyListeners();
      return poppedItem;
    } catch (e) {
      return null;
    }
  }
}
