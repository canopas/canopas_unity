import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/ui/user/user_home/bloc/user_home_bloc.dart';
import 'package:projectunity/ui/user/user_home/widget/employee_home_appbar.dart';
import 'package:projectunity/ui/user/user_home/widget/leave_navigation_card.dart';

import '../../../configs/colors.dart';
import '../../../core/utils/const/space_constant.dart';
import '../../../di/service_locator.dart';
import '../../../router/app_router.dart';
import '../../../widget/WhoIsOutCard/who_is_out_card.dart';

class UserHomeScreenPage extends StatelessWidget {
  const UserHomeScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserHomeBloc>(),
      child: const UserHomeScreen(),
    );
  }
}

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmployeeHomeAppBar(
        preferredSize: Size(MediaQuery.of(context).size.width, 80),
      ),
      body: ListView(
        padding: const EdgeInsets.all(primaryHorizontalSpacing),
        children: [
          WhoIsOutCard(
            onSeeAllButtonTap: () {
              context.goNamed(Routes.userCalender);
            },
          ),

          ///TODO remove this navigation on bottom bar navigation implementation.".
          const _EmployeeHomeNavigationCard(),
        ],
      ),
      backgroundColor: AppColors.whiteColor,
    );
  }
}

class _EmployeeHomeNavigationCard extends StatelessWidget {
  const _EmployeeHomeNavigationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: primaryHorizontalSpacing,
      ),
      LeaveNavigationCard(
          color: AppColors.primaryPink,
          leaveText: AppLocalizations.of(context).user_home_all_leaves_tag,
          onPress: () => context.pushNamed(Routes.allLeaves)),
      LeaveNavigationCard(
          color: AppColors.primaryBlue,
          leaveText:
              AppLocalizations.of(context).user_home_requested_leaves_tag,
          onPress: () => context.pushNamed(Routes.requested)),
      LeaveNavigationCard(
          color: AppColors.primaryGreen,
          leaveText: AppLocalizations.of(context).user_home_upcoming_leaves_tag,
          onPress: () => context.pushNamed(Routes.upcoming)),
      LeaveNavigationCard(
          color: AppColors.primaryDarkYellow,
          leaveText: AppLocalizations.of(context).user_home_apply_leave_tag,
          onPress: () => context.pushNamed(Routes.applyLeave)),
    ]);
  }
}
