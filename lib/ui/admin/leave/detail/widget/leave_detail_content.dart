import 'package:flutter/material.dart';
import 'package:projectunity/core/utils/date_string_utils.dart';

import '../../../../../model/leave/leave.dart';
import '../../../../../widget/leave_detail.dart';

class LeaveDetailContent extends StatelessWidget {
  Leave leave;

  LeaveDetailContent({Key? key, required this.leave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String totalDays = totalLeaves(leave.totalLeaves);
    String duration = dateInSingleLine(
        startTimeStamp: leave.startDate, endTimeStamp: leave.endDate);
    String reason = leave.reason;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildFieldColumn(title: 'Total Days', value: totalDays),
          buildDivider(),
          buildFieldColumn(title: 'Duration', value: duration),
          buildDivider(),
          buildFieldColumn(
            title: 'Reason',
            value: reason,
          ),
        ],
      ),
    );
  }


}
