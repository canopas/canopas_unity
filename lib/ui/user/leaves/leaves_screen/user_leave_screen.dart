import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/widget/leave_count_card.dart';
import 'package:projectunity/ui/user/leaves/leaves_screen/widget/leave_list.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snack_bar.dart';

import '../../../../model/leave/leave.dart';
import '../../../../router/app_router.dart';
import 'bloc/leave_count/user_leave_count_bloc.dart';
import 'bloc/leave_count/user_leave_cout_event.dart';
import 'bloc/leaves/user_leave_bloc.dart';
import 'bloc/leaves/user_leave_event.dart';
import 'bloc/leaves/user_leave_state.dart';

class UserLeavePage extends StatelessWidget {
  const UserLeavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) =>
              getIt<UserLeaveCountBloc>()..add(FetchLeaveCountEvent())),
      BlocProvider(
          create: (_) => getIt<UserLeaveBloc>()..add(FetchUserLeaveEvent()))
    ], child: const UserLeaveScreen());
  }
}

class UserLeaveScreen extends StatefulWidget {
  const UserLeaveScreen({Key? key}) : super(key: key);

  @override
  State<UserLeaveScreen> createState() => _UserLeaveScreenState();
}

class _UserLeaveScreenState extends State<UserLeaveScreen> {
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          title: Text(
            localization.leaves_tag,
            style: AppFontStyle.appbarHeaderDark,
          ),
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () => context.goNamed(Routes.applyLeave),
                child: Text(localization.user_leave_apply_tag,
                    style: AppFontStyle.buttonTextStyle))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocConsumer<UserLeaveBloc, UserLeaveState>(
            listenWhen: (previous, current) => current is UserLeaveErrorState,
            listener: (context, state) {
              if (state is UserLeaveErrorState) {
                showSnackBar(context: context, error: state.error);
              }
            },
            buildWhen: (previous, current) => current is UserLeaveSuccessState,
            builder: (context, state) {
              if (state is UserLeaveLoadingState) {
                return const AppCircularProgressIndicator();
              } else if (state is UserLeaveSuccessState) {
                List<Leave> upcoming = state.upcomingLeaves;
                List<Leave> past = state.pastLeaves;
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const LeaveCountCard(),
                    const Divider(),
                    LeaveList(
                        leaves: upcoming,
                        title: localization.user_leave_upcoming_leaves_tag),
                    LeaveList(
                        leaves: past,
                        title: localization.user_leave_past_leaves_tag)
                  ],
                );
              }
              return Container();
            },
          ),
        ));
  }
}
