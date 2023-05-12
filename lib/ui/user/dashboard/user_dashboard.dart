import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/event_bus/events.dart';
import 'package:projectunity/ui/admin/dashboard/navigation_item.dart';
import 'package:projectunity/ui/shared/drawer/app_drawer.dart';

class UserDashBoardScreen extends StatefulWidget {
  final Widget child;

  const UserDashBoardScreen({Key? key, required this.child}) : super(key: key);

  @override
  State<UserDashBoardScreen> createState() => _UserDashBoardScreenState();
}

class _UserDashBoardScreenState extends State<UserDashBoardScreen> {
  int get _currentIndex => locationToTabIndex(GoRouter.of(context).location);

  final GlobalKey<ScaffoldState> _dashboardScaffoldKey = GlobalKey();
  late StreamSubscription _drawerEventsListener;

  @override
  void initState() {
    _drawerEventsListener = eventBus.on<OpenDrawerEvent>().listen((event) {
      _dashboardScaffoldKey.currentState!.openDrawer();
    });
    super.initState();
  }

  @override
  void dispose() {
    _drawerEventsListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      key: _dashboardScaffoldKey,
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) => onItemTapped(index),
        items: userTabs,
        currentIndex: _currentIndex,
      ),
    );
  }

  void onItemTapped(int index) {
    context.goNamed(userTabs[index].initialLocation);
  }

  int locationToTabIndex(String location) {
    final index = userTabs.indexWhere((bottomNavigationItem) =>
        location.startsWith(bottomNavigationItem.initialLocation));
    return index < 0 ? 0 : index;
  }
}
