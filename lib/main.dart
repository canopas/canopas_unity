import 'package:flutter/material.dart';
import 'package:projectunity/ui/OnBoardScreen/onboard_screen.dart';
import 'package:projectunity/ui/User/Leave/leave_screen.dart';
import 'package:projectunity/ui/User/home_screen.dart';
import 'package:projectunity/ui/User/setting_screen.dart';
import 'package:projectunity/ui/login/login_screen.dart';
import 'package:projectunity/user/user_manager.dart';

import 'di/service_locator.dart';
import 'model/Employee/employee.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(MaterialApp(
    title: 'ProjectUnity Flutter',
    home: OnBoardScreen(),
    routes: {
      '/loginScreen': (context) => const LoginScreen(),
      '/homeScreen': (context) => const HomeScreen(),
      '/leaveScreen': (context) => const LeaveScreen(),
      '/settingScreen': (context) => const SettingScreen(),
    },
  ));
}

class MyApp extends StatelessWidget {
  final UserManager _userManager = getIt<UserManager>();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Employee? user = _userManager.getEmployee();
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, '/loginScreen');
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, '/homeScreen');
      });
    }
    return Container();
  }
}
