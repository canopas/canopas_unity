import 'package:flutter/material.dart';
import 'package:projectunity/navigation/main_router_delegate.dart';
import 'package:projectunity/navigation/router_info_parser.dart';

import '../../configs/colors.dart';
import '../../di/service_locator.dart';
import '../../navigation/navigation_stack_item.dart';
import '../../navigation/navigation_stack_manager.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int selectedTab = 0;
  final _stateManager = getIt<NavigationStackManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.bottomBarColor,
        selectedItemColor: AppColors.selectedBottomTab,
        unselectedItemColor: AppColors.defaultBottomTab,
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
      ),
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

    switch (id) {
      case 0:
        _stateManager.clearAndPush(const NavigationStackItem.adminHomeState());
        break;
      case 1:
        _stateManager.clearAndPush(const NavigationStackItem.leaveState());
        break;
      case 2:
        _stateManager.clearAndPush(const NavigationStackItem.settingsState());
    }
  }
}
