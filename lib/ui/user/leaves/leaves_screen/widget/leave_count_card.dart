import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/configs/theme.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/text_style.dart';
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
      margin: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: AppTheme.commonBoxShadow,
        borderRadius: AppTheme.commonBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.used.toString(),
                        style: AppFontStyle.headerGrey
                            .copyWith(color: AppColors.primaryBlue),
                      ),
                      Text(
                        AppLocalizations.of(context).user_leave_used_leaves_tag,
                        style: AppFontStyle.labelRegular,
                      )
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }
}
