import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/user/home/bloc/employee_home_event.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snack_bar.dart';

import '../../../configs/colors.dart';
import '../../../core/utils/const/space_constant.dart';
import '../../../router/app_router.dart';
import '../../../widget/expanded_app_bar.dart';
import 'bloc/employee_home_bloc.dart';
import 'bloc/employee_home_state.dart';
import 'view/leave_navigation_card.dart';
import 'view/leave_status.dart';
import 'view/team_leave_card.dart';

class EmployeeHomePage extends StatelessWidget {
  const EmployeeHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<EmployeeHomeBloc>()..add(EmployeeHomeFetchEvent()),
      child: const EmployeeHomeScreen(),
    );
  }
}

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
            children: [
              Column(
                children: [
                  const _EmployeeHomeAppBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(
                          top: 80,
                          left: primaryHorizontalSpacing,
                          right: primaryHorizontalSpacing),
                      child: Column(
                        children: const [
                          _EmployeeHomeNavigationCard(),
                          _EmployeeHomeAbsenceCard(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Positioned(
              top:100,
              right: 10,
              left: 10,
              child: LeaveStatus())
            ],
          ),
    );
  }
}

class _EmployeeHomeAppBar extends StatelessWidget {
  const _EmployeeHomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandedAppBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () => context.pushNamed(Routes.userLeaveCalender),
              icon: const Icon(
                Icons.calendar_month_rounded,
                color: AppColors.whiteColor,
              )),
          IconButton(
              onPressed: () => context.pushNamed(Routes.userSettings),
              icon: const Icon(
                Icons.settings,
                color: AppColors.whiteColor,
              )),
        ],
      ),
    );
  }
}

class _EmployeeHomeAbsenceCard extends StatelessWidget {
  const _EmployeeHomeAbsenceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeHomeBloc,EmployeeHomeState>(
        builder: (BuildContext context, EmployeeHomeState state){
          if (state.status == EmployeeHomeStatus.loading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: const AppCircularProgressIndicator(),
            );
          } else if (state.status == EmployeeHomeStatus.success) {
            return TeamLeaveCard(
              leaveApplication: state.absence ?? [],
            );
          } else if (state.status == EmployeeHomeStatus.failure) {
             showSnackBar(context: context, msg: state.error);
          }
          return const SizedBox();
        });
  }
}

class _EmployeeHomeNavigationCard extends StatelessWidget {
  const _EmployeeHomeNavigationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
