import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/ui/User/employee_list_screen.dart';
import 'package:projectunity/ui/User/setting_screen.dart';
import 'Leave/leave_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> _screenList = [
    const EmployeeListScreen(),
    LeaveScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return  CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          iconSize: 30,
          activeColor: Colors.blueGrey,
          inactiveColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onTabTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home',style: TextStyle(fontSize: 15),)),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box_rounded), title: Text('Leave',style: TextStyle(fontSize: 15),)),
            BottomNavigationBarItem(
                icon: Icon(Icons.nine_mp_sharp), title: Text('Setting',style: TextStyle(fontSize: 15),)),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (context) {
              return CupertinoApp(
                home: CupertinoPageScaffold(
                  child: _screenList.elementAt(index),
                ),
              );
            },
          );
        },
      );
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
