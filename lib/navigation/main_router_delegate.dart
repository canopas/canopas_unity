import 'package:flutter/material.dart';
import 'package:projectunity/model/employee_leave.dart';
import 'package:projectunity/ui/admin/leave/requests/all_request_screen.dart';
import 'package:projectunity/ui/user/home/employee_home_screen.dart';
import 'package:projectunity/ui/user/leave/all/all_leaves_screen.dart';
import 'package:projectunity/ui/user/leave/request/leave_request_form.dart';
import 'package:projectunity/ui/user/leave/requested_leave_screen.dart';
import 'package:projectunity/ui/user/leave/upcoming_leave_screen.dart';

import '../ui/admin/addmember/admin_add_member_screen.dart';
import '../ui/admin/home/admin_home_screen.dart';
import '../ui/admin/leave/detail/leave_detail_screen.dart';
import '../ui/setting/setting_screen.dart';
import '../ui/staff/staff_screen.dart';
import '../ui/user/employee/detail/employee_detail_screen.dart';
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
        pages: stack.screens == stack.adminStackList
            ? _buildAdminStack()
            : buildEmployeeStack(),
        onPopPage: _onPopPage);
  }


  bool _onPopPage(Route route, dynamic result) {
    if (!route.didPop(result)) {
      return false;
    }
    stack.pop();
    return true;
  }

  List<Page> buildEmployeeStack() => stack.employeeStackList
      .map((state) => state.when(
            employeeHomeState: () => const MaterialPage(
                key: ValueKey("employee-home"), child: EmployeeHomeScreen()),
            userAllLeaveState: () => MaterialPage(
                key: const ValueKey("user-all-leave"), child: AllLeaveScreen()),
            userUpcomingLeaveState: () => const MaterialPage(
                key: ValueKey("user-upcoming"), child: UpcomingLeaveScreen()),
            leaveRequestState: () => const MaterialPage(
                key: ValueKey("apply-leave"), child: LeaveRequestForm()),
            settingsState: () => const MaterialPage(
                key: ValueKey("setting"), child: SettingScreen()),
            requestedLeaves: () => const MaterialPage(
                key: ValueKey("user-requested-leave"),
                child: RequestedLeaveScreen()),
            staffState: () => const MaterialPage(
                key: ValueKey('staff'), child: StaffScreen()),
          ))
      .toList();

  List<Page> _buildAdminStack() => stack.adminStackList
      .map((state) => state.when(
    adminHomeState: () => const MaterialPage(
                key: ValueKey("admin-home"), child: AdminHomeScreen()),
            employeeDetailState: (String selectedEmployee) => MaterialPage(
                key: const ValueKey('employee-detail'),
                child: EmployeeDetailScreen(
                  id: selectedEmployee,
                )),
            settingsState: () => const MaterialPage(
                key: ValueKey("setting"), child: SettingScreen()),
            staffState: () => const MaterialPage(
                key: ValueKey('staff'), child: StaffScreen()),
            addMemberState: () => const MaterialPage(
                key: ValueKey("add-member"), child: AdminAddMemberScreen()),
            adminLeaveRequestState: () => const MaterialPage(
                key: ValueKey("requested-leaves"),
                child: AdminLeaveRequestsScreen()),
            adminLeaveRequestDetailState: (EmployeeLeave employeeLeave) =>
                MaterialPage(
                    key: const ValueKey('admin-requested-levae-detail'),
                    child: AdminLeaveRequestDetailScreen(
                      employeeLeave: employeeLeave,
                    )),
          ))
      .toList();

  @override
  Future<void> setNewRoutePath(NavigationStackManager configuration) async {
    stack.screens = configuration.screens;
  }

  @override
  NavigationStackManager get currentConfiguration => stack;
}
