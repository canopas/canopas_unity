import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectunity/model/leave/leave.dart';

class LeaveWidget extends StatelessWidget {
  List<Leave> leaveList;

  LeaveWidget({Key? key, required this.leaveList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: leaveList.length,
      itemBuilder: (BuildContext context, int index) {
        Leave leave = leaveList[index];
        DateTime formattedStartDate =
            DateTime.fromMicrosecondsSinceEpoch(leave.startDate);
        DateTime formattedEndDate =
            DateTime.fromMicrosecondsSinceEpoch(leave.endDate);
        String startDate = DateFormat.yMMMd().format(formattedStartDate);
        String endDate = DateFormat.yMMMd().format(formattedEndDate);

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Start date: $startDate',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text('End Date: $endDate',
                      style: const TextStyle(fontSize: 20)),
                  Text('Total Leaves: ${leave.totalLeaves}',
                      style: const TextStyle(fontSize: 20)),
                  Text('Reason: ${leave.reason}',
                      style: const TextStyle(fontSize: 20)),
                ]),
          ),
        );
      },
    );
  }
}
