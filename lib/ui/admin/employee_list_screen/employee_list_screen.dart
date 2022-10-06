import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/core/utils/const/other_constant.dart';
import '../../../bloc/admin/employee_list/employee_list_bloc.dart';
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

  final _employeeListBloc = getIt<EmployeeListBloc>();

  @override
  void initState() {
    _employeeListBloc.attach();
    super.initState();
  }

  @override
  void dispose() {
    _employeeListBloc.detach();
    super.dispose();
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
          stream: _employeeListBloc.allEmployees,
          builder: (context, snapshot) {
            return snapshot.data!.when(
              idle: () => Container(),
              loading: () => const kCircularProgressIndicator(),
              completed: (List<Employee> list) => ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: primaryVerticalSpacing),itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    Employee employee = list[index];
                    return EmployeeCard(employee: employee);
                  }),
              error: (String error) =>
                  showSnackBar(context: context, error: error),
            );
          }),
    );
  }
}
