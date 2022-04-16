import 'package:flutter/cupertino.dart';
import 'package:projectunity/Widget/leave_widget.dart';
import 'package:projectunity/model/Leave/leave.dart';

class TeamUpcomingLeavesScreen extends StatelessWidget {
  List<Leave> upcomingLeavesList;

  TeamUpcomingLeavesScreen({Key? key, required this.upcomingLeavesList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LeaveWidget(leaveList: upcomingLeavesList);
  }
}
