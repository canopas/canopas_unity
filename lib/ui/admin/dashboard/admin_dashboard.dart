import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'navigation_item.dart';

class AdminDashBoardScreen extends StatefulWidget {
  const AdminDashBoardScreen({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<AdminDashBoardScreen> createState() => _AdminDashBoardScreenState();
}

class _AdminDashBoardScreenState extends State<AdminDashBoardScreen> {
  int get _currentIndex => locationToTabIndex(GoRouter.of(context).location);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) => onItemTapped(index),
        items: adminTabs,
        currentIndex: _currentIndex,
      ),
    );
  }

  void onItemTapped(int index) {
    context.goNamed(adminTabs[index].initialLocation);
  }

  int locationToTabIndex(String location) {
    final index = adminTabs.indexWhere((bottomNavigationItem) =>
        location.startsWith(bottomNavigationItem.initialLocation));
    return index < 0 ? 0 : index;
  }
}
