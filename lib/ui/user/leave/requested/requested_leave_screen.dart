import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/core/utils/const/leave_screen_type_map.dart';

import '../leaveScreen/leave_screen.dart';

class RequestedLeaveScreen extends StatefulWidget {
  const RequestedLeaveScreen({Key? key}) : super(key: key);

  @override
  State<RequestedLeaveScreen> createState() => _RequestedLeaveScreenState();
}

class _RequestedLeaveScreenState extends State<RequestedLeaveScreen> {
  @override
  Widget build(BuildContext context) {
    return const LeaveScreen(
      leaveScreenType: requestedLeave,
    );
  }
}
