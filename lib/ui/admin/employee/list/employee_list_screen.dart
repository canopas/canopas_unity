import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/ui/admin/employee/list/bloc/employee_list_event.dart';
import 'package:projectunity/widget/error_snack_bar.dart';

import '../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';
import '../../../../di/service_locator.dart';
import '../../../../model/employee/employee.dart';
import '../../../../widget/circular_progress_indicator.dart';
import 'bloc/employee_list_bloc.dart';
import 'bloc/employee_list_state.dart';
import 'employee_card.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmployeeListBloc>(
        create: (_) =>
            getIt<EmployeeListBloc>()..add(EmployeeListInitialLoadEvent()),
        child: const EmployeeListScreen());
  }
}

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
      body: BlocConsumer<EmployeeListBloc, EmployeeListState>(
        builder: (BuildContext context, EmployeeListState state) {
          if (state is EmployeeListInitialState) {
            return Container();
          } else if (state is EmployeeListLoadingState) {
            return const AppCircularProgressIndicator();
          } else if (state is EmployeeListLoadedState) {
            List<Employee> employees = state.employees;
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: primaryVerticalSpacing),
              child: ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (BuildContext context, int index) {
                    Employee employee = employees[index];
                    return EmployeeCard(employee: employee);
                  }),
            );
          }
          return Container();
        },
        listener: (BuildContext context, EmployeeListState state){
          if(state is EmployeeListFailureState){
            showSnackBar(context: context,error: state.error);
          }
        },
      ),

    );
  }
}
