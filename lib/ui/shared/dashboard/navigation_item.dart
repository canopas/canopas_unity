import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';

import '../../../gen/assets.gen.dart';
import '../../../app_router.dart';

class BottomNavigationItem {
  final String initialLocation;
  final String tabIcon;
  final String tabActiveIcon;
  final String label;

  BottomNavigationItem(
      {required this.tabIcon,
      required this.initialLocation,
      required this.tabActiveIcon,
      required this.label});

  BottomNavigationBarItem toBottomNavigationItem(BuildContext context) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(tabIcon,
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(
              context.colorScheme.textPrimary, BlendMode.srcIn)),
      label: label,
      activeIcon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          decoration: BoxDecoration(
              color: context.colorScheme.primary,
              borderRadius: BorderRadius.circular(20)),
          child: SvgPicture.asset(
            tabActiveIcon,
            width: 20,
            height: 20,
            colorFilter:
                ColorFilter.mode(context.colorScheme.surface, BlendMode.srcIn),
          )),
    );
  }
}

List<BottomNavigationItem> userTabs = [
  BottomNavigationItem(
    tabIcon: Assets.images.icHome,
    tabActiveIcon: Assets.images.icHome,
    label: "Home",
    initialLocation: Routes.userHome,
  ),
  BottomNavigationItem(
    tabIcon: Assets.images.icCalendar,
    tabActiveIcon: Assets.images.icCalendar,
    label: "Leaves",
    initialLocation: Routes.userLeaves,
  ),
  BottomNavigationItem(
    tabIcon: Assets.images.icUsers,
    tabActiveIcon: Assets.images.icUsers,
    label: "Members",
    initialLocation: Routes.userMembers,
  ),
];

List<BottomNavigationItem> adminTabs = [
  BottomNavigationItem(
    tabIcon: Assets.images.icHome,
    tabActiveIcon: Assets.images.icHome,
    label: "Home",
    initialLocation: Routes.adminHome,
  ),
  BottomNavigationItem(
    tabIcon: Assets.images.icCalendar,
    tabActiveIcon: Assets.images.icCalendar,
    label: "Leaves",
    initialLocation: Routes.adminLeaves,
  ),
  BottomNavigationItem(
    tabIcon: Assets.images.icUsers,
    tabActiveIcon: Assets.images.icUsers,
    label: "Members",
    initialLocation: Routes.adminMembers,
  ),
];
