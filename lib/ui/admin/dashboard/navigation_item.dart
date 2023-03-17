import 'package:flutter/material.dart';

import '../../navigation/app_router.dart';

class BottomNavigationItem extends BottomNavigationBarItem {
  final String initialLocation;

  BottomNavigationItem(
      {required Widget icon,
      required this.initialLocation,
      required String label})
      : super(icon: icon, label: label);
}

List<BottomNavigationItem> adminTabs = [
  BottomNavigationItem(
      label: 'Home',
      icon: const Icon(Icons.home_filled),
      initialLocation: Routes.adminHome),
  BottomNavigationItem(
      label: 'Leaves',
      icon: const Icon(Icons.calendar_month_sharp),
      initialLocation: Routes.adminLeaves),
  BottomNavigationItem(
      label: 'Employees',
      icon: const Icon(Icons.person),
      initialLocation: Routes.adminEmployees),
  BottomNavigationItem(
      label: 'Settings',
      icon: const Icon(Icons.settings),
      initialLocation: Routes.adminSettings)
];

List<BottomNavigationItem> userTabs = [
  BottomNavigationItem(
      label: 'Home',
      icon: const Icon(Icons.home_filled),
      initialLocation: Routes.userHome),
  BottomNavigationItem(
      label: 'Leaves',
      icon: const Icon(Icons.calendar_month_sharp),
      initialLocation: Routes.userLeaves),
  BottomNavigationItem(
      label: 'Employees',
      icon: const Icon(Icons.person),
      initialLocation: Routes.userEmployees),
  BottomNavigationItem(
      label: 'Settings',
      icon: const Icon(Icons.settings),
      initialLocation: Routes.userSettings)
];
