import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:projectunity/ui/user/leaves/bloc/leave_count/user_leave_count_bloc.dart';
import 'package:projectunity/ui/user/leaves/bloc/leave_count/user_leave_count_state.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';

import '../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';

class LeaveCountCard extends StatelessWidget {
  const LeaveCountCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: LeaveContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocBuilder<UserLeaveCountBloc, UserLeaveCountState>(
              builder: (context, state) {
            final double remainingLeaves = state.remaining!;
            final int totalLeaves = state.totalLeaves!;
            final double percentage = state.leavePercentage!;
            if (state.status == UserLeaveCountStatus.loading) {
              return const AppCircularProgressIndicator();
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PercentIndicator(percentage: percentage),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$remainingLeaves/$totalLeaves',
                      style: AppFontStyle.titleTextStyle,
                    ),
                    Text(
                      AppLocalizations.of(context).user_used_leaves_tag,
                      style: AppFontStyle.subTitleTextStyle,
                    )
                  ],
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}

class LeaveContainer extends StatelessWidget {
  final Widget child;

  const LeaveContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 110,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            boxShadow: const [
              BoxShadow(
                color: AppColors.lightGreyColor, //New
                blurRadius: 5.0,
              )
            ],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.lightGreyColor, width: 3)),
        child: child);
  }
}

class PercentIndicator extends StatelessWidget {
  const PercentIndicator({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  final double percentage;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: MediaQuery.of(context).size.width * 0.085,
      animation: true,
      animationDuration: 1200,
      lineWidth: 15.0,
      percent: percentage,
      circularStrokeCap: CircularStrokeCap.butt,
      backgroundColor: AppColors.lightGreyColor,
      progressColor: AppColors.redColor,
    );
  }
}
