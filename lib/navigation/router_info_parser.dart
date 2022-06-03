import 'package:flutter/material.dart';

import 'navigation_stack_item.dart';
import 'navigation_stack_manager.dart';

class HomeRouterInfoParser
    extends RouteInformationParser<NavigationStackManager> {
  @override
  Future<NavigationStackManager> parseRouteInformation(
      RouteInformation routeInformation) async {
    final items = await itemsForRouteInformation(routeInformation);
    final stackManager = NavigationStackManager();
    stackManager.screens = items;
    return stackManager;
  }

  @override
  RouteInformation restoreRouteInformation(
      NavigationStackManager configuration) {
    final location =
        configuration.screens.fold<String>("", (previousValue, element) {
      return previousValue +
          element.when(
              homeState: () => "/home",
              leaveState: () => "/leave",
              settingsState: () => "/settings",
              employeeDetailState: (id) => "/employee/$id",
              userAllLeaveState: () => "/user-all-leave",
              userUpcomingLeaveState: () => "/user-upcoming-leave",
              leaveRequestState: () => "/leave-request",
              teamLeavesState: () => "/team-leave");
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
        default:
          items.add(const NavigationStackItem.homeState());
      }
    }

    if (items.isEmpty) {
      items.add(const NavigationStackItem.homeState());
    }

    return items;
  }
}
