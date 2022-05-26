import 'dart:core';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'navigation_stack_item.dart';

@Singleton()
class NavigationStackManager extends ChangeNotifier {
  List<NavigationStackItem> _screens = [const NavigationStackItem.homeState()];

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
