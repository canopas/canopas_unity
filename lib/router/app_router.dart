import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/ui/admin/dashboard/admin_dashboard.dart';
import 'package:projectunity/ui/admin/edit_employe_details/admin_edit_employee_details_view.dart';
import 'package:projectunity/ui/admin/home/application_detail/admin_leave_application_detail.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/admin_leaves_screen.dart';
import 'package:projectunity/ui/user/leaves/detail/user_leave_detail_screen.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/user_leave_screen.dart';

import '../model/leave_application.dart';
import '../provider/user_data.dart';
import '../ui/admin/employee/detail/employee_detail_screen.dart';
import '../ui/admin/employee/list/employee_list_screen.dart';
import '../ui/admin/home/addmember/admin_add_member_screen.dart';
import '../ui/admin/home/home_screen/admin_home_screen.dart';
import '../ui/admin/leaves/detail/leave_details.dart';
import '../ui/admin/setting/admin_setting_screen.dart';
import '../ui/admin/setting/update_leave_count/update_leave_counts_screen.dart';
import '../ui/login/login_screen.dart';
import '../ui/shared/employees_calendar/employees_calendar_screen.dart';
import '../ui/user/dashboard/user_dashboard.dart';
import '../ui/user/employees/user_employees_screen.dart';
import '../ui/user/home/home_screen/user_home_screen.dart';
import '../ui/user/home/leave_calendar/user_leave_calendar_screen.dart';
import '../ui/user/leaves/apply_leave/apply_leave_screen.dart';
import '../ui/user/settings/edit_profile/edit_employee_details_employee_view.dart';
import '../ui/user/settings/settings_screen/user_settings_screen.dart';

@Injectable()
class AppRouter {
  final UserManager _userManager;

  AppRouter(this._userManager);

  GoRouter get router => _goRouter(_userManager);
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _adminShellNavigatorKey = GlobalKey<NavigatorState>();
  final _employeeShellNavigatorKey = GlobalKey<NavigatorState>();

  GoRouter _goRouter(UserManager userManager) {
    return GoRouter(
        refreshListenable: userManager,
        debugLogDiagnostics: true,
        initialLocation:
            userManager.isAdmin ? Routes.adminHome : Routes.userHome,
        navigatorKey: _rootNavigatorKey,
        routes: [
          GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: '/login',
              name: Routes.login,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: LoginPage())),
          ShellRoute(
              navigatorKey: _adminShellNavigatorKey,
              builder: (context, state, child) {
                return AdminDashBoardScreen(child: child);
              },
              routes: [
                GoRoute(
                    parentNavigatorKey: _adminShellNavigatorKey,
                    name: Routes.adminHome,
                    path: '/admin-home',
                    pageBuilder: (context, state) {
                      return const MaterialPage(child: AdminHomeScreenPage());
                    },
                    routes: <GoRoute>[
                      GoRoute(
                          path: 'new',
                          name: Routes.addMember,
                          parentNavigatorKey: _adminShellNavigatorKey,
                          pageBuilder: (context, state) =>
                              const MaterialPage(child: AdminAddMemberPage())),
                      GoRoute(
                          parentNavigatorKey: _adminShellNavigatorKey,
                          name: Routes.leaveApplicationDetail,
                          path: 'leave-application',
                          pageBuilder: (context, state) {
                            LeaveApplication leaveApplication =
                                state.extra as LeaveApplication;
                            return MaterialPage(
                                child: AdminLeaveApplicationDetailsPage(
                                    leaveApplication: leaveApplication));
                          }),
                      GoRoute(
                        parentNavigatorKey: _adminShellNavigatorKey,
                        name: Routes.adminCalender,
                        path: 'calender',
                        pageBuilder: (context, state) => const MaterialPage(
                          child: EmployeesLeaveCalenderPage(),
                        ),
                      )
                    ]),
                GoRoute(
                    parentNavigatorKey: _adminShellNavigatorKey,
                    name: Routes.adminLeaves,
                    path: '/admin-leaves',
                    pageBuilder: (context, state) {
                      return const MaterialPage(child: AdminLeavesPage());
                    },
                    routes: <GoRoute>[
                      GoRoute(
                          parentNavigatorKey: _adminShellNavigatorKey,
                          name: Routes.adminLeaveDetails,
                          path: 'details',
                          pageBuilder: (context, state) {
                            LeaveApplication leaveApplication =
                                state.extra as LeaveApplication;
                            return MaterialPage(
                                child: AdminLeaveDetailsPage(
                                    leaveApplication: leaveApplication));
                          }),
                    ]),
                GoRoute(
                    parentNavigatorKey: _adminShellNavigatorKey,
                    name: Routes.adminEmployees,
                    path: '/admin-employees',
                    pageBuilder: (context, state) =>
                        const MaterialPage(child: EmployeeListPage()),
                    routes: <GoRoute>[
                      GoRoute(
                          parentNavigatorKey: _adminShellNavigatorKey,
                          name: Routes.adminEmployeeDetail,
                          path: ':employeeId',
                          pageBuilder: (context, state) => MaterialPage(
                              child: EmployeeDetailPage(
                                  id: state
                                      .params[RoutesParamsConst.employeeId]!)),
                          routes: [
                            GoRoute(
                                parentNavigatorKey: _adminShellNavigatorKey,
                                name: Routes.userCalenderForAdmin,
                                path: 'time-off',
                                pageBuilder: (context, state) => MaterialPage(
                                    child: UserLeaveCalendarPage(
                                        userId: state.params[
                                            RoutesParamsConst.employeeId]!))),
                            GoRoute(
                              parentNavigatorKey: _adminShellNavigatorKey,
                              path: 'edit-employee',
                              name: Routes.adminEditEmployee,
                              pageBuilder: (context, state) => MaterialPage(
                                  child: AdminEditEmployeeDetailsPage(
                                employee: state.extra as Employee,
                              )),
                            ),
                          ]),
                    ]),
                GoRoute(
                    parentNavigatorKey: _adminShellNavigatorKey,
                    name: Routes.adminSettings,
                    path: '/admin-settings',
                    pageBuilder: (context, state) =>
                        const MaterialPage(child: AdminSettingPage()),
                    routes: <GoRoute>[
                      GoRoute(
                          parentNavigatorKey: _adminShellNavigatorKey,
                          name: Routes.updateLeaveCount,
                          path: 'paid-leave',
                          pageBuilder: (context, state) => const MaterialPage(
                              child: AdminUpdateLeaveCountsPage())),
                    ]),
              ]),
          ShellRoute(
              navigatorKey: _employeeShellNavigatorKey,
              builder: (context, state, child) {
                return UserDashBoardScreen(child: child);
              },
              routes: <GoRoute>[
                GoRoute(
                    parentNavigatorKey: _employeeShellNavigatorKey,
                    path: '/user-home',
                    name: Routes.userHome,
                    pageBuilder: (context, state) =>
                        const MaterialPage(child: UserHomeScreenPage()),
                    routes: <GoRoute>[
                      GoRoute(
                          parentNavigatorKey: _employeeShellNavigatorKey,
                          path: Routes.userCalender,
                          name: Routes.userCalender,
                          pageBuilder: (context, state) => const MaterialPage(
                              child: EmployeesLeaveCalenderPage())),
                      GoRoute(
                          parentNavigatorKey: _employeeShellNavigatorKey,
                          name: Routes.userLeaveCalender,
                          path: 'user-calender',
                          pageBuilder: (context, state) => MaterialPage(
                              child: UserLeaveCalendarPage(
                                  userId: userManager.employeeId))),
                    ]),
                GoRoute(
                    parentNavigatorKey: _employeeShellNavigatorKey,
                    path: '/leaves',
                    name: Routes.userLeaves,
                    pageBuilder: (context, state) =>
                        const MaterialPage(child: UserLeavePage()),
                    routes: <GoRoute>[
                      GoRoute(
                        name: Routes.applyLeave,
                        path: 'apply-leave',
                        pageBuilder: (context, state) => const MaterialPage(
                          child: ApplyLeavePage(),
                        ),
                      ),
                      GoRoute(
                          name: Routes.userLeaveDetail,
                          path: ':leaveId',
                          pageBuilder: (context, state) {
                            return MaterialPage(
                                child: UserLeaveDetailPage(
                                    leaveId: state
                                        .params[RoutesParamsConst.leaveId]!));
                          }),
                    ]),
                GoRoute(
                    parentNavigatorKey: _employeeShellNavigatorKey,
                    path: '/employees',
                    name: Routes.userEmployees,
                    pageBuilder: (context, state) =>
                        const MaterialPage(child: UserEmployeesPage()),
                    routes: <GoRoute>[
                      GoRoute(
                        parentNavigatorKey: _employeeShellNavigatorKey,
                        name: Routes.userEmployeeDetail,
                        path: ':employeeId',
                        pageBuilder: (context, state) => MaterialPage(
                            child: EmployeeDetailPage(
                                id: state
                                    .params[RoutesParamsConst.employeeId]!)),
                      ),
                    ]),
                GoRoute(
                    parentNavigatorKey: _employeeShellNavigatorKey,
                    path: '/settings',
                    name: Routes.userSettings,
                    pageBuilder: (context, state) =>
                        const MaterialPage(child: UserSettingsPage()),
                    routes: <GoRoute>[
                      GoRoute(
                        path: Routes.userEditProfile,
                        name: Routes.userEditProfile,
                        pageBuilder: (context, state) => MaterialPage(
                            child: EmployeeEditEmployeeDetailsPage(
                          employee: state.extra as Employee,
                        )),
                      ),
                    ]),
              ])
        ],
        redirect: (context, state) {
          final loggingIn = state.subloc == Routes.login;
          if (!userManager.loggedIn) {
            return loggingIn ? null : Routes.login;
          }
          if (userManager.loggedIn && loggingIn && userManager.isAdmin) {
            return Routes.adminHome;
          }
          if (userManager.loggedIn && loggingIn && !userManager.isAdmin) {
            return Routes.userHome;
          }
          return null;
        });
  }
}

abstract class RoutesParamsConst {
  static const employeeId = "employeeId";
  static const leaveId = 'leaveId';
}

abstract class Routes {
  static const adminHome = '/admin-home';
  static const adminLeaves = '/admin-leaves';
  static const adminEmployees = '/admin-employees';
  static const adminSettings = '/admin-settings';
  static const addMember = '/new';
  static const adminCalender = '/calender';
  static const adminLeaveDetails = 'details';
  static const adminEditEmployee = 'edit-employee';
  static const adminEmployeeDetail = '/admin-employee-details/:employeeId';
  static const leaveApplicationDetail = '/leave-application/:id';

  static const userHome = '/user-home';
  static const userLeaves = '/leaves';
  static const userEmployees = '/employees';
  static const userSettings = '/settings';
  static const userLeaveDetail = '/leave-detail';
  static const userEmployeeDetail = '/user-employee-details/:employeeId';
  static const userEditProfile = 'user-edit-profile';
  static const applyLeave = '/apply-leave';
  static const userCalender = 'calender';

  static const login = '/login';

  static const updateLeaveCount = '/paid-leave';

  static const userLeaveCalender = '/user-calender';
  static const userCalenderForAdmin = 'time-off';
}
