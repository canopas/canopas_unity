import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:projectunity/ViewModel/api_response.dart';
import 'package:projectunity/ViewModel/employee_list_bloc.dart';
import 'package:projectunity/Widget/employee_widget.dart';
import 'package:projectunity/Widget/error_banner.dart';
import 'package:projectunity/model/employee.dart';
import 'package:projectunity/user/user_manager.dart';
import '../../di/service_locator.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final _bloc = getIt<EmployeeListBloc>();
  final _userManager = getIt<UserManager>();

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
                _userManager.getUserImage() == null
                    ? const Icon(
                        Icons.account_circle_rounded,
                        size: 50,
                      )
                    : ImageIcon(
                        NetworkImage(_userManager.getUserImage()!),
                        size: 50,
                      ),
                IconButton(
                  icon: const Icon(Icons.search),
                  iconSize: 30,
                  onPressed: () {},
                )
              ],
            ),
            Expanded(
              child: Text(
                _userManager.getUserName() ?? '',
                style: const TextStyle(
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
                    return snapshot.data!.when(idle: () {
                      return;
                    }, loading: () {
                      return const Center(child: CircularProgressIndicator());
                    }, completed: (List<Employee> list) {
                      return EmployeeListWidget(employeeList: list);
                    }, error: (String error) {
                      return Text(error);
                    });
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
