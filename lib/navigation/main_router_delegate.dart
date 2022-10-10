import 'package:flutter/material.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/ui/admin/leave/absence/absence_screen.dart';
import 'package:projectunity/ui/login/login_screen.dart';
import 'package:projectunity/ui/onboard/onboard_screen.dart';
import 'package:projectunity/ui/user/home/user_home_screen.dart';
import 'package:projectunity/ui/user/leave/all/all_leaves_screen.dart';

import '../provider/user_data.dart';
import '../ui/admin/addmember/admin_add_member_screen.dart';
import '../ui/admin/employee_list_screen/employee_list_screen.dart';
import '../ui/admin/home/admin_home_screen.dart';
import '../ui/admin/home/employee/detail/employee_detail_screen.dart';
import '../ui/admin/leave/detail/leave_detail_screen.dart';
import '../ui/admin/setting/admin_setting_screen.dart';
import '../ui/admin/setting/update_leave_count/update_leave_counts_screen.dart';
import '../ui/user/leave/applyLeave/leave_request_form.dart';
import '../ui/user/leave/detail/leave_detail_screen.dart';
import '../ui/user/leave/requested/requested_leave_screen.dart';
import '../ui/user/leave/upcoming/upcoming_leave_screen.dart';
import '../ui/user/setting/employee_setting_screen.dart';
import 'navigation_stack_manager.dart';

class MainRouterDelegate extends RouterDelegate<NavigationStackManager>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final NavigationStackManager stack;
  final UserManager userManager;

  MainRouterDelegate({required this.stack, required this.userManager})
      : super() {
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
        key: navigatorKey, pages: _buildStack(), onPopPage: _onPopPage);
  }

  bool _onPopPage(Route route, dynamic result) {
    if (!route.didPop(result)) {
      return false;
    }
    stack.pop();
    return true;
  }

  List<Page> _buildStack() => stack.pages
      .map((state) => state.when(
          onBoard: () => const MaterialPage(
              key: ValueKey("onboard"), child: OnBoardScreen()),
          login: () =>
              const MaterialPage(key: ValueKey("login"), child: LoginScreen()),
          adminHome: () => const MaterialPage(
              key: ValueKey("admin-home"), child: AdminHomeScreen()),
          adminSettingsState: () => const MaterialPage(
              key: ValueKey("admin-setting"), child: AdminSettingScreen()),
          paidLeaveSettingsState: () => const MaterialPage(
              key: ValueKey("admin-paid-leave-count"),
              child: AdminUpdateLeaveCountsScreen()),
          addMemberState: () => const MaterialPage(
              key: ValueKey("add-member"), child: AdminAddMemberScreen()),
          adminEmployeeListState: () => const MaterialPage(
              key: ValueKey("employee-list-admin"),
              child: EmployeeListScreen()),
          employeeDetailState: (String selectedEmployee) => MaterialPage(
              key: const ValueKey('employee-detail'),
              child: EmployeeDetailScreen(
                id: selectedEmployee,
              )),
          adminLeaveAbsenceState: () => const MaterialPage(
              key: ValueKey("absence-employees"), child: AdminAbsenceScreen()),
          adminLeaveRequestDetailState: (LeaveApplication employeeLeave) =>
              MaterialPage(
                  key: const ValueKey('admin-requested-levae-detail'),
                  child: AdminLeaveRequestDetailScreen(
                    employeeLeave: employeeLeave,
                  )),
          employeeHome: () => const MaterialPage(
              key: ValueKey("employee-home"), child: EmployeeHomeScreen()),
          employeeSettingsState: () => const MaterialPage(
              key: ValueKey("employee-setting"),
              child: EmployeeSettingScreen()),
          userAllLeaveState: () => const MaterialPage(
              key: ValueKey("user-all-leave"), child: AllLeaveScreen()),
          userUpcomingLeaveState: () => const MaterialPage(
              key: ValueKey("user-upcoming"), child: UpComingLeaveScreen()),
          leaveRequestState: () => const MaterialPage(
              key: ValueKey("apply-leave"), child: LeaveRequestForm()),
          requestedLeaves: () => const MaterialPage(
              key: ValueKey("user-requested-leave"),
              child: RequestedLeaveScreen()),
          leaveDetailState: (leave) => MaterialPage(
              key: const ValueKey('user_leave-detail'),
              child: UserLeaveDetailScreen(leave: leave))))
      .toList();

  @override
  Future<void> setNewRoutePath(NavigationStackManager configuration) async {}

  @override
  NavigationStackManager get currentConfiguration => stack;
}
