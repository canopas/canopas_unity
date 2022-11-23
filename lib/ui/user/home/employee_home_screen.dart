import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/user/home/bloc/employee_home_event.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snackbar.dart';

import '../../../configs/colors.dart';
import '../../../core/utils/const/space_constant.dart';
import '../../../model/leave_count.dart';
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
                  _buildAppbar(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(
                          top: 80,
                          left: primaryHorizontalSpacing,
                          right: primaryHorizontalSpacing),
                      child: Column(
                        children: [
                          _buildNavCard(),
                          _buildAbsenceCard(),
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

  Widget _buildAppbar() {
    return ExpandedAppBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () {
                context
                    .read<EmployeeHomeBloc>()
                    .add(EmployeeHomeShowLeaveCalender());
              },
              icon: const Icon(
                Icons.calendar_month_rounded,
                color: AppColors.whiteColor,
              )),
          IconButton(
              onPressed: () {
                context.read<EmployeeHomeBloc>().add(EmployeeHomeShowSetting());
              },
              icon: const Icon(
                Icons.settings,
                color: AppColors.whiteColor,
              )),
        ],
      ),
    );
  }

  Widget _buildNavCard() {
    return Column(children: [
      LeaveNavigationCard(
          color: AppColors.primaryPink,
          leaveText: AppLocalizations.of(context).user_home_all_leaves_tag,
          onPress: () => context
              .read<EmployeeHomeBloc>()
              .add(EmployeeHomeShowAllLeaves())),
      LeaveNavigationCard(
          color: AppColors.primaryBlue,
          leaveText:
              AppLocalizations.of(context).user_home_requested_leaves_tag,
          onPress: () => context
              .read<EmployeeHomeBloc>()
              .add(EmployeeHomeShowRequestedLeaves())),
      LeaveNavigationCard(
          color: AppColors.primaryGreen,
          leaveText: AppLocalizations.of(context).user_home_upcoming_leaves_tag,
          onPress: () => context
              .read<EmployeeHomeBloc>()
              .add(EmployeeHomeShowUpcomingLeaves())),
      LeaveNavigationCard(
          color: AppColors.primaryDarkYellow,
          leaveText: AppLocalizations.of(context).user_home_apply_leave_tag,
          onPress: () => context
              .read<EmployeeHomeBloc>()
              .add(EmployeeHomeShowApplyLeave()))
    ]);
  }

  Widget _buildAbsenceCard() {
    return BlocBuilder<EmployeeHomeBloc,EmployeeHomeState>(
        builder: (BuildContext context, EmployeeHomeState state){
          if (state.status == EmployeeHomeStatus.loading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: const kCircularProgressIndicator(),
            );
          } else if (state.status == EmployeeHomeStatus.success) {
            return TeamLeaveCard(
              onTap: () {
                context.read<EmployeeHomeBloc>().add(EmployeeHomeShowWhosOut());
              },
              leaveApplication: state.absence ?? [],
            );
          } else if (state.status == EmployeeHomeStatus.failure) {
            return showSnackBar(context: context, msg: state.error);
          }
          return Container();
        });
  }

}
