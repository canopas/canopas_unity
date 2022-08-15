import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/ui/admin/home/employee/list/employee_list.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snackbar.dart';

import '../../../../bloc/admin/employee/employee_list_bloc.dart';
import '../../../../di/service_locator.dart';
import '../../../../model/employee/employee.dart';
import '../../../../rest/api_response.dart';

class EmployeeListView extends StatefulWidget {
  const EmployeeListView({Key? key}) : super(key: key);

  @override
  State<EmployeeListView> createState() => _EmployeeListViewState();
}

class _EmployeeListViewState extends State<EmployeeListView> {
  final _bloc = getIt<EmployeeListBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.getEmployeeList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<List<Employee>>>(
        initialData: const ApiResponse.idle(),
        stream: _bloc.allEmployee,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.data!.when(idle: () {
            return Container();
          }, loading: () {
            return const kCircularProgressIndicator();
          }, completed: (List<Employee> list) {
            return EmployeeList(employees: list);
          }, error: (String error) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              showSnackBar(context,
                  AppLocalizations.of(context).error_something_went_wrong);
            });
            return Container();
          });
        });
  }
}
