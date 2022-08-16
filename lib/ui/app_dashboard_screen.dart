import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projectunity/navigation/main_router_delegate.dart';
import 'package:projectunity/navigation/router_info_parser.dart';

import '../di/service_locator.dart';
import '../l10n/l10n.dart';
import '../navigation/navigationStackItem/admin/admin_navigation_stack_items.dart';
import '../navigation/navigationStackItem/employee/employee_navigation_stack_item.dart';
import '../navigation/navigation_stack_manager.dart';

class AppDashboardScreen extends StatefulWidget {
  const AppDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AppDashboardScreen> createState() => _AppDashboardScreenState();
}

class _AppDashboardScreenState extends State<AppDashboardScreen> {
  int selectedTab = 0;
  final _stateManager = getIt<NavigationStackManager>();

  @override
  void initState() {
    _stateManager.isAdmin
        ? getBottomNavigation(selectedTab, adminBottomBar)
        : getBottomNavigation(selectedTab, employeeBottomBar);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => MaterialApp.router(
          theme: ThemeData(fontFamily: 'IBMPlexSans'),
          routerDelegate: MainRouterDelegate(stack: _stateManager),
          routeInformationParser: HomeRouterInfoParser(),
          supportedLocales: L10n.all,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ),
    );
  }

  void _ontap(int id) {
    setState(() {
      selectedTab = id;
    });
    _stateManager.isAdmin
        ? getBottomNavigation(id, adminBottomBar)
        : getBottomNavigation(id, employeeBottomBar);
  }

  void getBottomNavigation(int index, Map map) {
    for (int key in map.keys) {
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
