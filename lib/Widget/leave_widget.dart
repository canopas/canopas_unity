import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectunity/ViewModel/employee_detail_bloc.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/Employee/employee.dart';
import 'package:projectunity/model/Leave/leave.dart';
import 'package:projectunity/rest/api_response.dart';


class LeaveWidget extends StatelessWidget {
  final _bloc = getIt<EmployeeDetailBloc>();
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
        return StreamBuilder<ApiResponse<Employee>>(
            initialData: const ApiResponse.idle(),
            stream: _bloc.employeeDetail,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return snapshot.data.when(idle: () {
                return Container();
              }, loading: () {
                return const Center(child: CircularProgressIndicator());
              }, completed: (employee) {
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
                          Text('Employee: ${employee.name}',
                              style: const TextStyle(fontSize: 20)),
                          if (leave.status == 1)
                            const Text('Status: Pending',
                                style: TextStyle(fontSize: 20)),
                          if (leave.status == 2)
                            const Text('Status: Approved',
                                style: TextStyle(fontSize: 20)),
                          if (leave.status == 3)
                            const Text('Status: Rejected',
                                style: TextStyle(fontSize: 20)),
                        ]),
                  ),
                );
              }, error: (String error) {
                return Container();
              });
            });
      },
    );
  }
}