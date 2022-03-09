import 'package:flutter/material.dart';
import 'package:projectunity/ui/User/root_screen.dart';
import 'package:projectunity/utils/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();
  runApp(const MaterialApp(
    title: 'ProjectUnity flutter',
    home: RootScreen(),
  ));
}
