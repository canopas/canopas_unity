import 'package:flutter/material.dart';
import 'package:projectunity/bloc/leaves/user/leaves/all_leaves_bloc.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';

import '../leaveScreen/leave_screen.dart';

class AllLeaveScreen extends StatefulWidget {
  AllLeaveScreen({Key? key}) : super(key: key);

  @override
  State<AllLeaveScreen> createState() => _AllLeaveScreenState();
}

class _AllLeaveScreenState extends State<AllLeaveScreen> {
  final _stateManager = getIt<NavigationStackManager>();
  final _userAllLeavesBloc = getIt<UserAllLeavesBloc>();

  @override
  void initState() {
    _userAllLeavesBloc.getAllLeaves();
  }

  @override
  Widget build(BuildContext context) {
    return LeaveScreen(
      leaveStream: _userAllLeavesBloc.allLeaves,
      header: 'All Leaves',
    );
  }
}
