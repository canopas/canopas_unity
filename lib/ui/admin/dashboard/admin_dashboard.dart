import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/event_bus/events.dart';
import '../../shared/drawer/app_drawer.dart';
import 'navigation_item.dart';

class AdminDashBoardScreen extends StatefulWidget {
  const AdminDashBoardScreen({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<AdminDashBoardScreen> createState() => _AdminDashBoardScreenState();
}

class _AdminDashBoardScreenState extends State<AdminDashBoardScreen> {
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
