import 'package:flutter/material.dart';
import 'package:projectunity/model/leave_application.dart';
import 'package:projectunity/ui/login/login_screen.dart';
import 'package:projectunity/ui/onboard/onboard_screen.dart';
import 'package:projectunity/ui/shared/leave_detail/leave_details.dart';
import 'package:projectunity/ui/user/home/employee_home_screen.dart';
import 'package:projectunity/ui/user/leave/all/all_leaves_screen.dart';

import '../provider/user_data.dart';
import '../ui/admin/addmember/admin_add_member_screen.dart';
import '../ui/admin/employee/detail/employee_detail_screen.dart';
import '../ui/admin/employee/list/employee_list_screen.dart';
import '../ui/admin/home/admin_home_screen.dart';
import '../ui/admin/setting/admin_setting_screen.dart';
import '../ui/admin/setting/update_leave_count/update_leave_counts_screen.dart';
import '../ui/shared/user_leave_calendar/user_leave_calendar.dart';
import '../ui/shared/who_is_out_calendar/who_is_out_calendar_view.dart';
import '../ui/user/leave/applyLeave/leave_request_view.dart';
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
    leaveDetailState: (LeaveApplication leaveApplication) =>
        MaterialPage(
            key: const ValueKey('leave-details'),
            child: LeaveDetailsView(
              leaveApplication: leaveApplication,
            )),
    employeeHome: () =>
    const MaterialPage(
        key: ValueKey("employee-home"), child: EmployeeHomePage()),
    employeeSettingsState: () =>
    const MaterialPage(
        key: ValueKey("employee-setting"),
        child: EmployeeSettingScreen()),
    userAllLeaveState: () =>
    const MaterialPage(
        key: ValueKey("user-all-leave"), child: AllLeaveScreen()),
    userUpcomingLeaveState: () =>
    const MaterialPage(
        key: ValueKey("user-upcoming"), child: UpComingLeaveScreen()),
    leaveRequestState: () =>
    const MaterialPage(
        key: ValueKey("apply-leave"), child: RequestLeaveView()),
    requestedLeaves: () =>
    const MaterialPage(
              key: ValueKey("user-requested-leave"),
              child: RequestedLeaveScreen()),
          whoIsOutCalendarState: () => const MaterialPage(
              key: ValueKey('who-is-out-calendar'),
              child: WhoIsOutCalendarView()),
          userLeaveCalendarState: (String userId) => MaterialPage(
              key: const ValueKey('user-view-calendar'),
              child: UserLeaveCalendarView(userId: userId,)),
  ))
      .toList();

  @override
  Future<void> setNewRoutePath(NavigationStackManager configuration) async {}

  @override
  NavigationStackManager get currentConfiguration => stack;
}
