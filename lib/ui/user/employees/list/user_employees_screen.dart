import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/configs/colors.dart';
import '../../../../data/configs/space_constant.dart';
import '../../../../data/di/service_locator.dart';
import '../../../../data/model/employee/employee.dart';
import '../../../navigation/app_router.dart';
import '../../../widget/circular_progress_indicator.dart';
import '../../../widget/employee_card.dart';
import '../../../widget/error_snack_bar.dart';
import 'bloc/user_employees_bloc.dart';
import 'bloc/user_employees_event.dart';
import 'bloc/user_employees_state.dart';

class UserEmployeesPage extends StatelessWidget {
  const UserEmployeesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UserEmployeesBloc>()..add(FetchEmployeesEvent()),
      child: const UserEmployeesScreen(),
    );
  }
}

class UserEmployeesScreen extends StatefulWidget {
  const UserEmployeesScreen({Key? key}) : super(key: key);

  @override
  State<UserEmployeesScreen> createState() => _UserEmployeesScreenState();
}

class _UserEmployeesScreenState extends State<UserEmployeesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).employees_tag),
      ),
      backgroundColor: AppColors.whiteColor,
      body: RefreshIndicator(
        color: AppColors.textDark,
        onRefresh: () async {
          context.read<UserEmployeesBloc>().add(FetchEmployeesEvent());
        },
        child: BlocConsumer<UserEmployeesBloc, UserEmployeesState>(
            listenWhen: (previous, current) =>
                current is UserEmployeesFailureState,
            listener: (context, state) {
              if (state is UserEmployeesFailureState) {
                showSnackBar(context: context, error: state.error);
              }
            },
            builder: (context, state) {
              if (state is UserEmployeesLoadingState) {
                return const AppCircularProgressIndicator();
              } else if (state is UserEmployeesSuccessState) {
                return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: primaryVerticalSpacing),
                    itemBuilder: (BuildContext context, int index) {
                      Employee employee = state.employees[index];
                      return EmployeeCard(
                        employee: employee,
                        onTap: () {
                          context.goNamed(Routes.userEmployeeDetail, params: {
                            RoutesParamsConst.employeeId: employee.uid
                          });
                        },
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const Divider(endIndent: 8, indent: 8),
                    itemCount: state.employees.length);
              }
              return const SizedBox();
            }),
      ),
    );
  }
}
