import 'package:flutter/material.dart';
import 'package:projectunity/ui/User/employee_list_screen.dart';
import 'package:projectunity/ui/User/setting_screen.dart';
import 'leave_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> screenList = [
    EmployeeListScreen(),
    LeaveScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_box_rounded), label: 'Leave'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.nine_mp_sharp), label: 'Setting'),
              ],
              currentIndex: selectedIndex,
              backgroundColor: Colors.blueGrey,
              selectedItemColor: Colors.white54,
              selectedFontSize: 20,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
            body: screenList.elementAt(selectedIndex),
          )),
    ));
  }
}
