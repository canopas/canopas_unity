import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/admin/dashboard/admin_dashboard.dart';
import 'package:projectunity/ui/admin/employee/details_leaves/employee_details_leaves_screen.dart';
import 'package:projectunity/ui/admin/home/application_detail/admin_leave_application_detail.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/admin_leaves_screen.dart';
import 'package:projectunity/ui/sign_in/sign_in_screen.dart';
import 'package:projectunity/ui/user/employees/detail/user_employee_detail_screen.dart';
import 'package:projectunity/ui/user/leaves/detail/user_leave_detail_screen.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/user_leave_screen.dart';
import '../../data/model/employee/employee.dart';
import '../../data/model/leave_application.dart';
import '../../data/provider/user_data.dart';
import '../admin/employee/detail/employee_detail_screen.dart';
import '../admin/employee/edit_employee/admin_edit_employee_screen.dart';
import '../admin/employee/list/employee_list_screen.dart';
import '../admin/home/addmember/admin_add_member_screen.dart';
import '../admin/home/home_screen/admin_home_screen.dart';
import '../admin/leaves/detail/leave_details.dart';
import '../admin/setting/admin_setting_screen.dart';
import '../admin/setting/edit_space/edit_space_screen.dart';
import '../admin/setting/update_leave_count/update_leave_counts_screen.dart';
import '../shared/employees_calendar/employees_calendar_screen.dart';
import '../space/create_space/create_workspace_screen.dart';
import '../space/join_space/join_workspace_screen.dart';
import '../user/dashboard/user_dashboard.dart';
import '../user/employees/list/user_employees_screen.dart';
import '../user/home/home_screen/user_home_screen.dart';
import '../user/home/leave_calendar/user_leave_calendar_screen.dart';
import '../user/leaves/apply_leave/apply_leave_screen.dart';
import '../user/settings/edit_profile/edit_profile_screen.dart';
import '../user/settings/settings_screen/user_settings_screen.dart';

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
        initialLocation: userManager.isAdmin || userManager.isHR
            ? Routes.adminHome
            : Routes.userHome,
        navigatorKey: _rootNavigatorKey,
        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: Routes.login,
            name: Routes.login,
            pageBuilder: (context, state) =>
                const MaterialPage(child: SignInPage()),
          ),
          GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              name: Routes.joinSpace,
              path: Routes.joinSpace,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: JoinSpacePage()),
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  name: Routes.createSpace,
                  path: Routes.createSpace,
                  pageBuilder: (context, state) =>
                      const MaterialPage(child: CreateWorkSpacePage()),
                ),
              ]),
          ShellRoute(
              navigatorKey: _adminShellNavigatorKey,
              builder: (context, state, child) =>
                  AdminDashBoardScreen(child: child),
              routes: [
                GoRoute(
                    parentNavigatorKey: _adminShellNavigatorKey,
                    name: Routes.adminHome,
                    path: Routes.adminHome,
                    pageBuilder: (context, state) {
                      return const MaterialPage(child: AdminHomeScreenPage());
                    },
                    routes: <GoRoute>[
                      GoRoute(
                          path: Routes.addMember,
                          name: Routes.addMember,
                          parentNavigatorKey: _adminShellNavigatorKey,
                          pageBuilder: (context, state) =>
                              const NoTransitionPage(
                                  child: AdminAddMemberPage())),
                      GoRoute(
                        parentNavigatorKey: _adminShellNavigatorKey,
                        name: Routes.leaveRequestDetail,
                        path: Routes.leaveRequestDetail,
                        pageBuilder: (context, state) => NoTransitionPage(
                            child: AdminLeaveApplicationDetailsPage(
                                leaveApplication:
                                    state.extra as LeaveApplication)),
                      ),
                      GoRoute(
                        parentNavigatorKey: _adminShellNavigatorKey,
                        name: Routes.adminCalender,
                        path: Routes.adminCalender,
                        pageBuilder: (context, state) => const NoTransitionPage(
                          child: EmployeesLeaveCalenderPage(),
                        ),
                        routes: [
                          GoRoute(
                            parentNavigatorKey: _adminShellNavigatorKey,
                            name: Routes.adminCalendarLeaveDetails,
                            path: Routes.adminCalendarLeaveDetails,
                            pageBuilder: (context, state) => NoTransitionPage(
                                child: AdminLeaveDetailsPage(
                                    leaveApplication:
                                        state.extra as LeaveApplication)),
                          ),
                        ],
                      )
                    ]),
                GoRoute(
                    parentNavigatorKey: _adminShellNavigatorKey,
                    name: Routes.adminLeaves,
                    path: Routes.adminLeaves,
                    pageBuilder: (context, state) {
                      return const MaterialPage(child: AdminLeavesPage());
                    },
                    routes: <GoRoute>[
                      GoRoute(
                        name: Routes.applyHRLeave,
                        path: Routes.applyHRLeave,
                        pageBuilder: (context, state) => const NoTransitionPage(
                          child: ApplyLeavePage(),
                        ),
                      ),
                      GoRoute(
                        parentNavigatorKey: _adminShellNavigatorKey,
                        name: Routes.adminLeaveDetails,
                        path: Routes.adminLeaveDetails,
                        pageBuilder: (context, state) => NoTransitionPage(
                            child: AdminLeaveDetailsPage(
                                leaveApplication:
                                    state.extra as LeaveApplication)),
                      ),
                    ]),
                GoRoute(
                    parentNavigatorKey: _adminShellNavigatorKey,
                    name: Routes.adminEmployees,
                    path: Routes.adminEmployees,
                    pageBuilder: (context, state) =>
                        const MaterialPage(child: EmployeeListPage()),
                    routes: <GoRoute>[
                      GoRoute(
                          parentNavigatorKey: _adminShellNavigatorKey,
                          name: Routes.adminEmployeeDetail,
                          path: Routes.adminEmployeeDetail,
                          pageBuilder: (context, state) => NoTransitionPage(
                              child: EmployeeDetailPage(
                                  id: state
                                      .params[RoutesParamsConst.employeeId]!)),
                          routes: [
                            GoRoute(
                                parentNavigatorKey: _adminShellNavigatorKey,
                                name: Routes.adminEmployeeDetailsLeaves,
                                path: Routes.adminEmployeeDetailsLeaves,
                                routes: [
                                  GoRoute(
                                    name: Routes
                                        .adminEmployeeDetailsLeavesDetails,
                                    path: Routes
                                        .adminEmployeeDetailsLeavesDetails,
                                    pageBuilder: (context, state) =>
                                        NoTransitionPage(
                                            child: UserLeaveDetailPage(
                                                leaveId: state.params[
                                                    RoutesParamsConst
                                                        .leaveId]!)),
                                  ),
                                ],
                                pageBuilder: (context, state) =>
                                    NoTransitionPage(
                                        child: AdminEmployeeDetailsLeavesPage(
                                      employeeName: state.params[
                                              RoutesParamsConst.employeeName] ??
                                          "",
                                      employeeId: state.params[
                                          RoutesParamsConst.employeeId]!,
                                    ))),
                            GoRoute(
                              parentNavigatorKey: _adminShellNavigatorKey,
                              path: Routes.adminEditEmployee,
                              name: Routes.adminEditEmployee,
                              pageBuilder: (context, state) => NoTransitionPage(
                                  child: AdminEditEmployeeDetailsPage(
                                employee: state.extra as Employee,
                              )),
                            ),
                          ]),
                    ]),
                GoRoute(
                    parentNavigatorKey: _adminShellNavigatorKey,
                    name: Routes.adminSettings,
                    path: Routes.adminSettings,
                    pageBuilder: (context, state) =>
                        const MaterialPage(child: AdminSettingPage()),
                    routes: <GoRoute>[
                      GoRoute(
                        parentNavigatorKey: _adminShellNavigatorKey,
                        path: Routes.adminEditProfile,
                        name: Routes.adminEditProfile,
                        pageBuilder: (context, state) => NoTransitionPage(
                            child: EmployeeEditProfilePage(
                          employee: state.extra as Employee,
                        )),
                      ),
                      GoRoute(
                          parentNavigatorKey: _adminShellNavigatorKey,
                          name: Routes.updateLeaveCount,
                          path: Routes.updateLeaveCount,
                          pageBuilder: (context, state) =>
                              const NoTransitionPage(
                                  child: AdminUpdateLeaveCountsPage())),
                      GoRoute(
                          parentNavigatorKey: _adminShellNavigatorKey,
                          name: Routes.editWorkspaceDetails,
                          path: Routes.editWorkspaceDetails,
                          pageBuilder: (context, state) =>
                              const NoTransitionPage(child: EditSpacePage())),
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
                    path: Routes.userHome,
                    name: Routes.userHome,
                    pageBuilder: (context, state) =>
                        const MaterialPage(child: UserHomeScreenPage()),
                    routes: <GoRoute>[
                      GoRoute(
                          name: Routes.userRequestDetail,
                          path: Routes.userRequestDetail,
                          pageBuilder: (context, state) {
                            return NoTransitionPage(
                                child: UserLeaveDetailPage(
                                    leaveId: state
                                        .params[RoutesParamsConst.leaveId]!));
                          }),
                      GoRoute(
                          parentNavigatorKey: _employeeShellNavigatorKey,
                          path: Routes.userCalender,
                          name: Routes.userCalender,
                          routes: [
                            GoRoute(
                              name: Routes.userCalendarLeaveDetail,
                              path: Routes.userCalendarLeaveDetail,
                              pageBuilder: (context, state) => NoTransitionPage(
                                  child: UserLeaveDetailPage(
                                      leaveId: state
                                          .params[RoutesParamsConst.leaveId]!)),
                            ),
                          ],
                          pageBuilder: (context, state) =>
                              const NoTransitionPage(
                                  child: EmployeesLeaveCalenderPage())),
                      GoRoute(
                          parentNavigatorKey: _employeeShellNavigatorKey,
                          name: Routes.userLeaveCalender,
                          path: Routes.userLeaveCalender,
                          pageBuilder: (context, state) => NoTransitionPage(
                              child: UserLeaveCalendarPage(
                                  userId: userManager.employeeId))),
                    ]),
                GoRoute(
                    parentNavigatorKey: _employeeShellNavigatorKey,
                    path: Routes.userLeaves,
                    name: Routes.userLeaves,
                    pageBuilder: (context, state) =>
                        const MaterialPage(child: UserLeavePage()),
                    routes: <GoRoute>[
                      GoRoute(
                        name: Routes.applyLeave,
                        path: Routes.applyLeave,
                        pageBuilder: (context, state) => const NoTransitionPage(
                          child: ApplyLeavePage(),
                        ),
                      ),
                      GoRoute(
                        name: Routes.userLeaveDetail,
                        path: Routes.userLeaveDetail,
                        pageBuilder: (context, state) => NoTransitionPage(
                            child: UserLeaveDetailPage(
                                leaveId:
                                    state.params[RoutesParamsConst.leaveId]!)),
                      ),
                    ]),
                GoRoute(
                    parentNavigatorKey: _employeeShellNavigatorKey,
                    path: Routes.userEmployees,
                    name: Routes.userEmployees,
                    pageBuilder: (context, state) =>
                        const MaterialPage(child: UserEmployeesPage()),
                    routes: <GoRoute>[
                      GoRoute(
                        parentNavigatorKey: _employeeShellNavigatorKey,
                        name: Routes.userEmployeeDetail,
                        path: Routes.userEmployeeDetail,
                        pageBuilder: (context, state) => NoTransitionPage(
                            child: UserEmployeeDetailPage(
                                employeeId: state
                                    .params[RoutesParamsConst.employeeId]!)),
                      ),
                    ]),
                GoRoute(
                    parentNavigatorKey: _employeeShellNavigatorKey,
                    path: Routes.userSettings,
                    name: Routes.userSettings,
                    pageBuilder: (context, state) =>
                        const MaterialPage(child: UserSettingsPage()),
                    routes: <GoRoute>[
                      GoRoute(
                        path: Routes.userEditProfile,
                        name: Routes.userEditProfile,
                        pageBuilder: (context, state) => NoTransitionPage(
                            child: EmployeeEditProfilePage(
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
          if (userManager.loggedIn && !userManager.spaceSelected) {
            return Routes.joinSpace;
          }
          if (userManager.loggedIn && userManager.spaceSelected) {
            return userManager.isAdmin ? Routes.addMember : Routes.userHome;
          }
          return null;
        });
  }
}

abstract class RoutesParamsConst {
  static const employeeId = "employeeId";
  static const employeeName = "employeeName";
  static const leaveId = 'leaveId';
}

abstract class Routes {
  static const adminHome = '/admin-home';
  static const adminLeaves = '/admin-leaves';
  static const adminEmployees = '/admin-employees';
  static const adminSettings = '/admin-settings';
  static const adminEditProfile = "admin-edit-profile";
  static const addMember = 'new';
  static const adminCalender = 'admin-calender';
  static const adminLeaveDetails = 'admin-leave-details';
  static const adminEditEmployee = 'admin-edit-employee-details';
  static const adminEmployeeDetail = 'admin-employee-details/:employeeId';
  static const leaveRequestDetail = 'admin-leave-application-details';
  static const adminCalendarLeaveDetails = 'admin-calendar-leave-details';
  static const userHome = '/user-home';
  static const userLeaves = '/leaves';
  static const userEmployees = '/employees';
  static const userSettings = '/settings';
  static const userLeaveDetail = 'leave-detail/:leaveId';
  static const userCalendarLeaveDetail = 'leave-calendar-detail/:leaveId';
  static const userRequestDetail = 'leave-request-detail/:leaveId';
  static const userEmployeeDetail = 'employee-details/:employeeId';
  static const userEditProfile = 'user-edit-profile';
  static const applyLeave = 'apply-leave';
  static const applyHRLeave = 'apply-hr-leave';
  static const userCalender = 'calender';
  static const login = '/login';
  static const createSpace = 'create-space';
  static const updateLeaveCount = 'update-paid-leave';
  static const editWorkspaceDetails = 'edit-workspace-details';
  static const userLeaveCalender = 'user-calender';
  static const joinSpace = '/spaces';
  static const adminEmployeeDetailsLeaves =
      'admin-employee-detail-leaves/:employeeName';
  static const adminEmployeeDetailsLeavesDetails =
      'admin-employee-detail-leaves-details/:leaveId';
}
