import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/ui/OnBoardScreen/onboard_screen.dart';
import 'package:projectunity/ui/User/Leave/LeaveRequestForm/leave_request_form.dart';
import 'package:projectunity/ui/User/home_screen.dart';
import 'package:projectunity/ui/login/login_screen.dart';

import 'Navigation/login_state.dart';
import 'di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configureDependencies();
  runApp(const MaterialApp(
    title: 'ProjectUnity Flutter',
    // home: MyApp(),
    home: LeaveRequestForm(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _loginState = getIt<LoginState>();
  late bool isLogin;
  late bool isOnBoardComplete;

  @override
  void initState() {
    isLogin = _loginState.isLogin;
    isOnBoardComplete = _loginState.onBoardComplete;
    _loginState.addListener(() {
      setState(() {
        isLogin = _loginState.isLogin;
        isOnBoardComplete = _loginState.onBoardComplete;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
        pages: [
          if (!isOnBoardComplete) const MaterialPage(child: OnBoardScreen()),
          if (isOnBoardComplete && !isLogin)
            const MaterialPage(child: LoginScreen()),
          if (isOnBoardComplete && isLogin)
            const MaterialPage(child: HomeScreen()),
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }
          return true;
        });
  }
}
