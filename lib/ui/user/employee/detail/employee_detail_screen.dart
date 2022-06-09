import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/widget/app_circular_indicator.dart';

import '../../../../configs/colors.dart';
import '../../../../di/service_locator.dart';
import '../../../../model/employee/employee.dart';
import '../../../../rest/api_response.dart';
import '../../../../viewmodel/employee_detail_bloc.dart';
import '../../../../widget/error_banner.dart';
import 'widget/profile_card.dart';
import 'widget/profile_detail.dart';

class EmployeeDetailScreen extends StatefulWidget {
  const EmployeeDetailScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  final _bloc = getIt<EmployeeDetailBloc>();
  final _navigationStackManager = getIt<NavigationStackManager>();

  @override
  void initState() {
    super.initState();
    _bloc.getEmployeeDetailByID(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => _navigationStackManager.pop(),
          icon: const Icon(FontAwesomeIcons.angleLeft, color: Colors.black),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.creamColor,
      ),
      body: StreamBuilder<ApiResponse<Employee>>(
        stream: _bloc.employeeDetail,
        initialData: const ApiResponse.loading(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.data?.when(idle: () {
            return Container();
          }, loading: () {
            return const AppCircularIndicator();
          }, completed: (Employee employee) {
            return SingleChildScrollView(
              child: Column(children: [
                SizedBox(height: 400, child: ProfileCard(employee: employee)),
                ProfileDetail(employee: employee),
              ]),
            );
          }, error: (String error) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              showErrorBanner(error, context);
            });
            return Container();
          });
        },
      ),
    );
  }
}
