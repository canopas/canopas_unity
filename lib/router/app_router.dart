import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/model/employee/employee.dart';
import 'package:projectunity/ui/admin/addmember/admin_add_member_screen.dart';
import 'package:projectunity/ui/admin/edit_employe_details/admin_edit_employee_details_view.dart';
import 'package:projectunity/ui/admin/leave_request_details/admin_leave_request_details_view.dart';
import 'package:projectunity/ui/shared/leave_details/leave_details.dart';
import 'package:projectunity/ui/user/all_leaves/all_leaves_screen.dart';
import 'package:projectunity/ui/user/home/employee_home_screen.dart';
import 'package:projectunity/ui/user/leave/applyLeave/apply_leave_screen.dart';
import 'package:projectunity/ui/user/requested_leaves/requested_leaves_view.dart';
import '../model/leave_application.dart';
import '../provider/user_data.dart';
import '../ui/admin/employee/detail/employee_detail_screen.dart';
import '../ui/admin/employee/list/employee_list_screen.dart';
import '../ui/admin/home/admin_home_screen.dart';
import '../ui/admin/setting/admin_setting_screen.dart';
import '../ui/admin/setting/update_leave_count/update_leave_counts_screen.dart';
import '../ui/login/login_screen.dart';
import '../ui/shared/employees_calendar/employees_calendar_screen.dart';
import '../ui/user/edit_employee_details/edit_employee_details_employee_view.dart';
import '../ui/user/setting/employee_setting_screen.dart';
import '../ui/user/upcoming_leaves/upcoming_leaves_view.dart';
import '../ui/user/user_employees/user_employees_screen.dart';
import '../ui/user/user_leave_calendar/user_leave_calendar_screen.dart';

@Injectable()
class AppRouter {
  final UserManager _userManager;

  AppRouter(this._userManager);
  GoRouter get router => _goRouter(_userManager);


  static GoRouter _goRouter(UserManager userManager) {
    return GoRouter(
        refreshListenable: userManager,
        routes: <GoRoute>[
          GoRoute(
              path: '/',
              name: Routes.rootRoute,
              redirect: (context, state) {
                return userManager.isAdmin
                    ? Routes.adminHome
                    : Routes.employeeHome;
              }),
          GoRoute(
              path: '/login',
              name: Routes.login,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: LoginPage())),
          GoRoute(
              name: Routes.adminHome,
              path: '/admin',
              pageBuilder: (context, state) =>
              const MaterialPage(child: AdminHomePage()),
              routes: <GoRoute>[
                GoRoute(
                    name: Routes.employees,
                    path: 'employees',
                    pageBuilder: (context, state) =>
                        const MaterialPage(child: EmployeeListPage()),
                    routes: <GoRoute>[
                      GoRoute(
                          name: Routes.employeeDetail,
                          path: ':employeeId',
                          pageBuilder: (context, state) => MaterialPage(
                              child: EmployeeDetailPage(
                                  id: state.params[RoutesParamsConst.employeeId]!)),
                      routes: [
                        GoRoute(
                          path: 'admin-edit-employee-details',
                          name: Routes.adminEditEmployeeDetails,
                          pageBuilder: (context, state) => MaterialPage(
                              child: AdminEditEmployeeDetailsPage(
                                employee: state.extra as Employee,
                              )),
                        ),
                      ]),
                    ]),

                GoRoute(
                    name: Routes.adminLeaveDetail,
                    path: 'leave-application',
                    pageBuilder: (context, state) {
                      LeaveApplication leaveApplication =
                          state.extra as LeaveApplication;
                      return MaterialPage(
                          child: AdminLeaveRequestDetailsPage(
                              leaveApplication: leaveApplication));
                    }),
                GoRoute(
                    name: Routes.adminCalender,
                    path: 'calender',
                    pageBuilder: (context, state) =>  const MaterialPage(
                          child: EmployeesLeaveCalenderPage(),
                        ),
                    routes: <GoRoute>[
                      GoRoute(
                          name: Routes.leaveApplicationDetail,
                          path: 'leave-application',
                          pageBuilder: (context, state) {
                          LeaveApplication leaveApplication =
                          state.extra as LeaveApplication;
                          return MaterialPage(
                              child: LeaveDetailsPage(
                                  leaveApplication: leaveApplication));
                        }),
                  ]
              ),


                GoRoute(
                    name: Routes.addMember,
                    path: 'new',
                    pageBuilder: (context, state) =>
                    const MaterialPage(child: AdminAddMemberPage())),
                GoRoute(
                    name: Routes.adminSettings,
                    path: 'settings',
                    pageBuilder: (context, state) =>
                    const MaterialPage(child: AdminSettingPage()),
                    routes: <GoRoute>[
                      GoRoute(
                          name: Routes.updateLeaveCount,
                          path: 'paid-leave',
                          pageBuilder: (context, state) => const MaterialPage(
                              child: AdminUpdateLeaveCountsPage())),
                    ]),
              ]),

          GoRoute(
              name: Routes.employeeHome,
              path: '/employee',
              pageBuilder: (context, state) =>
              const MaterialPage(child: UserEmployeesPage()),
              routes: <GoRoute>[
                GoRoute(
                    name: Routes.allLeaves,
                    path: 'all',
                    pageBuilder: (context, state) =>
                    const MaterialPage(child: AllLeavesPage())),
                GoRoute(
                    name: Routes.requested,
                    path: 'requested',
                    pageBuilder: (context, state) =>
                    const MaterialPage(child: RequestedLeavesPage())),
                GoRoute(
                    name: Routes.upcoming,
                    path: 'upcoming',
                    pageBuilder: (context, state) =>
                    const MaterialPage(child: UpcomingLeavesPage())),
                GoRoute(
                  name: Routes.applyLeave,
                  path: 'apply-leave',
                  pageBuilder: (context, state) => const MaterialPage(
                    child: ApplyLeavePage(),
                  ),
                ),
                GoRoute(
                    name: Routes.userSettings,
                    path: 'setting',
                    pageBuilder: (context, state) =>
                        const MaterialPage(child: EmployeeSettingPage()),
                  routes: [
                    GoRoute(
                      path: 'employee-edit-employee-details',
                      name: Routes.employeeEditEmployeeDetails,
                      pageBuilder: (context, state) => MaterialPage(
                          child: EmployeeEditEmployeeDetailsPage(
                            employee: state.extra as Employee,
                          )),
                    ),
                  ]
                ),
                GoRoute(
                    name: Routes.allUserCalender,
                    path: 'calender',
                    pageBuilder: (context, state) => const MaterialPage(
                          child: EmployeesLeaveCalenderPage(),
                        ),
                    routes: <GoRoute>[
                      GoRoute(
                          name: Routes.employeeLeaveDetail,
                          path: 'leave-detail',
                          pageBuilder: (context, state) {
                            LeaveApplication leaveApplication =
                            state.extra as LeaveApplication;
                            return MaterialPage(
                                child: LeaveDetailsPage(
                                    leaveApplication: leaveApplication));
                          }),
                    ]
                ),


                GoRoute(
                    name: Routes.userLeaveCalender,
                    path: 'user-calender',
                    pageBuilder: (context, state) => MaterialPage(
                        child: UserLeaveCalendarPage(
                            userId: userManager.employeeId)),
                  routes: <GoRoute>[
                    GoRoute(
                        name: Routes.userLeaveDetail,
                        path: 'details',
                        pageBuilder: (context, state) {
                          LeaveApplication leaveApplication =
                          state.extra as LeaveApplication;
                          return MaterialPage(
                              child: LeaveDetailsPage(
                                  leaveApplication: leaveApplication));
                        }),
                  ]
                   ),
              ]),


        ],
        redirect: (context, state) {
          final loggingIn = state.subloc == Routes.login;
          if (!userManager.loggedIn) {
            return loggingIn ? null : Routes.login;
          }
           if(userManager.loggedIn&&loggingIn)return Routes.rootRoute;
           return null;
        }

    );
  }
}
abstract class RoutesParamsConst{
  static const employeeId = "employeeId";
}

abstract class Routes {
  static const adminEditEmployeeDetails = 'admin-edit-employee-details';
  static const employeeEditEmployeeDetails = 'employee-edit-employee-details';
  static const rootRoute = '/';
  static const login = '/login';
  static const adminHome = '/admin';
  static const employees = '/employees';
  static const employeeDetail = '/employee-details/:employeeId';
  static const adminSettings = '/admin-settings';
  static const updateLeaveCount = '/paid-leave';
  static const addMember = '/new';
  static const leaveApplicationDetail = '/leave-application/:id';
  static const employeeHome = '/employee';
  static const allLeaves = '/all';
  static const requested = '/requested';
  static const upcoming = '/upcoming';
  static const userSettings = '/user-settings';
  static const applyLeave = '/apply-leave';
  static const adminCalender = '/admin-calender';
  static const userLeaveDetail = '/leave-detail';
  static const userLeaveCalender = '/user-calender';
  static const allUserCalender = '/all-user-calender';
  static const employeeLeaveDetail = '/employee-leave-detail';
  static const adminLeaveDetail = 'leave-application-details';
}
