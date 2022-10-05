import 'package:flutter/material.dart';
import 'package:projectunity/core/utils/const/leave_screen_type_map.dart';

import '../leaveScreen/leave_screen.dart';

class AllLeaveScreen extends StatefulWidget {
  const AllLeaveScreen({Key? key}) : super(key: key);

  @override
  State<AllLeaveScreen> createState() => _AllLeaveScreenState();
}

class _AllLeaveScreenState extends State<AllLeaveScreen> {
  @override
  Widget build(BuildContext context) {
    return const LeaveScreen(
      leaveScreenType: allLeaves,
    );
  }
}
