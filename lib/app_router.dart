import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/admin/forms/form_list/form_list_screen.dart';
import 'package:projectunity/ui/admin/leaves/leave_screen/admin_leaves_screen.dart';
import 'package:projectunity/ui/shared/dashboard/navigation_item.dart';
import 'package:projectunity/ui/shared/profile/view_profile/view_profle_screen.dart';
import 'package:projectunity/ui/sign_in/setup_profile/setup_profile_screen.dart';
import 'package:projectunity/ui/sign_in/sign_in_screen.dart';
import 'package:projectunity/ui/user/leaves/detail/user_leave_detail_screen.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/user_leave_screen.dart';
import 'data/model/employee/employee.dart';
import 'data/model/leave_application.dart';
import 'data/provider/user_state.dart';
import 'ui/admin/forms/create_form/create_form.dart';
import 'ui/admin/home/home_screen/admin_home_screen.dart';
import 'ui/admin/home/invite_member/invite_screen.dart';
import 'ui/admin/leaves/details/admin_leave_detail.dart';
import 'ui/admin/members/detail/employee_detail_screen.dart';
import 'ui/admin/members/details_leaves/employee_details_leaves_screen.dart';
import 'ui/admin/members/edit_employee/admin_edit_employee_screen.dart';
import 'ui/admin/members/list/member_list_screen.dart';
import 'ui/shared/dashboard/dashboard.dart';
import 'ui/shared/profile/edit_profile/edit_profile_screen.dart';
import 'ui/space/create_space/create_workspace_screen.dart';
import 'ui/space/edit_space/edit_space_screen.dart';
import 'ui/space/join_space/join_space_screen.dart';
import 'ui/user/forms/form_list_screen/forms_list_screen.dart';
import 'ui/user/home/home_screen/user_home_screen.dart';
import 'ui/user/leaves/apply_leave/apply_leave_screen.dart';
import 'ui/user/members/detail/user_employee_detail_screen.dart';
import 'ui/user/members/members_screen/user_members_screen.dart';
import 'ui/widget/error/page_not_found_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

@Injectable()
class AppRouter {
  final UserStateNotifier _userManager;

  AppRouter(this._userManager);

  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _adminShellHomeNavigatorKey = GlobalKey<NavigatorState>();
  final _adminShellLeavesNavigatorKey = GlobalKey<NavigatorState>();
  final _adminShellEmployeeNavigatorKey = GlobalKey<NavigatorState>();

  final _employeeShellHomeNavigatorKey = GlobalKey<NavigatorState>();
  final _employeeShellLeaveNavigatorKey = GlobalKey<NavigatorState>();
  final _employeeShellEmployeeNavigatorKey = GlobalKey<NavigatorState>();

  GoRouter router() {
    return GoRouter(
        debugLogDiagnostics: true,
        errorPageBuilder: (context, state) =>
            const CupertinoPage(child: PageNotFoundScreen()),
        refreshListenable: _userManager,
        initialLocation: (_userManager.isAdmin || _userManager.isHR)
            ? Routes.adminHome
            : Routes.userHome,
        navigatorKey: _rootNavigatorKey,
        routes: [
          GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: Routes.setupProfile,
              name: Routes.setupProfile,
              pageBuilder: (context, state) {
                final firebase_auth.User user =
                    state.extra as firebase_auth.User;
                return CupertinoPage(child: SetUpProfilePage(user: user));
              }),
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
          StatefulShellRoute.indexedStack(
              builder: (context, state, child) {
                return DashBoardScreen(
                    key: ValueKey(_userManager.currentSpaceId),
                    tabs: adminTabs,
                    child: child);
              },
              branches: [
                StatefulShellBranch(
                    navigatorKey: _adminShellHomeNavigatorKey,
                    routes: [
                      GoRoute(
                          name: Routes.adminHome,
                          path: Routes.adminHome,
                          pageBuilder: (context, state) {
                            return CupertinoPage(
                                key: ValueKey(_userManager.currentSpaceId),
                                child: const AdminHomeScreenPage());
                          },
                          routes: <GoRoute>[
                            GoRoute(
                                name: Routes.editSpaceDetails,
                                path: Routes.editSpaceDetails,
                                pageBuilder: (context, state) =>
                                    const CupertinoPage(
                                        child: EditSpacePage())),
                            GoRoute(
                                name: Routes.adminProfile,
                                path: 'profile',
                                pageBuilder: (context, state) =>
                                    const CupertinoPage(
                                        child: ViewProfilePage()),
                                routes: [
                                  GoRoute(
                                      path: 'edit',
                                      name: Routes.adminEditProfile,
                                      pageBuilder: (context, state) =>
                                          CupertinoPage(
                                              child: EmployeeEditProfilePage(
                                            employee: _userManager.employee,
                                          )))
                                ]),
                            GoRoute(
                                name: Routes.adminForms,
                                path: 'forms',
                                pageBuilder: (context, state) =>
                                    const CupertinoPage(
                                        child: AdminFormListPage()),
                                routes: [
                                  GoRoute(
                                      name: Routes.newForm,
                                      path: 'new-form',
                                      pageBuilder: (context, state) =>
                                          const CupertinoPage(
                                              child: CreateFromPage())),
                                ]),
                            GoRoute(
                              name: Routes.leaveRequestDetail,
                              path: Routes.leaveRequestDetail,
                              pageBuilder: (context, state) => CupertinoPage(
                                  child: AdminLeaveDetailsPage(
                                      leaveApplication:
                                          state.extra as LeaveApplication)),
                            ),
                            GoRoute(
                              name: Routes.adminAbsenceDetails,
                              path: 'absence/details',
                              pageBuilder: (context, state) => CupertinoPage(
                                  child: AdminLeaveDetailsPage(
                                      leaveApplication:
                                          state.extra as LeaveApplication)),
                            )
                          ]),
                    ]),
                StatefulShellBranch(
                    navigatorKey: _adminShellLeavesNavigatorKey,
                    routes: [
                      GoRoute(
                          name: Routes.adminLeaves,
                          path: Routes.adminLeaves,
                          pageBuilder: (context, state) {
                            return CupertinoPage(
                                key: ValueKey(_userManager.currentSpaceId),
                                child: const AdminLeavesPage());
                          },
                          routes: <GoRoute>[
                            GoRoute(
                              name: Routes.hrApplyLeave,
                              path: Routes.hrApplyLeave,
                              pageBuilder: (context, state) =>
                                  const CupertinoPage(
                                child: ApplyLeavePage(),
                              ),
                            ),
                            GoRoute(
                              name: Routes.adminLeaveDetails,
                              path: 'details',
                              pageBuilder: (context, state) => CupertinoPage(
                                  child: AdminLeaveDetailsPage(
                                      leaveApplication:
                                          state.extra as LeaveApplication)),
                            ),
                          ]),
                    ]),
                StatefulShellBranch(
                    navigatorKey: _adminShellEmployeeNavigatorKey,
                    routes: [
                      GoRoute(
                          name: Routes.adminMembers,
                          path: Routes.adminMembers,
                          pageBuilder: (context, state) => CupertinoPage(
                              key: ValueKey(_userManager.currentSpaceId),
                              child: const MemberListPage()),
                          routes: <GoRoute>[
                            GoRoute(
                                path: Routes.inviteMember,
                                name: Routes.inviteMember,
                                pageBuilder: (context, state) =>
                                    const CupertinoPage(
                                        child: InviteMemberPage())),
                            GoRoute(
                                name: Routes.adminMemberDetails,
                                path: Routes.adminMemberDetails,
                                pageBuilder: (context, state) {
                                  String id = '';
                                  if (state.extra.runtimeType == Employee) {
                                    final employee = state.extra as Employee;
                                    id = employee.uid;
                                  } else {
                                    id = state.extra as String;
                                  }
                                  return CupertinoPage(
                                      child: EmployeeDetailPage(id: id));
                                },
                                routes: [
                                  GoRoute(
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
                                                      leaveId:
                                                          state.pathParameters[
                                                              RoutesParamsConst
                                                                  .leaveId]!)),
                                        ),
                                      ],
                                      pageBuilder: (context, state) =>
                                          CupertinoPage(
                                              child:
                                                  AdminEmployeeDetailsLeavesPage(
                                            employeeName: state.pathParameters[
                                                    RoutesParamsConst
                                                        .employeeName] ??
                                                "",
                                            employeeId: state.extra as String,
                                          ))),
                                  GoRoute(
                                    //parentNavigatorKey: _adminShellNavigatorKey,
                                    path: Routes.adminEditEmployee,
                                    name: Routes.adminEditEmployee,
                                    pageBuilder: (context, state) =>
                                        CupertinoPage(
                                            child: AdminEditEmployeeDetailsPage(
                                      employee: state.extra as Employee,
                                    )),
                                  ),
                                ]),
                          ]),
                    ]),
              ]),
          StatefulShellRoute.indexedStack(
              builder: (context, state, child) => DashBoardScreen(
                  key: ValueKey(_userManager.currentSpaceId),
                  tabs: userTabs,
                  child: child),
              branches: [
                StatefulShellBranch(
                    navigatorKey: _employeeShellHomeNavigatorKey,
                    routes: [
                      GoRoute(
                          path: Routes.userHome,
                          name: Routes.userHome,
                          pageBuilder: (context, state) => CupertinoPage(
                              key: ValueKey(_userManager.currentSpaceId),
                              child: const UserHomeScreenPage()),
                          routes: <GoRoute>[
                            GoRoute(
                                name: Routes.userProfile,
                                path: 'profile',
                                pageBuilder: (context, state) =>
                                    const CupertinoPage(
                                      child: ViewProfilePage(),
                                    ),
                                routes: [
                                  GoRoute(
                                    path: 'edit',
                                    name: Routes.userEditProfile,
                                    pageBuilder: (context, state) =>
                                        CupertinoPage(
                                            child: EmployeeEditProfilePage(
                                      employee: _userManager.employee,
                                    )),
                                  ),
                                ]),
                            GoRoute(
                              // parentNavigatorKey: _employeeShellNavigatorKey,
                              name: Routes.userForms,
                              path: Routes.userForms,
                              pageBuilder: (context, state) =>
                                  const CupertinoPage(
                                      child: UserFormListPage()),
                            ),
                            GoRoute(
                                name: Routes.userRequestDetail,
                                path: Routes.userRequestDetail,
                                pageBuilder: (context, state) {
                                  return CupertinoPage(
                                      child: UserLeaveDetailPage(
                                          leaveId: state.pathParameters[
                                              RoutesParamsConst.leaveId]!));
                                }),
                            GoRoute(
                              name: Routes.userAbsenceDetails,
                              path: Routes.userAbsenceDetails,
                              pageBuilder: (context, state) => CupertinoPage(
                                  child: UserLeaveDetailPage(
                                      leaveId: state.pathParameters[
                                          RoutesParamsConst.leaveId]!)),
                            ),
                          ]),
                    ]),
                StatefulShellBranch(
                    navigatorKey: _employeeShellLeaveNavigatorKey,
                    routes: [
                      GoRoute(
                          path: Routes.userLeaves,
                          name: Routes.userLeaves,
                          pageBuilder: (context, state) => CupertinoPage(
                              key: ValueKey(_userManager.currentSpaceId),
                              child: const UserLeavePage()),
                          routes: <GoRoute>[
                            GoRoute(
                              name: Routes.applyLeave,
                              path: Routes.applyLeave,
                              pageBuilder: (context, state) =>
                                  const CupertinoPage(
                                child: ApplyLeavePage(),
                              ),
                            ),
                            GoRoute(
                              name: Routes.userLeaveDetail,
                              path: Routes.userLeaveDetail,
                              pageBuilder: (context, state) => CupertinoPage(
                                  child: UserLeaveDetailPage(
                                      leaveId: state.pathParameters[
                                          RoutesParamsConst.leaveId]!)),
                            ),
                          ]),
                    ]),
                StatefulShellBranch(
                    navigatorKey: _employeeShellEmployeeNavigatorKey,
                    routes: [
                      GoRoute(
                          path: Routes.userMembers,
                          name: Routes.userMembers,
                          pageBuilder: (context, state) => CupertinoPage(
                              key: ValueKey(_userManager.currentSpaceId),
                              child: const UserMembersPage()),
                          routes: <GoRoute>[
                            GoRoute(
                              name: Routes.userEmployeeDetail,
                              path: Routes.userEmployeeDetail,
                              pageBuilder: (context, state) => CupertinoPage(
                                  child: UserEmployeeDetailPage(
                                      employee: state.extra as Employee)),
                            ),
                          ]),
                    ])
              ])
        ],
        redirect: (context, GoRouterState state) {
          final location = state.matchedLocation;
          final loggingIn = location == Routes.login;
          final setupProfile = location == Routes.setupProfile;
          if (_userManager.state == UserState.unauthenticated) {
            return loggingIn || setupProfile ? null : Routes.login;
          }
          if (_userManager.state == UserState.authenticated &&
              !location.contains(Routes.joinSpace)) {
            return Routes.joinSpace;
          }
          if (_userManager.state == UserState.update ||
              (_userManager.state == UserState.spaceJoined &&
                  location.contains(Routes.joinSpace))) {
            return _userManager.isAdmin || _userManager.isHR
                ? Routes.adminHome
                : Routes.userHome;
          }
          return null;
        });
  }
}

extension GoRouterExtension on GoRouter {
  String location() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
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
  static const setupProfile = '/setup-profile';

  static const adminHome = '/admin/home';
  static const inviteMember = 'invite';
  static const adminAbsenceDetails = 'admin-calendar-leave-details';
  static const leaveRequestDetail = 'leave-request/details';
  static const adminProfile = '/admin-home/profile';

  static const newForm = '/admin-home/new-form';
  static const adminForms = '/admin-home/forms';

  static const adminEditProfile = "/admin-home/profile/edit";
  static const editSpaceDetails = 'edit-space';

  static const adminLeaves = '/admin/leaves';
  static const adminLeaveDetails = 'admin-leave-details';
  static const hrApplyLeave = 'hr/apply-leave';

  static const adminMembers = '/admin/members';
  static const adminMemberDetails = 'details';
  static const adminEmployeeDetailsLeaves = 'leaves/:employeeName';
  static const adminEmployeeDetailsLeavesDetails = 'leave-details/:leaveId';
  static const adminEditEmployee = 'edit-user-details';

  static const userHome = '/home';
  static const userAbsenceDetails = 'absence/details/:leaveId';
  static const userRequestDetail = 'leave-request-detail/:leaveId';
  static const userLeaveCalender = 'user-calender';
  static const userProfile = '/user-home/profile';
  static const userForms = 'forms';
  static const userEditProfile = '/user-home/profile/edit';

  static const userLeaves = '/leaves';
  static const userLeaveDetail = 'details/:leaveId';
  static const applyLeave = 'apply-leave';

  static const userMembers = '/members';
  static const userEmployeeDetail = 'employee-details/:employeeId';
}
