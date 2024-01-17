import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/configs/theme.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import 'package:projectunity/ui/widget/leave_count_view.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../bloc/leave_count/user_leave_count_bloc.dart';
import '../bloc/leave_count/user_leave_count_state.dart';

class LeaveCountCard extends StatelessWidget {
  const LeaveCountCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 80,
      margin: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: AppTheme.commonBoxShadow,
        borderRadius: AppTheme.commonBorderRadius,
      ),
      child: BlocConsumer<UserLeaveCountBloc, UserLeaveCountState>(
          listenWhen: (previous, current) => current.status == Status.error,
          listener: (context, state) {
            if (state.status == Status.error) {
              showSnackBar(context: context, error: state.error);
            }
          },
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 8,
                    color: AppColors.primaryBlue,
                    backgroundColor: AppColors.lightPrimaryBlue,
                    value: state.leavePercentage,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16),
                  height: 60,
                  width: 1,
                  color: AppColors.lightGreyColor,
                ),
                Expanded(
                    child: UsedLeaveCountsView(
                        leaveCounts: state.usedLeavesCounts)),
              ],
            );
          }),
    );
  }
}
