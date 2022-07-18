import 'package:flutter/material.dart';
import 'package:projectunity/ui/admin/leave/requests/all_request_screen.dart';
import 'package:projectunity/ui/user/leave/requested_leave_screen.dart';
import 'package:projectunity/ui/user/leave/upcoming_leave_screen.dart';

import '../ui/admin/addmember/admin_add_member_screen.dart';
import '../ui/admin/home/admin_home_screen.dart';
import '../ui/admin/leave/detail/leave_detail_screen.dart';
import '../ui/home/employeeHome/employee_home_screen.dart';
import '../ui/setting/setting_screen.dart';
import '../ui/user/employee/detail/employee_detail_screen.dart';
import '../ui/user/leave/all/all_leaves_screen.dart';
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
      adminHomeState: () => const MaterialPage(
              key: ValueKey("admin"), child: AdminHomeScreen()),
      employeeHomeState: () => const MaterialPage(
              key: ValueKey("home"), child: EmployeeHomeScreen()),
          employeeDetailState: (String selectedEmployee) {
            return MaterialPage(
                key: const ValueKey("employee"),
                child: EmployeeDetailScreen(
                  id: selectedEmployee,
                ));
          },
          leaveState: () =>
              const MaterialPage(key: ValueKey("leave"), child: LeaveScreen()),
          userAllLeaveState: () => MaterialPage(
              key: const ValueKey("user-all-leave"), child: AllLeaveScreen()),
          userUpcomingLeaveState: () => const MaterialPage(
              key: ValueKey("user-upcoming-leave"),
              child: UpcomingLeaveScreen()),
          leaveRequestState: () => const MaterialPage(
              key: ValueKey("leave-request"), child: LeaveRequestForm()),
          settingsState: () => const MaterialPage(
              key: ValueKey("settings"), child: SettingScreen()),
          requestedLeaves: () => const MaterialPage(
              key: ValueKey("team-leave"), child: RequestedLeaveScreen()),
          addMemberState: () => const MaterialPage(
              key: ValueKey("add-member"), child: AdminAddMemberScreen()),
          adminLeaveRequestState: () =>
              const MaterialPage(child: AdminLeaveRequestsScreen()),
          adminLeaveRequestDetailState: () =>
              const MaterialPage(child: AdminLeaveRequestDetailScreen())))
      .toList();

  @override
  Future<void> setNewRoutePath(NavigationStackManager configuration) async {
    stack.screens = configuration.screens;
  }

  @override
  NavigationStackManager get currentConfiguration => stack;
}
