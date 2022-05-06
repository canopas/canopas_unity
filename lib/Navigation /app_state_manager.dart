import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/User/Employee/employee_detail_screen.dart';
import 'package:projectunity/ui/User/Employee/employee_list_screen.dart';
import 'package:projectunity/ui/User/Leave/LeaveDetail/LoggedInUser/all_leaves.dart';
import 'package:projectunity/ui/User/Leave/LeaveDetail/LoggedInUser/upcoming_leaves.dart';
import 'package:projectunity/ui/User/Leave/leave_request_form.dart';
import 'package:projectunity/ui/User/Leave/leave_screen.dart';
import 'package:projectunity/ui/User/setting_screen.dart';

import 'app_state.dart';

@Singleton()
class AppStateManager extends ChangeNotifier {
  int _selectedBottomIndex = 0;

  int get selectedBottomIndex => _selectedBottomIndex;

  late int selectedEmployeeID;

  List<TabScreen> screens = <TabScreen>[
    TabScreen(appState: const AppState.home(), id: 0),
  ];

  TabScreen get currentScreen => screens.last;

  List<AppState> appStateList = const [
    AppState.home(),
    AppState.leave(),
    AppState.settings()
  ];

  List<Page> buildPages() {
    List<Page> pageList = screens
        .map((e) => e.appState.when(
              home: () {
                return MaterialPage(child: EmployeeListScreen(onTap: onTap));
              },
              employeeDetail: (selectedEmployee) {
                return MaterialPage(
                    child: EmployeeDetailScreen(
                  id: selectedEmployee,
                ));
              },
              leave: () {
                return const MaterialPage(child: LeaveScreen());
              },
              userAllLeave: () =>
                  const MaterialPage(child: AllLeavesUserScreen()),
              userUpcomingLeave: () =>
                  const MaterialPage(child: UpComingLeavesUserScreen()),
              leaveRequest: () => const MaterialPage(child: LeaveRequestForm()),
              settings: () => const MaterialPage(child: SettingScreen()),
            ))
        .toList(growable: true);

    notifyListeners();
    return pageList;
  }

  void onBottomTabClick(index) {
    _selectedBottomIndex = index;
    if (_selectedBottomIndex != currentScreen.id) {
      screens.add(TabScreen(
          appState: appStateList[_selectedBottomIndex],
          id: _selectedBottomIndex));
    }
    notifyListeners();
  }

  TabScreen? pop() {
    final poppedPage = screens.removeLast();
    int id = currentScreen.id;
    if (id != _selectedBottomIndex) {
      onBottomTabClick(0);
      return poppedPage;
    }
    onBottomTabClick(_selectedBottomIndex);
    notifyListeners();
    return null;
  }

  void onTap(int selectedEmployeeID) {
    if (currentScreen.appState == const AppState.home()) {
      screens.add(TabScreen(
          appState: AppState.employeeDetail(id: selectedEmployeeID),
          id: _selectedBottomIndex));
      notifyListeners();
    }
  }
}

class TabScreen {
  AppState appState;
  int id;

  TabScreen({required this.appState, required this.id});
}
