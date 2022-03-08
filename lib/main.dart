import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:projectunity/utils/service_locator.dart';
import 'package:projectunity/ui/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();

    runApp(const MaterialApp(
      title: 'ProjectUnity flutter',
      home: LoginScreen(),
    ));

}
