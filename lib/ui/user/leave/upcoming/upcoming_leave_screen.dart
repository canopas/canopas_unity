import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/core/utils/const/leave_screen_type_map.dart';

import '../leaveScreen/leave_screen.dart';

class UpComingLeaveScreen extends StatefulWidget {
  const UpComingLeaveScreen({Key? key}) : super(key: key);

  @override
  State<UpComingLeaveScreen> createState() => _UpComingLeaveScreenState();
}

class _UpComingLeaveScreenState extends State<UpComingLeaveScreen> {
  @override
  Widget build(BuildContext context) {
    return const LeaveScreen(
      leaveScreenType: upcomingLeave,
    );
  }
}
