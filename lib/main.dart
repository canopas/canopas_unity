import 'package:flutter/material.dart';
import 'package:projectunity/ui/OnBoardScreen/onboard_screen.dart';
import 'package:projectunity/Navigation%20/login_state.dart';
import 'package:projectunity/ui/User/home_screen.dart';
import 'package:projectunity/ui/login/login_screen.dart';

import 'di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MaterialApp(
    title: 'ProjectUnity Flutter',
    home: OnBoardScreen(),
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

  @override
  void initState() {
    isLogin = _loginState.isLogin;
    _loginState.addListener(() {
      setState(() {
        isLogin = _loginState.isLogin;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        isLogin
            ? const MaterialPage(child: HomeScreen())
            : const MaterialPage(child: LoginScreen()),
      ],
      onPopPage: (route, result) {
        if (route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }
}
