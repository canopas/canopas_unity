import 'dart:core';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'app_state.dart';

@Singleton()
class AppStateManager extends ChangeNotifier {

   List<AppState> _screens = <AppState>[const AppState.homeState()];

  AppState get currentState => _screens.last;

  List<AppState> get screens => _screens;

  void push(int id) {
    _screens.clear();
    switch (id) {
      case 0:
        _screens.add(const AppState.homeState());
        break;
      case 1:
        _screens.add(const AppState.leaveState());
        break;
      case 2:
        _screens.add(const AppState.settingsState());
    }
    notifyListeners();
  }

  void pop() {
    if (_screens.length > 1) {
      _screens.removeLast();
    }
    _screens = [_screens.last];

    notifyListeners();
  }

  void onTapOfEmployee(int id) {
    _screens.add(AppState.employeeDetailState(id: id));
    notifyListeners();
  }

  void onTapOfLeaveRequest() {
    _screens.add(const AppState.leaveRequestState());
    notifyListeners();
  }

  void onTapForUserAllLeaves() {
    _screens.add(const AppState.userAllLeaveState());
    notifyListeners();
  }

  void onPopBackToDesiredScreen(AppState currentState) {
    _screens.remove(currentState);
  }

  void onTapForApplyLeaves() {
    onPopBackToDesiredScreen(currentState);
    onTapForUserAllLeaves();
  }

  void onTapForUserUpComingLeaves() {
    _screens.add(const AppState.userUpcomingLeaveState());
    notifyListeners();
  }

  void onTapForTeamLeaves() {
    _screens.add(const AppState.teamLeavesState());
    notifyListeners();
  }
}
