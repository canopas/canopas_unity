import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../gen/assets.gen.dart';
import '../../../style/colors.dart';
import '../../navigation/app_router.dart';

class BottomNavigationItem  {
  final String initialLocation;
  final String tabIcon;
  final String tabActiveIcon;
  final String label;


  BottomNavigationItem(
      {required  this.tabIcon,
      required this.initialLocation,
      required this.tabActiveIcon,
      required this.label});


  BottomNavigationBarItem toBottomNavigationItem(BuildContext context) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
          tabIcon,
          width: 20,
          height: 20,
          colorFilter: const ColorFilter.mode(textDisabledColor, BlendMode.srcIn)
      ),
      label: label,
      activeIcon: Container(
          padding: const EdgeInsets.symmetric(horizontal:20,vertical: 4),
          decoration: BoxDecoration(
              color: primaryLightColor,
              borderRadius: BorderRadius.circular(20)
          ),
          child:SvgPicture.asset(tabActiveIcon,
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(surfaceColor, BlendMode.srcIn),
          )
      ),);
  }

}

List<BottomNavigationItem> userTabs= [
  BottomNavigationItem(
          tabIcon: Assets.images.icHomeFilled,
          tabActiveIcon: Assets.images.icHomeFilled,
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
      tabIcon: Assets.images.icHomeFilled,
      tabActiveIcon: Assets.images.icHomeFilled,
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

