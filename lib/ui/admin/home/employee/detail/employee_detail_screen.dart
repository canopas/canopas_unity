import 'package:flutter/material.dart';
import 'package:projectunity/ui/admin/home/employee/detail/widget/delete_button.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snackbar.dart';

import '../../../../../bloc/admin/employee/employee_detail_bloc.dart';
import '../../../../../di/service_locator.dart';
import '../../../../../model/employee/employee.dart';
import '../../../../../rest/api_response.dart';
import 'widget/profile_card.dart';
import 'widget/profile_detail.dart';

class EmployeeDetailScreen extends StatefulWidget {
  final String id;

  const EmployeeDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  final _bloc = getIt<EmployeeDetailBloc>();

  @override
  void initState() {
    _bloc.getEmployeeDetailByID(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: StreamBuilder<ApiResponse<Employee>>(
        stream: _bloc.employeeDetail,
        initialData: const ApiResponse.idle(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.data!.when(
              idle: () => Container(),
              loading: () => const kCircularProgressIndicator(),
              completed: (Employee employee) {
                return ListView(children: [
                  ProfileCard(employee: employee),
                  ProfileDetail(employee: employee),
                ]);
              },
              error: (String error) {
                return showSnackBar(context: context, error: error);
              });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          DeleteButton(onTap: () => _bloc.deleteEmployee(widget.id)),
    );
  }
}
