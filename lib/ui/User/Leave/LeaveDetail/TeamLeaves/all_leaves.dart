import 'package:flutter/cupertino.dart';
import 'package:projectunity/Widget/leave_widget.dart';
import 'package:projectunity/model/Leave/leave.dart';

class TeamAllLeavesScreen extends StatelessWidget {
  List<Leave> allLeavesList;

  TeamAllLeavesScreen({Key? key, required this.allLeavesList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LeaveWidget(leaveList: allLeavesList);
  }
}
