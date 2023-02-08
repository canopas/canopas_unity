import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/ui/user/dashboard/navigation_item.dart';

import '../../../configs/colors.dart';

class UserDashBoardScreen extends StatefulWidget {
  const UserDashBoardScreen({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<UserDashBoardScreen> createState() => _UserDashBoardScreenState();
}

class _UserDashBoardScreenState extends State<UserDashBoardScreen> {
  int get _currentIndex => locationToTabIndex(GoRouter.of(context).location);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.darkBlue,
        unselectedItemColor: AppColors.primaryBlue,
        onTap: (int index) => onItemTapped(index),
        items: tabs,
        currentIndex: _currentIndex,
      ),
    );
  }

  void onItemTapped(int index) {
    if (index != _currentIndex) {
      context.goNamed(tabs[index].initialLocation);
    }
  }

  int locationToTabIndex(String location) {
    final index = tabs.indexWhere((bottomNavigationItem) =>
        location.startsWith(bottomNavigationItem.initialLocation));
    print('Index: $index');
    return index < 0 ? 0 : index;
  }
}
