import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/configs/theme.dart';
import 'package:projectunity/data/core/extensions/double_extension.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/model/leave/leave.dart';
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          state.usedLeavesCounts.casualLeaves
                              .fixedAt(2)
                              .toString(),
                          style: AppFontStyle.titleDark),
                      const SizedBox(height: 4),
                      Text(
                        AppLocalizations.of(context)
                            .leave_type_placeholder_text(
                                LeaveType.casualLeave.value.toString()),
                        style: AppFontStyle.bodyMedium
                            .copyWith(color: AppColors.primaryBlue),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  width: 1,
                  color: AppColors.lightGreyColor,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          state.usedLeavesCounts.urgentLeaves
                              .fixedAt(2)
                              .toString(),
                          style: AppFontStyle.titleDark),
                      const SizedBox(height: 4),
                      Text(
                        AppLocalizations.of(context)
                            .leave_type_placeholder_text(
                                LeaveType.urgentLeave.value.toString()),
                        style: AppFontStyle.bodyMedium
                            .copyWith(color: AppColors.primaryBlue),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
