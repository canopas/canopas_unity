import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../bloc/admin/employee/employee_list_bloc.dart';
import '../../../configs/colors.dart';
import '../../../configs/text_style.dart';
import '../../../di/service_locator.dart';
import '../../../model/employee/employee.dart';
import '../../../rest/api_response.dart';
import '../../../widget/circular_progress_indicator.dart';
import '../../../widget/error_snackbar.dart';
import 'widget/employee_card.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen ({Key? key}) : super(key: key);

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {

  final _bloc = getIt<EmployeeListBloc>();

  @override
  void initState() {
    _bloc.getEmployeeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).admin_home_employee_tag,
          style: AppTextStyle.appBarTitle,
        ),
      ),
      body: StreamBuilder<ApiResponse<List<Employee>>>(
          initialData: const ApiResponse.idle(),
          stream: _bloc.allEmployee,
          builder: (context, snapshot) {
            return snapshot.data!.when(
              idle: () => Container(),
              loading: () => const kCircularProgressIndicator(),
              completed: (List<Employee> list) => ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  Employee employee = list[index];
                  return EmployeeCard(employee: employee);
                }
              ),
              error: (String error) => showSnackBar(context, error),
            );
          }),
    );
  }
}
