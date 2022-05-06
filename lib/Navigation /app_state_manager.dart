import 'package:flutter/cupertino.dart';
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
  int selectedEmployee = 1;
  int selectedTab = 0;

  List<TabScreen> screens = [
    TabScreen(appState: const AppState.Home(), id: 0),
  ];

  TabScreen get currentScreen {
    print(screens.last.appState.toString());
    return screens.last;
  }

  List<Page> buildPages() {
    List<Page> pageList = screens
        .map((e) => e.appState.when(
              Home: () {
                return MaterialPage(child: EmployeeListScreen(ontap: onTap));
              },
              EmployeeDetail: (selectedEmployee) {
                return MaterialPage(
                    child: EmployeeDetailScreen(
                  id: selectedEmployee,
                ));
              },
              Leave: () {
                return const MaterialPage(child: LeaveScreen());
              },
              UserAllLeave: () =>
                  const MaterialPage(child: AllLeavesUserScreen()),
              UserUpcomingLeave: () =>
                  const MaterialPage(child: UpComingLeavesUserScreen()),
              LeaveRequest: () => const MaterialPage(child: LeaveRequestForm()),
              Settings: () => const MaterialPage(child: SettingScreen()),
            ))
        .toList(growable: true);

    notifyListeners();
    return pageList;
  }

  void onTabClick(index) {
    selectedTab = index;
    print('SelectedTab in onclick: ' + selectedTab.toString());
    switch (selectedTab) {
      case 0:
        screens
            .add(TabScreen(appState: const AppState.Home(), id: selectedTab));
        break;
      case 1:
        screens
            .add(TabScreen(appState: const AppState.Leave(), id: selectedTab));
        break;
      case 2:
        screens.add(
            TabScreen(appState: const AppState.Settings(), id: selectedTab));
        break;
    }
    print('length of pages after tabclick: ' + screens.length.toString());
    notifyListeners();
  }

  void onTap() {
    if (currentScreen.appState == AppState.Home()) {
      screens.add(TabScreen(
          appState: AppState.EmployeeDetail(id: selectedEmployee),
          id: selectedTab));
      print('added!');
      notifyListeners();
    }
  }

  TabScreen? pop() {
    if (screens.last.id == selectedTab) {
      final poppedPage = screens.removeLast();
      int id = screens.last.id;
      print('ID: ' + id.toString());
      if (id != selectedTab) {
        onTabClick(id);
      }
      return poppedPage;
    } else {
      onTabClick(selectedTab);
    }
    notifyListeners();
  }
}

class TabScreen {
  AppState appState;
  int id;

  TabScreen({required this.appState, required this.id});
}
