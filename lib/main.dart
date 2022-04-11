import 'package:flutter/material.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/Employee/employee.dart';
import 'package:projectunity/ui/User/home_screen.dart';
import 'package:projectunity/ui/login/login_screen.dart';
import 'package:projectunity/user/user_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MaterialApp(
    title: 'ProjectUnity Flutter',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserManager userManager = getIt<UserManager>();
  Employee? user;

  @override
  void initState() {
    super.initState();
    user = userManager.employee;
    print(user.toString());
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    } else {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      });
    }
    return Container();
  }
}
