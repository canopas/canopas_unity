import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/Navigation%20/app_state_manager.dart';
import 'package:projectunity/ui/User/Employee/employee_detail_screen.dart';
import 'package:projectunity/ui/User/Employee/employee_list_screen.dart';
import 'package:projectunity/ui/User/setting_screen.dart';

import 'Leave/leave_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AppState> appState = List.filled(10, AppState.home, growable: true);

  int index = 0;

  AppStateManager appStateManager = AppStateManager();
  late int selectedEmployee;

  @override
  void initState() {
    selectedEmployee = appStateManager.selectedEmployeeId;
    appStateManager.addListener(() {
      setState(() {
        selectedEmployee = appStateManager.selectedEmployeeId;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: onClick,
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
        pages: appState.map((e) {
          switch (e) {
            case AppState.home:
              return MaterialPage(child: EmployeeListScreen(ontap: () {
                setState(() {
                  appState.add(AppState.employeeDetail);
                });
              }));
            case AppState.employeeDetail:
              return MaterialPage(
                  child: EmployeeDetailScreen(
                id: selectedEmployee,
              ));
            case AppState.leave:
              return const MaterialPage(child: LeaveScreen());
            case AppState.setting:
              return const MaterialPage(child: SettingScreen());
            default:
              return const MaterialPage(child: HomeScreen());
          }
        }).toList(),
        onPopPage: (route, result) {
          appState.clear();
          if (route.didPop(result)) return false;
          return true;
        },
      ),
    );
  }

  void onClick(selectedIndex) {
    setState(() {
      index = selectedIndex;
      if (index == 0) {
        appState.add(AppState.home);
      } else if (index == 1) {
        appState.add(AppState.leave);
      } else {
        appState.add(AppState.setting);
      }
    });
  }
}

enum AppState { home, leave, setting, employeeDetail, allLeavesUserScreen }
//
// class TabState extends ChangeNotifier {
//   AppState _state = const AppState.home();
//   AppState get state => _state;
//   int _selectedIndex = 0;
//   int get selectedIndex => _selectedIndex;
//
//   int? _selectedEmployeeId ;
//   int? get selectedEmployeeId=>_selectedEmployeeId;
//
//   void updateTabIndex(int index) {
//     _selectedIndex = index;
//     switch (_selectedIndex) {
//       case 0:
//         _state = const AppState.home();
//
//         break;
//       case 1:
//         _state = const AppState.leave();
//         break;
//       case 2:
//         _state = const AppState.setting();
//         break;
//     }
//     notifyListeners();
//   }
//
// }
