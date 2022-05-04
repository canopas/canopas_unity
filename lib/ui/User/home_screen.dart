import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/Navigation%20/app_state.dart';
import 'package:projectunity/ui/User/Employee/employee_detail_screen.dart';
import 'package:projectunity/ui/User/Employee/employee_list_screen.dart';
import 'package:projectunity/ui/User/Leave/leave_request_form.dart' as ui;
import 'package:projectunity/ui/User/setting_screen.dart';

import 'Leave/leave_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TabState _state = TabState();
  late AppState _appState;
  late int index;

  @override
  void initState() {
    index = _state.selectedIndex;
    _appState = _state.state;
    _state.addListener(() {
      setState(() {
        index = _state.selectedIndex;
        _appState = _state.state;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: _state.updateTabIndex,
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
        pages: [
          _appState.when(
            home: () => const MaterialPage(child: EmployeeListScreen()),
            employeeDetail: (index) =>
                MaterialPage(child: EmployeeDetailScreen(id: index)),
            leave: () => const MaterialPage(child: LeaveScreen()),
            leaveRequestForm: () =>
                const MaterialPage(child: ui.LeaveRequestForm()),
            setting: () => const MaterialPage(child: SettingScreen()),
          )
        ],
        onPopPage: (route, result) {
          if (route.didPop(result)) return false;
          return true;
        },
      ),
    );
  }
}

class TabState extends ChangeNotifier {
  AppState _state = const AppState.home();

  AppState get state => _state;
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateTabIndex(int index) {
    _selectedIndex = index;
    switch (_selectedIndex) {
      case 0:
        _state = const AppState.home();
        break;
      case 1:
        _state = const AppState.leave();
        break;
      case 2:
        _state = const AppState.setting();
        break;
    }

    notifyListeners();
  }
}
