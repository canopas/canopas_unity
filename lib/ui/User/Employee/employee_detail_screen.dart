import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:projectunity/ViewModel/employee_detail_bloc.dart';
import 'package:projectunity/Widget/error_banner.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/Employee/employee.dart';
import 'package:projectunity/rest/api_response.dart';

class EmployeeDetailScreen extends StatefulWidget {
  const EmployeeDetailScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  _EmployeeDetailScreenState createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  final _bloc = getIt<EmployeeDetailBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.getEmployeeDetailByID(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: StreamBuilder<ApiResponse<Employee>>(
        stream: _bloc.employeeDetail,
        initialData: const ApiResponse.loading(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.data?.when(idle: () {
            return Container();
          }, loading: () {
            return const Center(child: CircularProgressIndicator());
          }, completed: (Employee employee) {
            return EmployeeDetailWidget(
              employee: employee,
            );
          }, error: (String error) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              showErrorBanner(error, context);
            });
            return Container();
          });
        },
      ),
    ));
  }
}

class EmployeeDetailWidget extends StatelessWidget {
  const EmployeeDetailWidget({Key? key, required this.employee})
      : super(key: key);

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(employee.imageUrl ??
                        'https://media.istockphoto.com/vectors/simple-man-head-icon-set-vector-id1196083861?k=20&m=1196083861&s=612x612&w=0&h=XNRxC4ohwTlL7KBis1Dc_MZASQSKfC9IoBfe2Oq9eL0='),
                    radius: 100,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    employee.name ?? '',
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                  Text(employee.designation ?? '',
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey)),
                  const Divider(
                    color: Colors.black,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Personal Information:',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TitleWidget(text: 'Phone Number: '),
                            DataWidget(
                              text: employee.phone ?? '',
                            ),
                            const TitleWidget(text: 'Date of birth: '),
                            DataWidget(
                              text: employee.dateOfBirth.toString(),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            const TitleWidget(text: 'Email: '),
                            DataWidget(
                              text: employee.email,
                            ),
                            const TitleWidget(text: 'Address: '),
                            DataWidget(
                              text: employee.address ?? '',
                            )
                          ]))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Job Information:',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TitleWidget(text: 'EmployeeID: '),
                            DataWidget(
                              text: employee.employeeId.toString(),
                            ),
                            const TitleWidget(text: 'Date of joining: '),
                            DataWidget(
                              text: employee.dateOfJoining.toString(),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            const TitleWidget(text: 'Status: '),
                            DataWidget(
                              text: employee.status.toString(),
                            ),
                            const TitleWidget(text: 'Level: '),
                            DataWidget(text: employee.level ?? ''),
                          ]))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DataWidget extends StatelessWidget {
  const DataWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey, fontSize: 20),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final String text;

  const TitleWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20),
    );
  }
}
