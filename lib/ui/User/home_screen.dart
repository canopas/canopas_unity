import 'package:flutter/material.dart';
import 'package:projectunity/Navigation%20/app_state_manager.dart';
import 'package:projectunity/ui/User/setting_screen.dart';
import 'package:projectunity/utils/Constant/color_constant.dart';

import '../../Navigation /app_state.dart';
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
  int selectedTab = 0;
  late List<AppState> stateList;

  @override
  void initState() {
    stateList = _stateManager.screens;
    _stateManager.addListener(() {
      setState(() {
        stateList = _stateManager.screens;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(kSecondaryColor),
        selectedItemColor: const Color(selectedTabColor),
        unselectedItemColor: const Color(kPrimaryColour),
        selectedFontSize: 15,
        currentIndex: selectedTab,
        onTap: _ontap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range_rounded),
            label: 'Leave',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts_rounded),
            label: 'Settings',
          ),
        ],
      ),
      body: EmployeeListScreen(),
      // body: Navigator(
      //     pages: _buildPages(),
      //     onPopPage: (route, result) {
      //       if (!route.didPop(result)) {
      //         return false;
      //       }
      //       _stateManager.pop();
      //       return true;
      //     }),
    );
  }

  void _ontap(int id) {
    setState(() {
      selectedTab = id;
    });
    _stateManager.push(selectedTab);
  }

  List<Page> _buildPages() {
    List<Page> list = stateList
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
              settingsState: () => const MaterialPage(child: SettingScreen()),
              teamLeavesState: () =>
                  const MaterialPage(child: TeamLeavesScreen()),
            ))
        .toList(growable: true);
    return list;
  }
}
