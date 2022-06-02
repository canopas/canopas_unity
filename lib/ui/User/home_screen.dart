import 'package:flutter/material.dart';
import 'package:projectunity/Navigation/main_router_delegate.dart';
import 'package:projectunity/utils/Constant/color_constant.dart';

import '../../Navigation/navigation_stack_item.dart';
import '../../Navigation/navigation_stack_manager.dart';
import '../../Navigation/router_info_parser.dart';
import '../../di/service_locator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
