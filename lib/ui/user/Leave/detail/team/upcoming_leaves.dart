import 'package:flutter/cupertino.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/widget/leave_widget.dart';

class TeamUpcomingLeavesScreen extends StatelessWidget {
  List<Leave> leaveList;

  TeamUpcomingLeavesScreen({Key? key, required this.leaveList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (leaveList.isEmpty) {
      return const Center(
        child: Text('No any leave'),
      );
    }
    return LeaveWidget(leaveList: leaveList);
  }
}
