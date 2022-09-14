import 'dart:core';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../provider/user_data.dart';
import 'navigationStackItem/admin/admin_navigation_stack_items.dart';
import 'navigationStackItem/employee/employee_navigation_stack_item.dart';
import 'navigationStackItem/navigationStack/navigation_stack_item.dart';
@Singleton()
class NavigationStackManager extends ChangeNotifier {
  final UserManager _userManager;
  List<NavigationStackItem> _screens = [];
  bool _showBottomBar = true;

  NavigationStackManager(this._userManager);

  NavigationStack<NavigationStackItem> get navigation => _userManager.isAdmin
      ? const NavigationStack.admin()
      : const NavigationStack.employee();

  List<AdminNavigationStackItem> adminStackList = [
    const AdminNavigationStackItem.adminHomeState()
  ];
  List<EmployeeNavigationStackItem> employeeStackList = [
    const EmployeeNavigationStackItem.employeeHomeState()
  ];

  bool get showBottomBar => _showBottomBar;

  void setBottomBar(bool show) {
    _showBottomBar = show;
    notifyListeners();
  }

  bool get isAdmin => _userManager.isAdmin;

  set setScreens(List<NavigationStackItem> newItems) {
    _screens = List.from(newItems);
    notifyListeners();
  }

  NavigationStackItem get currentState => _screens.last;

  List<NavigationStackItem> get screens => navigation.when(
      admin: () => _screens = adminStackList,
      employee: () => _screens = employeeStackList);

  void push(NavigationStackItem item) {
    _screens.add(item);
    notifyListeners();
  }

  void clearAndPush(NavigationStackItem item) {
    _screens.clear();
    _screens.add(item);
    notifyListeners();
  }

  @override
  @disposeMethod
  void dispose() {
    super.dispose();
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
