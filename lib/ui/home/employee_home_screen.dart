import 'package:flutter/material.dart';
import 'package:projectunity/navigation/main_router_delegate.dart';
import 'package:projectunity/utils/const/color_constant.dart';

import '../../di/service_locator.dart';
import '../../navigation/navigation_stack_item.dart';
import '../../navigation/navigation_stack_manager.dart';
import '../../navigation/router_info_parser.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({Key? key}) : super(key: key);

  @override
  _EmployeeHomeScreenState createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  final _stateManager = getIt<NavigationStackManager>();
  int selectedTab = 0;
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
    return SafeArea(
      top: false,
      child: Scaffold(
          bottomNavigationBar: show
              ? BottomNavigationBar(
                  backgroundColor: const Color(kSecondaryColor),
                  selectedItemColor: const Color(selectedTabColor),
                  unselectedItemColor: const Color(kPrimaryColour),
                  selectedFontSize: 15,
                  currentIndex: selectedTab,
                  onTap: _ontap,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_rounded),
                      label: 'Home',
                    ),
              BottomNavigationBarItem(
                icon: Icon(Icons.date_range_rounded),
                      label: 'Leave',
                    ),
              BottomNavigationBarItem(
                icon: Icon(Icons.manage_accounts_rounded),
                label: 'Settings',
              ),
            ],
          ) : null,
          body: Builder(
            builder: (context) =>
                MaterialApp.router(
                  routerDelegate: MainRouterDelegate(stack: _stateManager),
                  routeInformationParser: HomeRouterInfoParser(),
                ),
          )),
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
        _stateManager.clearAndPush(const NavigationStackItem.homeState());
        break;
      case 1:
        _stateManager.clearAndPush(const NavigationStackItem.leaveState());
        break;
      case 2:
        _stateManager.clearAndPush(const NavigationStackItem.settingsState());
    }
  }
}
