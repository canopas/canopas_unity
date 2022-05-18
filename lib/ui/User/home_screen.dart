import 'package:flutter/material.dart';
import 'package:projectunity/Navigation%20/app_state_manager.dart';

import '../../di/service_locator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _stateManager = getIt<AppStateManager>();
  late int selectedTab;

  @override
  void initState() {
    selectedTab = _stateManager.selectedBottomIndex;
    _stateManager.addListener(() {
      setState(() {
        selectedTab = _stateManager.selectedBottomIndex;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,
        onTap: _stateManager.push,
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
          pages: _stateManager.buildPages(),
          onPopPage: (route, result) {
            if (!route.didPop(result)) {
              return false;
            }
            _stateManager.pop();
            return true;
          }),
    );
  }
}
