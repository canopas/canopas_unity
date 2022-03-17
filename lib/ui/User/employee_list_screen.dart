import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:projectunity/ViewModel/api_response.dart';
import 'package:projectunity/ViewModel/employee_list_bloc.dart';
import 'package:projectunity/Widget/employee_widget.dart';
import 'package:projectunity/Widget/error_banner.dart';
import 'package:projectunity/model/employee.dart';
import 'package:projectunity/utils/service_locator.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final _bloc = getIt<EmployeeListBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.getEmployeeList();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.account_circle_rounded,
                  size: 50,
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  iconSize: 30,
                  onPressed: () {},
                )
              ],
            ),
            const Expanded(
              child: Text(
                'Hi,Sneha Sanghani',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal),
              ),
            ),
            const Expanded(
              child: Text(
                  'Know your colleague,find their contact information and get in touch with him/her ',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 20)),
            ),
            Expanded(
              flex: 8,
              child: StreamBuilder<ApiResponse<List<Employee>>>(
                  stream: _bloc.allEmployee,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    //      try {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.completed:
                          return EmployeeListWidget(
                            employeeList: snapshot.data.data,
                          );

                        case Status.loading:
                          return const CircularProgressIndicator();

                        case Status.error:
                          SchedulerBinding.instance?.addPostFrameCallback((_) =>
                              showErrorBanner(
                                  snapshot.data.error.toString(), context));
                          return Container();
                      }
                    } else if (snapshot.hasError) {
                      SchedulerBinding.instance?.addPostFrameCallback((_) =>
                          showErrorBanner(snapshot.error.toString(), context));
                      return Container();
                    }
                    return Container();
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
