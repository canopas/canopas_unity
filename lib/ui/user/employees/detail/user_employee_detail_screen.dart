import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/admin/employee/detail/widget/profile_card.dart';
import 'package:projectunity/ui/user/employees/detail/bloc/user_employee_detail_bloc.dart';
import 'package:projectunity/ui/user/employees/detail/bloc/user_employee_detail_event.dart';
import 'package:projectunity/ui/user/employees/detail/widget/employee_info.dart';
import 'package:projectunity/ui/user/employees/detail/widget/tab_content.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snack_bar.dart';

import '../../../../configs/colors.dart';
import 'bloc/user_employee_detail_state.dart';

class UserEmployeeDetailPage extends StatelessWidget {
  final String employeeId;
  const UserEmployeeDetailPage({Key? key, required this.employeeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserEmployeeDetailBloc>(
        create: (_) => getIt<UserEmployeeDetailBloc>()
          ..add(UserEmployeeDetailFetchEvent(employeeId: employeeId)),
        child: const UserEmployeeDetailScreen());
  }
}

class UserEmployeeDetailScreen extends StatefulWidget {
  const UserEmployeeDetailScreen({Key? key}) : super(key: key);

  @override
  State<UserEmployeeDetailScreen> createState() =>
      _UserEmployeeDetailScreenState();
}

class _UserEmployeeDetailScreenState extends State<UserEmployeeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)
            .admin_employee_detail_appbar_title_detail_tag),
      ),
      body: BlocConsumer<UserEmployeeDetailBloc, UserEmployeeDetailState>(
          listenWhen: (previous, current) =>
              previous is! UserEmployeeDetailErrorState &&
              current is UserEmployeeDetailErrorState,
          listener: (context, state) {
            if (state is UserEmployeeDetailErrorState) {
              showSnackBar(context: context, error: state.error);
            }
          },
          builder: (context, state) {
            if (state is UserEmployeeDetailInitialState) {
              return Container();
            }
            if (state is UserEmployeeDetailLoadingState) {
              return const AppCircularProgressIndicator();
            }
            if (state is UserEmployeeDetailSuccessState) {
              return ListView(
                children: [
                  ProfileCard(employee: state.employee),
                  const Divider(
                    color: AppColors.lightGreyColor,
                    indent: primaryHorizontalSpacing,
                    endIndent: primaryHorizontalSpacing,
                  ),
                  EmployeeInfo(employee: state.employee),
                  const Divider(
                    indent: primaryHorizontalSpacing,
                    endIndent: primaryHorizontalSpacing,
                    color: AppColors.lightGreyColor,
                  ),
                  if (state.upcomingLeaves.isNotEmpty)
                    TabContent(leaves: state.upcomingLeaves),
                ],
              );
            }
            return Container();
          }),
    );
  }
}
