import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/Navigation/navigation_stack_manager.dart';

import '../ui/User/Employee/employeeList/employee_list_screen.dart';
import '../ui/User/Employee/employee_detail_screen.dart';
import '../ui/User/Leave/LeaveDetail/LoggedInUser/all_leaves.dart';
import '../ui/User/Leave/LeaveDetail/LoggedInUser/upcoming_leaves.dart';
import '../ui/User/Leave/LeaveDetail/team_leaves.dart';
import '../ui/User/Leave/leave_request_form.dart';
import '../ui/User/Leave/leave_screen.dart';
import '../ui/User/setting_screen.dart';

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
            leaveState: () => MaterialPage(
                key: const ValueKey("leave"), child: LeaveScreen()),
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
