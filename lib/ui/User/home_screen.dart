import 'package:flutter/material.dart';
import 'package:projectunity/Navigation%20/app_state_manager.dart';
import 'package:projectunity/ui/User/setting_screen.dart';

import '../../di/service_locator.dart';
import 'Employee/employee_detail_screen.dart';
import 'Employee/employee_list_screen.dart';
import 'Leave/LeaveDetail/LoggedInUser/all_leaves.dart';
import 'Leave/LeaveDetail/LoggedInUser/upcoming_leaves.dart';
import 'Leave/LeaveDetail/team_leaves.dart';
import 'Leave/leave_request_form.dart';
import 'Leave/leave_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _stateManager = getIt<AppStateManager>();
  late int selectedTab;

  @override
  void initState() {
    selectedTab = _stateManager.selectedBottomIndex;
    _stateManager.addListener(() {
      setState(() {
        selectedTab = _stateManager.selectedBottomIndex;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,
        onTap: _stateManager.push,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: 'Leave',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.nine_mp_sharp),
            label: 'Setting',
          ),
        ],
      ),
      body: Navigator(
          pages: _stateManager.screens
              .map((state) => state.when(
                    homeState: () {
                      return const MaterialPage(child: EmployeeListScreen());
                    },
                    employeeDetailState: (int selectedEmployee) {
                      return MaterialPage(
                          child: EmployeeDetailScreen(
                        id: selectedEmployee,
                      ));
                    },
                    leaveState: () {
                      return MaterialPage(child: LeaveScreen());
                    },
                    userAllLeaveState: () =>
                        const MaterialPage(child: AllLeavesUserScreen()),
                    userUpcomingLeaveState: () =>
                        const MaterialPage(child: UpComingLeavesUserScreen()),
                    leaveRequestState: () =>
                        const MaterialPage(child: LeaveRequestForm()),
                    settingsState: () =>
                        const MaterialPage(child: SettingScreen()),
                    teamLeavesState: () =>
                        const MaterialPage(child: TeamLeavesScreen()),
                  ))
              .toList(growable: true),
          onPopPage: (route, result) {
            if (!route.didPop(result)) {
              return false;
            }
            _stateManager.pop();
            return true;
          }),
    );
  }
}
