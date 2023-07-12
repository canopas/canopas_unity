import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/bloc/user_state/user_state_controller_bloc.dart';
import 'package:projectunity/ui/admin/dashboard/navigation_item.dart';
import 'package:projectunity/ui/shared/appbar_drawer/drawer/app_drawer.dart';
import '../../../data/di/service_locator.dart';
import '../../shared/appbar_drawer/drawer/bloc/app_drawer_bloc.dart';

class UserDashBoardScreen extends StatefulWidget {
  final Widget child;

  const UserDashBoardScreen({Key? key, required this.child}) : super(key: key);

  @override
  State<UserDashBoardScreen> createState() => _UserDashBoardScreenState();
}

class _UserDashBoardScreenState extends State<UserDashBoardScreen> {
  int get _currentIndex => locationToTabIndex(GoRouter.of(context).location);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (_) => getIt.get<DrawerBloc>(),),
        BlocProvider(create: (_)=>getIt<UserStateControllerBloc>())
      ],
      child: Scaffold(
        drawer: const AppDrawer(),
        body: SafeArea(child: widget.child),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) => onItemTapped(index),
          items: userTabs,
          currentIndex: _currentIndex,
        ),
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
