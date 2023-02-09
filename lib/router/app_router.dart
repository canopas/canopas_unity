import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/ui/admin/addmember/admin_add_member_screen.dart';
import 'package:projectunity/ui/admin/dashboard/admin_dashboard.dart';
import 'package:projectunity/ui/admin/edit_employe_details/admin_edit_employee_details_view.dart';
import 'package:projectunity/ui/admin/leave_request_details/admin_leave_request_details_view.dart';
import 'package:projectunity/ui/admin/leaves/admin_leaves_screen.dart';
import 'package:projectunity/ui/user/leaves/user_leave_screen.dart';
import 'package:projectunity/ui/user/user_employees/user_employees_screen.dart';
import 'package:projectunity/ui/user/user_home/user_home_screen.dart';
import 'package:projectunity/ui/user/user_settings/user_settings_screen.dart';

import '../model/leave/leave.dart';
import '../model/leave_application.dart';
import '../provider/user_data.dart';
import '../ui/admin/employee/detail/employee_detail_screen.dart';
import '../ui/admin/employee/list/employee_list_screen.dart';
import '../ui/admin/home/admin_home_screen.dart';
import '../ui/admin/setting/admin_setting_screen.dart';
import '../ui/admin/setting/update_leave_count/update_leave_counts_screen.dart';
import '../ui/login/login_screen.dart';
import '../ui/shared/employees_calendar/employees_calendar_screen.dart';
import '../ui/shared/leave_details/leave_details.dart';
import '../ui/user/applyLeave/apply_leave_screen.dart';
import '../ui/user/dashboard/user_dashboard.dart';
import '../ui/user/edit_employee_details/edit_employee_details_employee_view.dart';
import '../ui/user/user_leave_calendar/user_leave_calendar_screen.dart';

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
          // GoRoute(
          //   parentNavigatorKey: _rootNavigatorKey,
          //   path: '/',
          //   name: Routes.rootRoute,
          //   redirect: (context, state) {
          //     print('============= ${state.location}');
          //     return null;
          //   },
          // ),
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
                                child: AdminLeaveRequestDetailsPage(
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
                                child: LeaveDetailsPage(
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
                          path: 'leave-detail',
                          pageBuilder: (context, state) {
                            Leave leave = state.extra as Leave;
                            return const MaterialPage(
                                child: Center(
                              child: Text(
                                  'Implement screen to show leave details of user'),
                            ));
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

          // GoRoute(
          //     name: Routes.employeeHome,
          //     path: '/employee',
          //     pageBuilder: (context, state) =>
          //         const MaterialPage(child: AdminEmployeesPage()),
          //     routes: <GoRoute>[
          //       GoRoute(
          //           name: Routes.allLeaves,
          //           path: 'all',
          //           pageBuilder: (context, state) =>
          //               const MaterialPage(child: AllLeavesPage())),
          //       GoRoute(
          //           name: Routes.requested,
          //           path: 'requested',
          //           pageBuilder: (context, state) =>
          //               const MaterialPage(child: RequestedLeavesPage())),
          //       GoRoute(
          //           name: Routes.upcoming,
          //           path: 'upcoming',
          //           pageBuilder: (context, state) =>
          //               const MaterialPage(child: UpcomingLeavesPage())),
          //       GoRoute(
          //         name: Routes.applyLeave,
          //         path: 'apply-leave',
          //         pageBuilder: (context, state) => const MaterialPage(
          //           child: ApplyLeavePage(),
          //         ),
          //       ),
          //       GoRoute(
          //           name: Routes.userSettings,
          //           path: 'setting',
          //           pageBuilder: (context, state) =>
          //               const MaterialPage(child: UserSettingsPage()),
          //           routes: [
          //             GoRoute(
          //               path: 'employee-edit-employee-details',
          //               name: Routes.employeeEditEmployeeDetails,
          //               pageBuilder: (context, state) => MaterialPage(
          //                   child: EmployeeEditEmployeeDetailsPage(
          //                 employee: state.extra as Employee,
          //               )),
          //             ),
          //           ]),
          //       GoRoute(
          //           name: Routes.allUserCalender,
          //           path: 'calender',
          //           pageBuilder: (context, state) => const MaterialPage(
          //                 child: EmployeesLeaveCalenderPage(),
          //               ),
          //           routes: <GoRoute>[
          //             GoRoute(
          //                 name: Routes.employeeLeaveDetail,
          //                 path: 'leave-detail',
          //                 pageBuilder: (context, state) {
          //                   LeaveApplication leaveApplication =
          //                       state.extra as LeaveApplication;
          //                   return MaterialPage(
          //                       child: LeaveDetailsPage(
          //                           leaveApplication: leaveApplication));
          //                 }),
          //           ]),
          //       GoRoute(
          //           name: Routes.userLeaveCalender,
          //           path: 'user-calender',
          //           pageBuilder: (context, state) => MaterialPage(
          //               child: UserLeaveCalendarPage(
          //                   userId: userManager.employeeId)),
          //           routes: <GoRoute>[
          //             GoRoute(
          //                 name: Routes.userLeaveDetail,
          //                 path: 'details',
          //                 pageBuilder: (context, state) {
          //                   LeaveApplication leaveApplication =
          //                       state.extra as LeaveApplication;
          //                   return MaterialPage(
          //                       child: LeaveDetailsPage(
          //                           leaveApplication: leaveApplication));
          //                 }),
          //           ]),
          //     ]),
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
          print('state location: ${state.location}');
          return null;
        });
  }
}

abstract class RoutesParamsConst {
  static const employeeId = "employeeId";
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

  static const userHome = '/user-home';
  static const userLeaves = '/leaves';
  static const userEmployees = '/employees';
  static const userSettings = '/settings';
  static const userLeaveDetail = '/leave-detail';
  static const userEmployeeDetail = '/user-employee-details/:employeeId';
  static const userEditProfile = 'user-edit-profile';
  static const applyLeave = '/apply-leave';
  static const userCalender = 'calender';

  static const home = '/home';

  static const rootRoute = '/';
  static const login = '/login';

  static const employees = '/employees';

  //static const adminSettings = '/admin-settings';
  static const updateLeaveCount = '/paid-leave';

  static const leaveApplicationDetail = '/leave-application/:id';

  static const allLeaves = '/all';
  static const requested = '/requested';
  static const upcoming = '/upcoming';
  //static const userSettings = '/user-settings';

  //static const adminCalender = '/admin-calender';

  static const userLeaveCalender = '/user-calender';

  static const employeeLeaveDetail = '/employee-leave-detail';
  static const adminLeaveDetail = 'leave-application-details';
}
