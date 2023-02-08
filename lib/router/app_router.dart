import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/ui/admin/addmember/admin_add_member_screen.dart';
import 'package:projectunity/ui/admin/edit_employe_details/admin_edit_employee_details_view.dart';
import 'package:projectunity/ui/admin/leave_request_details/admin_leave_request_details_view.dart';
import 'package:projectunity/ui/admin/leaves/admin_leaves_screen.dart';
import 'package:projectunity/ui/user/dashboard/user_dashboard.dart';

import '../model/leave_application.dart';
import '../provider/user_data.dart';
import '../ui/admin/employee/detail/employee_detail_screen.dart';
import '../ui/admin/employee/list/employee_list_screen.dart';
import '../ui/admin/home/admin_home_screen.dart';
import '../ui/admin/setting/admin_setting_screen.dart';
import '../ui/admin/setting/update_leave_count/update_leave_counts_screen.dart';
import '../ui/shared/employees_calendar/employees_calendar_screen.dart';
import '../ui/shared/leave_details/leave_details.dart';

@Injectable()
class AppRouter {
  final UserManager _userManager;

  AppRouter(this._userManager);

  GoRouter get router => _goRouter(_userManager);
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  GoRouter _goRouter(UserManager userManager) {
    return GoRouter(
        refreshListenable: userManager,
        debugLogDiagnostics: true,
        initialLocation:
            userManager.isAdmin ? Routes.adminHome : Routes.employeeHome,
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
          // GoRoute(
          //     parentNavigatorKey: _rootNavigatorKey,
          //     path: '/login',
          //     name: Routes.login,
          //     pageBuilder: (context, state) =>
          //         const MaterialPage(child: LoginPage())),

          ShellRoute(
              navigatorKey: _shellNavigatorKey,
              builder: (context, state, child) {
                print(state.path);
                return UserDashBoardScreen(child: child);
              },
              routes: [
                GoRoute(
                    parentNavigatorKey: _shellNavigatorKey,
                    name: Routes.adminHome,
                    path: '/admin-home',
                    pageBuilder: (context, state) {
                      return const MaterialPage(child: AdminHomeScreenPage());
                    },
                    routes: <GoRoute>[
                      GoRoute(
                          path: 'new',
                          name: Routes.addMember,
                          parentNavigatorKey: _shellNavigatorKey,
                          pageBuilder: (context, state) =>
                              const MaterialPage(child: AdminAddMemberPage())),
                      GoRoute(
                          parentNavigatorKey: _shellNavigatorKey,
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
                        parentNavigatorKey: _shellNavigatorKey,
                        name: Routes.adminCalender,
                        path: 'calender',
                        pageBuilder: (context, state) => const MaterialPage(
                          child: EmployeesLeaveCalenderPage(),
                        ),
                      )
                    ]
                    // routes: <GoRoute>[
                    //   GoRoute(
                    //       parentNavigatorKey: _shellNavigatorKey,
                    //       name: Routes.adminLeaveDetail,
                    //       path: 'leave-application',
                    //       pageBuilder: (context, state) {
                    //         LeaveApplication leaveApplication =
                    //             state.extra as LeaveApplication;
                    //         return MaterialPage(
                    //             child: AdminLeaveRequestDetailsPage(
                    //                 leaveApplication: leaveApplication));
                    //       }),
                    //
                    //       routes: <GoRoute>[
                    //         GoRoute(
                    //             parentNavigatorKey: _shellNavigatorKey,
                    //             name: Routes.leaveApplicationDetail,
                    //             path: 'leave-application',
                    //             pageBuilder: (context, state) {
                    //               LeaveApplication leaveApplication =
                    //                   state.extra as LeaveApplication;
                    //               return MaterialPage(
                    //                   child: LeaveDetailsPage(
                    //                       leaveApplication: leaveApplication));
                    //             }),
                    //       ]),
                    // ]
                    ),
                GoRoute(
                    parentNavigatorKey: _shellNavigatorKey,
                    name: Routes.adminLeaves,
                    path: '/leaves',
                    pageBuilder: (context, state) {
                      return const MaterialPage(child: AdminLeavesPage());
                    },
                    routes: <GoRoute>[
                      GoRoute(
                          parentNavigatorKey: _shellNavigatorKey,
                          name: Routes.leaveDetails,
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
                    parentNavigatorKey: _shellNavigatorKey,
                    name: Routes.adminEmployees,
                    path: '/employees',
                    pageBuilder: (context, state) =>
                        const MaterialPage(child: EmployeeListPage()),
                    routes: <GoRoute>[
                      GoRoute(
                          parentNavigatorKey: _shellNavigatorKey,
                          name: Routes.employeeDetail,
                          path: ':employeeId',
                          pageBuilder: (context, state) => MaterialPage(
                              child: EmployeeDetailPage(
                                  id: state
                                      .params[RoutesParamsConst.employeeId]!)),
                          routes: [
                            GoRoute(
                              parentNavigatorKey: _shellNavigatorKey,
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
                    parentNavigatorKey: _shellNavigatorKey,
                    name: Routes.adminSettings,
                    path: '/settings',
                    pageBuilder: (context, state) =>
                        const MaterialPage(child: AdminSettingPage()),
                    routes: <GoRoute>[
                      GoRoute(
                          parentNavigatorKey: _shellNavigatorKey,
                          name: Routes.updateLeaveCount,
                          path: 'paid-leave',
                          pageBuilder: (context, state) => const MaterialPage(
                              child: AdminUpdateLeaveCountsPage())),
                    ]),
              ]),

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
  static const adminLeaves = '/leaves';
  static const adminEmployees = '/employees';
  static const adminSettings = '/settings';
  static const addMember = '/new';
  static const adminCalender = '/calender';
  static const leaveDetails = 'details';
  static const adminEditEmployee = 'edit-employee';

  static const home = '/home';

  static const employeeEditEmployeeDetails = 'employee-edit-employee-details';
  static const rootRoute = '/';
  static const login = '/login';

  static const employees = '/employees';
  static const employeeDetail = '/employee-details/:employeeId';

  //static const adminSettings = '/admin-settings';
  static const updateLeaveCount = '/paid-leave';

  static const leaveApplicationDetail = '/leave-application/:id';
  static const employeeHome = '/employee';
  static const allLeaves = '/all';
  static const requested = '/requested';
  static const upcoming = '/upcoming';
  static const userSettings = '/user-settings';
  static const applyLeave = '/apply-leave';

  //static const adminCalender = '/admin-calender';
  static const userLeaveDetail = '/leave-detail';
  static const userLeaveCalender = '/user-calender';

  static const employeeLeaveDetail = '/employee-leave-detail';
  static const adminLeaveDetail = 'leave-application-details';
}
