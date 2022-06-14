import 'package:flutter/material.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/user/user_manager.dart';

import 'navigation_stack_item.dart';
import 'navigation_stack_manager.dart';

class HomeRouterInfoParser
    extends RouteInformationParser<NavigationStackManager> {
  final _stackManager = getIt<NavigationStackManager>();
  final _userManager = getIt<UserManager>();

  @override
  Future<NavigationStackManager> parseRouteInformation(
      RouteInformation routeInformation) async {
    final items = await itemsForRouteInformation(routeInformation);
    _stackManager.screens = items;
    return _stackManager;
  }

  @override
  RouteInformation restoreRouteInformation(
      NavigationStackManager configuration) {
    final location =
        configuration.screens.fold<String>("", (previousValue, element) {
      return previousValue +
          element.when(
              adminHomeState: () => "/admin",
              homeState: () => "/home",
              leaveState: () => "/leave",
              settingsState: () => "/settings",
              employeeDetailState: (id) => "/employee/$id",
              userAllLeaveState: () => "/user-all-leave",
              userUpcomingLeaveState: () => "/user-upcoming-leave",
              leaveRequestState: () => "/leave-request",
              teamLeavesState: () => "/team-leave",
              addMemberState: () => "/add-member");
    });
    return RouteInformation(location: location);
  }

  Future<List<NavigationStackItem>> itemsForRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? "");
    final items = <NavigationStackItem>[];
    for (var i = 0, j = 1;
        i < uri.pathSegments.length && j < uri.pathSegments.length;
        i = i + 2, j = j + 2) {
      final key = uri.pathSegments[i];
      final value = uri.pathSegments[j];

      print("Key $key value $value uri $uri");
      switch (key) {
        case "admin":
          items.add(const NavigationStackItem.adminHomeState());
          break;
        case "home":
          items.add(const NavigationStackItem.homeState());
          break;
        case "employee":
          items.add(NavigationStackItem.employeeDetailState(id: value));
          break;
        case "leave":
          items.add(const NavigationStackItem.leaveState());
          break;
        case "user-all-leave":
          items.add(const NavigationStackItem.userAllLeaveState());
          break;
        case "user-upcoming-leave":
          items.add(const NavigationStackItem.userUpcomingLeaveState());
          break;
        case "leave-request":
          items.add(const NavigationStackItem.leaveRequestState());
          break;
        case "settings":
          items.add(const NavigationStackItem.settingsState());
          break;
        case "team-leave":
          items.add(const NavigationStackItem.teamLeavesState());
          break;
        case "add-member":
          items.add(const NavigationStackItem.addMemberState());
          break;
        default:
          items.add(const NavigationStackItem.homeState());
      }
    }

    if (items.isEmpty) {
      if (_userManager.isAdmin()) {
        items.add(const NavigationStackItem.adminHomeState());
      } else {
        items.add(const NavigationStackItem.homeState());
      }
    }

    return items;
  }
}
