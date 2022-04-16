import 'package:flutter/material.dart';
import 'package:projectunity/model/Leave/leave.dart';

class LeaveWidget extends StatelessWidget {
  final List<Leave> leaveList;

  const LeaveWidget({Key? key, required this.leaveList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (leaveList.isEmpty) {
      return const Center(child: Text('No any Leave '));
    }
    return ListView.builder(
        itemCount: leaveList.length,
        itemBuilder: (context, index) {
          Leave leave = leaveList[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Start date: ${leave.startDate}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text('End Date: ${leave.endDate}',
                        style: const TextStyle(fontSize: 20)),
                    Text('Total Leaves: ${leave.totalLeaves}',
                        style: const TextStyle(fontSize: 20)),
                    Text('Reason: ${leave.reason}',
                        style: const TextStyle(fontSize: 20)),
                    Text('Proxy: ${leave.emergencyContactPerson}',
                        style: const TextStyle(fontSize: 20)),
                    Text('Status: ${leave.status} ',
                        style: const TextStyle(fontSize: 20))
                  ]),
            ),
          );
        });
  }
}
