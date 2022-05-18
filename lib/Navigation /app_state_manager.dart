import 'dart:core';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/User/Employee/employee_detail_screen.dart';
import 'package:projectunity/ui/User/Employee/employee_list_screen.dart';
import 'package:projectunity/ui/User/Leave/LeaveDetail/LoggedInUser/all_leaves.dart';
import 'package:projectunity/ui/User/Leave/LeaveDetail/LoggedInUser/upcoming_leaves.dart';
import 'package:projectunity/ui/User/Leave/LeaveDetail/team_leaves.dart';
import 'package:projectunity/ui/User/Leave/leave_request_form.dart';
import 'package:projectunity/ui/User/Leave/leave_screen.dart';
import 'package:projectunity/ui/User/setting_screen.dart';

import 'app_state.dart';

@Singleton()
class AppStateManager extends ChangeNotifier {
  int _selectedBottomIndex = 0;

  int get selectedBottomIndex => _selectedBottomIndex;

  final List<AppState> _screens = <AppState>[const AppState.homeState()];

  AppState get currentState => _screens[_selectedBottomIndex];

  List<Page> buildPages() {
    List<Page> pageList = _screens
        .map((screen) => screen.when(
              homeState: () {
                return const MaterialPage(child: EmployeeListScreen());
              },
              employeeDetailState: (int selectedEmployee) {
                return MaterialPage(
                    child: EmployeeDetailScreen(
                  id: selectedEmployee,
                ));
              },
              leaveState: () {
                return MaterialPage(child: LeaveScreen());
          },
          userAllLeaveState: () =>
          const MaterialPage(child: AllLeavesUserScreen()),
          userUpcomingLeaveState: () =>
          const MaterialPage(child: UpComingLeavesUserScreen()),
          leaveRequestState: () =>
                  const MaterialPage(child: LeaveRequestForm()),
              settingsState: () => const MaterialPage(child: SettingScreen()),
              teamLeavesState: () =>
                  const MaterialPage(child: TeamLeavesScreen()),
            ))
        .toList(growable: true);
    notifyListeners();
    return pageList;
  }

  void push(int id) {
    _screens.clear();
    _selectedBottomIndex = id;

    switch (_selectedBottomIndex) {
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
    _screens.removeLast();
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
