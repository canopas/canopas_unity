import 'package:flutter/cupertino.dart';
import 'package:projectunity/Widget/leave_widget.dart';
import 'package:projectunity/model/Leave/leave.dart';

class TeamAllLeavesScreen extends StatelessWidget {
  List<Leave> leaveList;

  TeamAllLeavesScreen({Key? key, required this.leaveList}) : super(key: key);

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
