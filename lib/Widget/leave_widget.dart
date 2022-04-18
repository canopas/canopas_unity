import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectunity/ViewModel/employee_detail_bloc.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/Employee/employee.dart';
import 'package:projectunity/model/Leave/leave.dart';
import 'package:projectunity/rest/api_response.dart';

class LeaveWidget extends StatefulWidget {
  Leave leave;

  LeaveWidget({Key? key, required this.leave}) : super(key: key);

  @override
  _LeaveWidgetState createState() => _LeaveWidgetState();
}

class _LeaveWidgetState extends State<LeaveWidget> {
  final _bloc = getIt<EmployeeDetailBloc>();
  late Leave _leave;

  @override
  void initState() {
    super.initState();
    _leave = widget.leave;
    _bloc.getEmployeeDetailByID(_leave.emergencyContactPerson);
  }

  @override
  Widget build(BuildContext context) {
    DateTime formattedStartDate =
        DateTime.fromMicrosecondsSinceEpoch(_leave.startDate);
    DateTime formattedEndDate =
        DateTime.fromMicrosecondsSinceEpoch(_leave.endDate);
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
          }, completed: (Employee employee) {
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
                      Text('Total Leaves: ${_leave.totalLeaves}',
                          style: const TextStyle(fontSize: 20)),
                      Text('Reason: ${_leave.reason}',
                          style: const TextStyle(fontSize: 20)),
                      Text('Employee: ${employee.name}',
                          style: const TextStyle(fontSize: 20)),
                      if (_leave.status == 1)
                        const Text('Status: Pending',
                            style: TextStyle(fontSize: 20)),
                      if (_leave.status == 2)
                        const Text('Status: Approved',
                            style: TextStyle(fontSize: 20)),
                      if (_leave.status == 3)
                        const Text('Status: Rejected',
                            style: TextStyle(fontSize: 20)),
                    ]),
              ),
            );
          }, error: (String error) {
            return Container();
          });
        });
  }
}
