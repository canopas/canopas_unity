import 'package:flutter/material.dart';

import '../../../router/app_router.dart';

class BottomNavigationItem extends BottomNavigationBarItem {
  final String initialLocation;
  final String label;

  BottomNavigationItem(
      {required Widget icon,
      required this.initialLocation,
      required this.label})
      : super(icon: icon);
}

List<BottomNavigationItem> tabs = [
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
