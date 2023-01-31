import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/ui/user/leaves/bloc/leave_count/user_leave_count_bloc.dart';
import 'package:projectunity/ui/user/leaves/bloc/leave_count/user_leave_count_state.dart';

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
            final double usedLeaves = state.used!;
            final int totalLeaves = state.totalLeaves!;
            final double percentage = state.leavePercentage!;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 12,
                  backgroundColor: AppColors.primaryDarkYellow,
                  value: percentage,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$usedLeaves/$totalLeaves',
                      style: AppFontStyle.titleTextStyle,
                    ),
                    Text(
                      AppLocalizations.of(context).user_leave_used_leaves_tag,
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

