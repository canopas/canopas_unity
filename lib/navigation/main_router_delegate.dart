import 'package:flutter/material.dart';

import '../ui/setting/setting_screen.dart';
import '../ui/user/employee/detail/employee_detail_screen.dart';
import '../ui/user/employee/employeeList/employee_list_screen.dart';
import '../ui/user/leave/detail/all_leaves.dart';
import '../ui/user/leave/detail/team_leaves.dart';
import '../ui/user/leave/detail/upcoming_leaves.dart';
import '../ui/user/leave/leave_screen.dart';
import '../ui/user/leave/request/leave_request_form.dart';
import 'navigation_stack_manager.dart';

class MainRouterDelegate extends RouterDelegate<NavigationStackManager>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final NavigationStackManager stack;

  MainRouterDelegate({required this.stack}) : super() {
    stack.addListener(notifyListeners);
  }

  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void dispose() {
    stack.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: _buildPages(),
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        stack.pop();
        return true;
      },
    );
  }

  List<Page> _buildPages() => stack.screens
      .map((state) => state.when(
            homeState: () => const MaterialPage(
                key: ValueKey("home"), child: EmployeeListScreen()),
            employeeDetailState: (String selectedEmployee) {
              return MaterialPage(
                  key: const ValueKey("employee"),
                  child: EmployeeDetailScreen(
                    id: selectedEmployee,
                  ));
            },
            leaveState: () => const MaterialPage(
                key: ValueKey("leave"), child: LeaveScreen()),
            userAllLeaveState: () => const MaterialPage(
                key: ValueKey("user-all-leave"), child: AllLeavesUserScreen()),
            userUpcomingLeaveState: () => const MaterialPage(
                key: ValueKey("user-upcoming-leave"),
                child: UpComingLeavesUserScreen()),
            leaveRequestState: () => const MaterialPage(
                key: ValueKey("leave-request"), child: LeaveRequestForm()),
            settingsState: () => const MaterialPage(
                key: ValueKey("settings"), child: SettingScreen()),
            teamLeavesState: () => const MaterialPage(
                key: ValueKey("team-leave"), child: TeamLeavesScreen()),
          ))
      .toList();

  @override
  Future<void> setNewRoutePath(NavigationStackManager configuration) async {
    stack.screens = configuration.screens;
  }

  @override
  NavigationStackManager get currentConfiguration => stack;
}
