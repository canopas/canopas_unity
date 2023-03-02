import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/space_constant.dart';
import 'package:projectunity/ui/admin/employee/list/bloc/employee_list_event.dart';
import 'package:projectunity/widget/error_snack_bar.dart';

import '../../../../configs/colors.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).employee_tag,
        ),
      ),
      body: BlocConsumer<EmployeeListBloc, EmployeeListState>(
        builder: (BuildContext context, EmployeeListState state) {
          if (state is EmployeeListLoadingState) {
            return const AppCircularProgressIndicator();
          } else if (state is EmployeeListLoadedState) {
            List<Employee> employees = state.employees;
            return ListView.builder(
                padding: const EdgeInsets.symmetric(
                    vertical: primaryVerticalSpacing),
                itemCount: employees.length,
                itemBuilder: (BuildContext context, int index) {
                  Employee employee = employees[index];
                  return EmployeeCard(employee: employee);
                });
          }
          return const SizedBox();
        },
        listener: (BuildContext context, EmployeeListState state) {
          if (state is EmployeeListFailureState) {
            showSnackBar(context: context, error: state.error);
          }
        },
      ),
    );
  }
}
