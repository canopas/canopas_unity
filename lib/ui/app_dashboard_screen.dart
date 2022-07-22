import 'package:flutter/material.dart';
import 'package:projectunity/navigation/main_router_delegate.dart';
import 'package:projectunity/navigation/router_info_parser.dart';

import '../di/service_locator.dart';
import '../navigation/navigationStackItem/admin/admin_navigation_stack_items.dart';
import '../navigation/navigationStackItem/employee/employee_navigation_stack_item.dart';
import '../navigation/navigation_stack_manager.dart';
import '../utils/const/color_constant.dart';

class AppDashboardScreen extends StatefulWidget {
  const AppDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AppDashboardScreen> createState() => _AppDashboardScreenState();
}

class _AppDashboardScreenState extends State<AppDashboardScreen> {
  int selectedTab = 0;
  final _stateManager = getIt<NavigationStackManager>();
  bool show = false;

  @override
  void initState() {
    _stateManager.addListener(() {
      setState(() {
        show = _stateManager.showBottomBar;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: show
          ? BottomNavigationBar(
              backgroundColor: bottomBarColor,
              selectedItemColor: selectedBottomTab,
              unselectedItemColor: defaultBottomTab,
              selectedFontSize: 18,
              unselectedFontSize: 15,
              currentIndex: selectedTab,
              onTap: _ontap,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_rounded,
                    size: 34,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.people,
                    size: 34,
                  ),
                  label: 'Staff',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 34,
                  ),
                  label: 'Settings',
                ),
              ],
            )
          : null,
      body: Builder(
        builder: (context) => MaterialApp.router(
          routerDelegate: MainRouterDelegate(stack: _stateManager),
          routeInformationParser: HomeRouterInfoParser(),
        ),
      ),
    );
  }

  void _ontap(int id) {
    if (selectedTab == id) {
      return;
    }
    setState(() {
      selectedTab = id;
    });
    _stateManager.isAdmin
        ? getBottomNavigation(id, adminBottomBar)
        : getBottomNavigation(id, employeeBottomBar);
  }

  void getBottomNavigation(int index, Map map) {
    for (var key in map.keys) {
      if (key == index) {
        _stateManager.clearAndPush(map[index]);
      }
    }
  }

  Map employeeBottomBar = {
    0: const EmployeeNavigationStackItem.employeeHomeState(),
    1: const EmployeeNavigationStackItem.staffState(),
    2: const EmployeeNavigationStackItem.settingsState(),
  };
  Map adminBottomBar = {
    0: const AdminNavigationStackItem.adminHomeState(),
    1: const AdminNavigationStackItem.staffState(),
    2: const AdminNavigationStackItem.settingsState(),
  };
}
