import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/configs/space_constant.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/di/service_locator.dart';
import '../../../../data/model/employee/employee.dart';
import '../../../navigation/app_router.dart';
import '../../../widget/circular_progress_indicator.dart';
import '../../../widget/employee_card.dart';
import '../../../widget/error_snack_bar.dart';
import 'bloc/member_list_bloc.dart';
import 'bloc/member_list_event.dart';
import 'bloc/member_list_state.dart';

class MemberListPage extends StatelessWidget {
  const MemberListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmployeeListBloc>(
        create: (_) =>
            getIt<EmployeeListBloc>()..add(EmployeeListInitialLoadEvent()),
        child: const MemberListScreen());
  }
}

class MemberListScreen extends StatefulWidget {
  const MemberListScreen({Key? key}) : super(key: key);

  @override
  State<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).members_tag,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
                onPressed: () => context.pushNamed(Routes.inviteMember),
                child: Text(localizations.invite_tag)),
          )
        ],
      ),
      body: BlocConsumer<EmployeeListBloc, EmployeeListState>(
        builder: (BuildContext context, EmployeeListState state) {
          if (state is EmployeeListLoadingState) {
            return const AppCircularProgressIndicator();
          } else if (state is EmployeeListLoadedState) {
            List<Employee> employees = state.employees;
            return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  endIndent: primaryVerticalSpacing,
                  indent: primaryVerticalSpacing,
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: primaryVerticalSpacing,
                    vertical: primaryVerticalSpacing),
                itemCount: employees.length,
                itemBuilder: (BuildContext context, int index) {
                  Employee employee = employees[index];
                  return EmployeeCard(
                    employee: employee,
                    onTap: () => context.goNamed(Routes.adminMemberDetails,
                        params: {RoutesParamsConst.employeeId: employee.uid}),
                  );
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
