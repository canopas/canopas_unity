import 'package:flutter/material.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/root_screen.dart';
import 'package:projectunity/ui/User/home_screen.dart';
import 'package:projectunity/ui/User/Leave/leave_screen.dart';
import 'package:projectunity/ui/User/setting_screen.dart';
import 'package:projectunity/ui/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(
    MaterialApp(
      title: 'ProjectUnity flutter',
      routes: {
        '/rootScreen':(context)=>const RootScreen(),
        '/loginScreen': (context) => const LoginScreen(),
        '/homeScreen': (context) => const HomeScreen(),
        '/leaveScreen': (context) => const LeaveScreen(),
        '/settingScreen': (context) =>const SettingScreen(),
      },
      initialRoute: '/rootScreen',
    ),
  );
}
