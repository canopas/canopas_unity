import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/Navigation%20/screen_state.dart';
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

  final List<ScreenState> _screens = <ScreenState>[homeScreenState];

  ScreenState get currentScreen => _screens.last;

  List<AppState> appStateList = const [
    AppState.homeState(),
    AppState.leaveState(),
    AppState.settingsState()
  ];

  List<Page> buildPages() {
    List<Page> pageList = _screens
        .map((e) => currentScreen.appState.when(
              homeState: () {
                return MaterialPage(child: EmployeeListScreen());
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

  void onBottomTabClick(index) {
    _selectedBottomIndex = index;
    if (_selectedBottomIndex != currentScreen.id) {
      _screens.add(ScreenState(
          appState: appStateList[_selectedBottomIndex],
          id: _selectedBottomIndex));
    }
    notifyListeners();
  }

  ScreenState? pop() {
    final poppedPage = _screens.removeLast();
    int id = currentScreen.id;
    if (id != _selectedBottomIndex) {
      onBottomTabClick(0);
      return poppedPage;
    }
    onBottomTabClick(_selectedBottomIndex);
    notifyListeners();
    return null;
  }

  void onTapOfEmployee(int id) {
    _screens.add(ScreenState(
        appState: AppState.employeeDetailState(id: id),
        id: _selectedBottomIndex));
    notifyListeners();
  }

  void onTapOfLeaveRequest() {
    _screens.add(leaveRequestScreenState);
    notifyListeners();
  }

  void onTapForUserAllLeaves() {
    _screens.add(userAllLeavesScreenState);
    notifyListeners();
  }

  void onPopBackToDesiredScreen(ScreenState currentScreen) {
    _screens.remove(currentScreen);
  }

  void onTapForApplyLeaves() {
    onPopBackToDesiredScreen(currentScreen);
    onTapForUserAllLeaves();
  }

  void onTapForUserUpComingLeaves() {
    _screens.add(userUpComingLeavesScreenState);
    notifyListeners();
  }

  void onTapForTeamLeaves() {
    _screens.add(teamLeavesScreenState);
    notifyListeners();
  }
}
