import 'package:flutter/material.dart';
import 'package:projectunity/di/service_locator.dart';

import '../provider/user_data.dart';
import 'navigationStackItem/admin/admin_navigation_stack_items.dart';
import 'navigationStackItem/employee/employee_navigation_stack_item.dart';
import 'navigationStackItem/navigationStack/navigation_stack_item.dart';
import 'navigation_stack_manager.dart';

class HomeRouterInfoParser
    extends RouteInformationParser<NavigationStackManager> {
  final _stackManager = getIt<NavigationStackManager>();
  final _userManager = getIt<UserManager>();

  @override
  Future<NavigationStackManager> parseRouteInformation(
      RouteInformation routeInformation) async {
    final items = await itemsForRouteInformation(routeInformation);
    _stackManager.setScreens = items;
    return _stackManager;
  }

  // @override
  // RouteInformation restoreRouteInformation(
  //     NavigationStackManager configuration) {
  //   final location =
  //       configuration.screens.fold<String>("", (previousValue, element) {
  //     return previousValue +
  //         element.when(
  //             adminHomeState: () => "/admin",
  //             employeeHomeState: () => "/home",
  //             leaveState: () => "/leave",
  //             settingsState: () => "/settings",
  //             employeeDetailState: (id) => "/employee/$id",
  //             userAllLeaveState: () => "/user-all-leave",
  //             userUpcomingLeaveState: () => "/user-upcoming-leave",
  //             leaveRequestState: () => "/leave-request",
  //             requestedLeaves: () => "/team-leave",
  //             addMemberState: () => "/add-member",
  //             adminLeaveRequestState: () => '/admin-leave-request');
  //   });
  //   return RouteInformation(location: location);
  // }

  Future<List<NavigationStackItem>> itemsForRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? "");
    final items = <NavigationStackItem>[];
    for (var i = 0, j = 1;
        i < uri.pathSegments.length && j < uri.pathSegments.length;
        i = i + 2, j = j + 2) {
      final key = uri.pathSegments[i];
      final value = uri.pathSegments[j];

      switch (key) {
        case "admin-home":
          items.add(const AdminNavigationStackItem.adminHomeState());
          break;
        case "employee-home":
          items.add(const EmployeeNavigationStackItem.employeeHomeState());
          break;
        case "employee":
          items.add(AdminNavigationStackItem.employeeDetailState(id: value));
          break;
        case "leave":
          items.add(const EmployeeNavigationStackItem.staffState());
          break;
        case "user-all-leave":
          items.add(const EmployeeNavigationStackItem.userAllLeaveState());
          break;
        case "user-upcoming-leave":
          items.add(const EmployeeNavigationStackItem.userUpcomingLeaveState());
          break;
        case "leave-request":
          items.add(const EmployeeNavigationStackItem.leaveRequestState());
          break;
        case "employee-settings":
          items.add(const EmployeeNavigationStackItem.employeeSettingsState());
          break;
        case "admin-settings":
          items.add(const AdminNavigationStackItem.adminSettingsState());
          break;
        case "admin-update-leave-count":
          items.add(const AdminNavigationStackItem.updateLeaveCountsState());
          break;
        case "team-leave":
          items.add(const EmployeeNavigationStackItem.requestedLeaves());
          break;
        case "add-member":
          items.add(const AdminNavigationStackItem.addMemberState());
          break;
        case "absence-employees":
          items.add(const AdminNavigationStackItem.adminLeaveAbsenceState());
          break;
        case 'admin-leave-request':
          items.add(AdminNavigationStackItem.adminLeaveRequestState());
          break;
        // case 'admin-leave-request-detail':
        //   items.add(AdminNavigationStackItem.adminLeaveRequestDetailState());
        //  break;
      }
    }

    if (items.isEmpty) {
      if (_userManager.isAdmin) {
        items.add(const AdminNavigationStackItem.adminHomeState());
      } else {
        items.add(const EmployeeNavigationStackItem.employeeHomeState());
      }
    }

    return items;
  }
}
