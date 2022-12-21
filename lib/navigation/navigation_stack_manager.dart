import 'dart:core';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import '../provider/user_data.dart';

@Singleton()
class NavigationStackManager extends ChangeNotifier {
  final UserManager _userManager;
  List<NavStackItem> _pages = [];

  List<NavStackItem> get pages => _pages;

  NavigationStackManager(this._userManager) {
    if (!_userManager.isOnBoardCompleted) {
      _pages.add(const OnboardNavStackItem());
    } else if (!_userManager.isUserLoggedIn) {
      _pages.add(const LoginNavStackItem());
    } else if (_userManager.isAdmin) {
      _pages.add(const AdminHomeNavStackItem());
    } else {
      _pages.add(const EmployeeHomeNavStackItem());
    }
  }

  NavStackItem get currentState => _pages.last;
  NavStackItem get previousState => _pages.elementAt(_pages.indexOf(_pages.last)-1);

  void updateStack(List<NavStackItem> newItems) {
    _pages = List.from(newItems);
    notifyListeners();
  }

  void push(NavStackItem item) {
    _pages.add(item);
    notifyListeners();
  }

  void clearAndPush(NavStackItem item) {
    _pages.clear();
    _pages.add(item);
    notifyListeners();
  }

  @override
  @disposeMethod
  void dispose() {
    super.dispose();
  }

  bool canPop()=>_pages.length>1;

  void pop() {
    if(canPop()) {
      _pages.removeLast();
      notifyListeners();
    }
  }
}
