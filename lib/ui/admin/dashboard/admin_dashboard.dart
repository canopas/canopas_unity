import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/ui/shared/appbar_drawer/drawer/app_drawer.dart';
import 'package:projectunity/ui/shared/appbar_drawer/drawer/bloc/app_drawer_bloc.dart';
import '../../../data/bloc/user_state/user_state_controller_bloc.dart';
import '../../../data/bloc/user_state/user_state_controller_event.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt.get<DrawerBloc>()),
        BlocProvider(
            create: (_) =>
            getIt<UserStateControllerBloc>()..add(CheckUserStatus())),
      ],
      child: Scaffold(
        drawer: const AppDrawer(),
        body: SafeArea(child: widget.child),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) => onItemTapped(index),
          items: adminTabs,
          currentIndex: _currentIndex,
        ),
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
