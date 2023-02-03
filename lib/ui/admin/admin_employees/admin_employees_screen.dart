import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/admin_employees_event.dart';
import '../../../configs/colors.dart';
import '../../../core/utils/const/space_constant.dart';
import '../../../di/service_locator.dart';
import '../../../widget/app_app_bar.dart';
import '../../../widget/app_divider.dart';
import '../../../widget/circular_progress_indicator.dart';
import '../../../widget/employee_card.dart';
import '../../../widget/error_snack_bar.dart';
import 'bloc/admin_employee_state.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'bloc/admin_employees_bloc.dart';

class AdminEmployeesPage extends StatelessWidget {
  const AdminEmployeesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AdminEmployeesBloc>()..add(FetchEmployeesEventAdminEmployeesEvent()),
      child: const AdminEmployeesScreen(),
    );
  }
}

class AdminEmployeesScreen extends StatefulWidget {
  const AdminEmployeesScreen({Key? key}) : super(key: key);

  @override
  State<AdminEmployeesScreen> createState() => _AdminEmployeesScreenState() ;
}

class _AdminEmployeesScreenState extends State<AdminEmployeesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        bottomTitlePadding: 0,
        title: AppLocalizations.of(context).employee_tag,
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.all(primaryVerticalSpacing),
              ),
              onPressed: () {
                ///TODO add navigation for add member screens
              },
              child: const Icon(Icons.add,color: AppColors.blackColor,))
        ],
      ),
      backgroundColor: AppColors.whiteColor,
      body: RefreshIndicator(
        color: AppColors.textDark,
        onRefresh: () async {
          context.read<AdminEmployeesBloc>().add(FetchEmployeesEventAdminEmployeesEvent());
        },
        child: BlocConsumer<AdminEmployeesBloc, AdminEmployeesState>(
            listenWhen: (previous, current) =>
                current is AdminEmployeesFailureState,
            listener: (context, state) {
              if (state is AdminEmployeesFailureState) {
                showSnackBar(context: context, error: state.error);
              }
            },
            builder: (context, state) {
              if (state is AdminEmployeesLoadingState) {
                return const AppCircularProgressIndicator();
              } else if (state is AdminEmployeesSuccessState) {
                return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: primaryVerticalSpacing),
                    itemBuilder: (BuildContext context, int employee) =>
                        EmployeeCard(
                          employee: state.employees[employee],
                          onTap: () {
                            ///TODO implement navigation to employee details screen
                          },
                        ),
                    separatorBuilder: (context, index) => const AppDivider(),
                    itemCount: state.employees.length);
              }
              return const SizedBox();
            }),
      ),
    );
  }
}


