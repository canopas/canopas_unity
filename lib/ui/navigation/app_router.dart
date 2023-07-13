import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/admin/dashboard/admin_dashboard.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/admin_leaves_screen.dart';
import 'package:projectunity/ui/shared/profile/view_profile/view_profle_screen.dart';
import 'package:projectunity/ui/sign_in/sign_in_screen.dart';
import 'package:projectunity/ui/user/hr_requests/apply_hr_request/hr_request_form.dart';
import 'package:projectunity/ui/user/hr_requests/hr_requests_screen.dart';
import 'package:projectunity/ui/user/leaves/detail/user_leave_detail_screen.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/user_leave_screen.dart';
import '../../data/model/employee/employee.dart';
import '../../data/model/leave_application.dart';
import '../../data/provider/user_state.dart';
import '../admin/drawer_options/edit_space/edit_space_screen.dart';
import '../admin/home/home_screen/admin_home_screen.dart';
import '../admin/home/invite_member/invite_screen.dart';
import '../admin/leaves/details/admin_leave_detail.dart';
import '../admin/members/detail/employee_detail_screen.dart';
import '../admin/members/details_leaves/employee_details_leaves_screen.dart';
import '../admin/members/edit_employee/admin_edit_employee_screen.dart';
import '../admin/members/list/member_list_screen.dart';
import '../shared/profile/edit_profile/edit_profile_screen.dart';
import '../space/create_space/create_workspace_screen.dart';
import '../space/join_space/join_space_screen.dart';
import '../user/dashboard/user_dashboard.dart';
import '../user/home/home_screen/user_home_screen.dart';
import '../user/home/leave_calendar/user_leave_calendar_screen.dart';
import '../user/leaves/apply_leave/apply_leave_screen.dart';
import '../user/members/detail/user_employee_detail_screen.dart';
import '../user/members/members_screen/user_members_screen.dart';
import '../widget/error/page_not_found_screen.dart';

@Injectable()
class AppRouter {
  final UserStateNotifier _userManager;

  AppRouter(this._userManager);

  GoRouter get router => _goRouter(_userManager);
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _adminShellNavigatorKey = GlobalKey<NavigatorState>();
  final _employeeShellNavigatorKey = GlobalKey<NavigatorState>();

  GoRouter _goRouter(UserStateNotifier userManager) {
    return GoRouter(
        debugLogDiagnostics: true,
        errorPageBuilder: (context, state) =>
            const CupertinoPage(child: PageNotFoundScreen()),
        refreshListenable: userManager,
        initialLocation: (userManager.isAdmin || _userManager.isHR)
            ? Routes.adminHome
            : Routes.userHome,
        navigatorKey: _rootNavigatorKey,
        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: Routes.login,
            name: Routes.login,
            pageBuilder: (context, state) =>
                const CupertinoPage(child: SignInPage()),
          ),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            name: Routes.joinSpace,
            path: Routes.joinSpace,
            pageBuilder: (context, state) =>
                const CupertinoPage(child: JoinSpacePage()),
            routes: [
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                name: Routes.createSpace,
                path: Routes.createSpace,
                pageBuilder: (context, state) =>
                    const CupertinoPage(child: CreateWorkSpacePage()),
              ),
            ],
          ),
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
                      return CupertinoPage(
                          key: ValueKey(userManager.currentSpaceId),
                          child: const AdminHomeScreenPage());
                    },
                    routes: <GoRoute>[
                      GoRoute(
                          parentNavigatorKey: _adminShellNavigatorKey,
                          name: Routes.editSpaceDetails,
                          path: Routes.editSpaceDetails,
                          pageBuilder: (context, state) =>
                              const CupertinoPage(child: EditSpacePage())),
                      GoRoute(
                          parentNavigatorKey: _adminShellNavigatorKey,
                          name: Routes.adminProfile,
                          path: 'profile',
                          pageBuilder: (context, state) =>
                              const CupertinoPage(child: ViewProfilePage()),
                          routes: [
                            GoRoute(
                                path: 'edit',
                                name: Routes.adminEditProfile,
                                pageBuilder: (context, state) => CupertinoPage(
                                        child: EmployeeEditProfilePage(
                                      employee: _userManager.employee,
                                    )))
                          ]),
                      GoRoute(
                        parentNavigatorKey: _adminShellNavigatorKey,
                        name: Routes.leaveRequestDetail,
                        path: Routes.leaveRequestDetail,
                        pageBuilder: (context, state) => CupertinoPage(
                            child: AdminLeaveDetailsPage(
                                leaveApplication:
                                    state.extra as LeaveApplication)),
                      ),
                      GoRoute(
                        parentNavigatorKey: _adminShellNavigatorKey,
                        name: Routes.adminAbsenceDetails,
                        path: 'absence/details',
                        pageBuilder: (context, state) => CupertinoPage(
                            child: AdminLeaveDetailsPage(
                                leaveApplication:
                                state.extra as LeaveApplication)),
                      )
                    ]),
                GoRoute(
                    parentNavigatorKey: _adminShellNavigatorKey,
                    name: Routes.adminLeaves,
                    path: Routes.adminLeaves,
                    pageBuilder: (context, state) {
                      return CupertinoPage(
                          key: ValueKey(userManager.currentSpaceId),
                          child: const AdminLeavesPage());
                    },
                    routes: <GoRoute>[
                      GoRoute(
                        name: Routes.hrApplyLeave,
                        path: Routes.hrApplyLeave,
                        pageBuilder: (context, state) => const CupertinoPage(
                          child: ApplyLeavePage(),
                        ),
                      ),
                      GoRoute(
                        parentNavigatorKey: _adminShellNavigatorKey,
                        name: Routes.adminLeaveDetails,
                        path: 'details',
                        pageBuilder: (context, state) => CupertinoPage(
                            child: AdminLeaveDetailsPage(
                                leaveApplication:
                                    state.extra as LeaveApplication)),
                      ),
                    ]),
                GoRoute(
                    parentNavigatorKey: _adminShellNavigatorKey,
                    name: Routes.adminMembers,
                    path: Routes.adminMembers,
                    pageBuilder: (context, state) => CupertinoPage(
                        key: ValueKey(userManager.currentSpaceId),
                        child: const MemberListPage()),
                    routes: <GoRoute>[
                      GoRoute(
                          path: Routes.inviteMember,
                          name: Routes.inviteMember,
                          parentNavigatorKey: _adminShellNavigatorKey,
                          pageBuilder: (context, state) =>
                              const CupertinoPage(child: InviteMemberPage())),
                      GoRoute(
                          parentNavigatorKey: _adminShellNavigatorKey,
                          name: Routes.adminMemberDetails,
                          path: Routes.adminMemberDetails,
                          pageBuilder: (context, state) => CupertinoPage(
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
                                        CupertinoPage(
                                            child: UserLeaveDetailPage(
                                                leaveId: state.params[
                                                    RoutesParamsConst
                                                        .leaveId]!)),
                                  ),
                                ],
                                pageBuilder: (context, state) => CupertinoPage(
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
                              pageBuilder: (context, state) => CupertinoPage(
                                  child: AdminEditEmployeeDetailsPage(
                                employee: state.extra as Employee,
                              )),
                            ),
                          ]),
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
                    pageBuilder: (context, state) => CupertinoPage(
                        key: ValueKey(userManager.currentSpaceId),
                        child: const UserHomeScreenPage()),
                    routes: <GoRoute>[
                      GoRoute(
                          path: Routes.hrRequests,
                          name: Routes.hrRequests,
                          pageBuilder: (context, state) => const CupertinoPage(child: HrRequestsPage()),
                          routes: [
                            GoRoute(
                              path: Routes.applyHrRequests,
                              name: Routes.applyHrRequests,
                              pageBuilder: (context, state) => const CupertinoPage(child: HrRequestFormPage()),
                            ),
                          ]
                      ),
                      GoRoute(
                          parentNavigatorKey: _employeeShellNavigatorKey,
                          name: Routes.userProfile,
                          path: 'profile',
                          pageBuilder: (context, state) => const CupertinoPage(
                                child: ViewProfilePage(),
                              ),
                          routes: [
                            GoRoute(
                              path: 'edit',
                              name: Routes.userEditProfile,
                              pageBuilder: (context, state) => CupertinoPage(
                                  child: EmployeeEditProfilePage(
                                employee: userManager.employee,
                              )),
                            ),
                          ]),
                      GoRoute(
                          name: Routes.userRequestDetail,
                          path: Routes.userRequestDetail,
                          pageBuilder: (context, state) {
                            return CupertinoPage(
                                child: UserLeaveDetailPage(
                                    leaveId: state
                                        .params[RoutesParamsConst.leaveId]!));
                          }),
                      GoRoute(
                        name: Routes.userAbsenceDetails,
                        path: Routes.userAbsenceDetails,
                        pageBuilder: (context, state) => CupertinoPage(
                            child: UserLeaveDetailPage(
                                leaveId: state
                                    .params[RoutesParamsConst.leaveId]!)),
                      ),
                      GoRoute(
                          parentNavigatorKey: _employeeShellNavigatorKey,
                          name: Routes.userLeaveCalender,
                          path: Routes.userLeaveCalender,
                          pageBuilder: (context, state) => CupertinoPage(
                              child: UserLeaveCalendarPage(
                                  userId: userManager.userUID!))),
                    ]),
                GoRoute(
                    parentNavigatorKey: _employeeShellNavigatorKey,
                    path: Routes.userLeaves,
                    name: Routes.userLeaves,
                    pageBuilder: (context, state) => CupertinoPage(
                        key: ValueKey(userManager.currentSpaceId),
                        child: const UserLeavePage()),
                    routes: <GoRoute>[
                      GoRoute(
                        name: Routes.applyLeave,
                        path: Routes.applyLeave,
                        pageBuilder: (context, state) => const CupertinoPage(
                          child: ApplyLeavePage(),
                        ),
                      ),
                      GoRoute(
                        name: Routes.userLeaveDetail,
                        path: Routes.userLeaveDetail,
                        pageBuilder: (context, state) => CupertinoPage(
                            child: UserLeaveDetailPage(
                                leaveId:
                                    state.params[RoutesParamsConst.leaveId]!)),
                      ),
                    ]),
                GoRoute(
                    parentNavigatorKey: _employeeShellNavigatorKey,
                    path: Routes.userMembers,
                    name: Routes.userMembers,
                    pageBuilder: (context, state) => CupertinoPage(
                        key: ValueKey(userManager.currentSpaceId),
                        child: const UserMembersPage()),
                    routes: <GoRoute>[
                      GoRoute(
                        parentNavigatorKey: _employeeShellNavigatorKey,
                        name: Routes.userEmployeeDetail,
                        path: Routes.userEmployeeDetail,
                        pageBuilder: (context, state) => CupertinoPage(
                            child: UserEmployeeDetailPage(
                                employee: state.extra as Employee)),
                      ),
                    ]),
              ])
        ],
        redirect: (context, state) {
          final loggingIn = state.subloc == Routes.login;
          if (userManager.state == UserState.unauthenticated) {
            return loggingIn ? null : Routes.login;
          }
          if (userManager.state == UserState.authenticated &&
              !state.subloc.contains(Routes.joinSpace)) {
            return Routes.joinSpace;
          }
          if (userManager.state == UserState.update ||
              (userManager.state == UserState.spaceJoined &&
                  state.subloc.contains(Routes.joinSpace))) {
            return userManager.isAdmin || userManager.isHR
                ? Routes.adminHome
                : Routes.userHome;
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
  static const login = '/login';
  static const joinSpace = '/spaces';
  static const createSpace = 'create-space';

  static const adminHome = '/admin/home';
  static const inviteMember = 'invite';
  static const adminAbsenceDetails = 'admin-calendar-leave-details';
  static const leaveRequestDetail = 'leave-request/details';
  static const adminProfile = '/admin-home/profile';
  static const adminEditProfile = "/admin-home/profile/edit";
  static const editSpaceDetails = 'edit-space';

  static const adminLeaves = '/admin/leaves';
  static const adminLeaveDetails = 'admin-leave-details';
  static const hrApplyLeave = 'hr/apply-leave';

  static const adminMembers = '/admin/members';
  static const adminMemberDetails = 'details/:employeeId';
  static const adminEmployeeDetailsLeaves = 'leaves/:employeeName';
  static const adminEmployeeDetailsLeavesDetails = 'leave-details/:leaveId';
  static const adminEditEmployee = 'edit-user-details';

  static const userHome = '/home';
  static const userAbsenceDetails = 'absence/details/:leaveId';
  static const userRequestDetail = 'leave-request-detail/:leaveId';
  static const userLeaveCalender = 'user-calender';
  static const userProfile = '/user-home/profile';
  static const hrRequests = 'hr-request';
  static const applyHrRequests = 'apply-hr-request';
  static const userEditProfile = '/user-home/profile/edit';

  static const userLeaves = '/leaves';
  static const userLeaveDetail = 'details/:leaveId';
  static const applyLeave = 'apply-leave';

  static const userMembers = '/members';
  static const userEmployeeDetail = 'employee-details/:employeeId';
}
