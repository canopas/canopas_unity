import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/core/extensions/double_extension.dart';

import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/core/utils/date_formatter.dart';
import '../../../../../data/model/leave/leave.dart';
import '../../../../widget/circular_progress_indicator.dart';
import '../bloc/admin_leave_details_bloc.dart';
import '../bloc/admin_leave_details_state.dart';

class AdminLeaveRequestDetailsDateContent extends StatelessWidget {
  final Leave leave;

  const AdminLeaveRequestDetailsDateContent({Key? key, required this.leave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String totalDays = DateFormatter(AppLocalizations.of(context))
        .getLeaveDurationPresentationLong(leave.total);
    String duration = DateFormatter(AppLocalizations.of(context)).dateInLine(
        startDate: leave.startDate, endDate: leave.endDate);

    return Container(
      padding: const EdgeInsets.all(primaryHorizontalSpacing),
      margin: const EdgeInsets.symmetric(
          vertical: primaryHalfSpacing, horizontal: primaryHorizontalSpacing),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: AppTheme.commonBorderRadius,
        boxShadow: AppTheme.commonBoxShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<AdminLeaveDetailsBloc,
              AdminLeaveDetailsState>(
            buildWhen: (previous, current) => previous.leaveCountStatus != current.leaveCountStatus,
            builder: (context, state) => state.leaveCountStatus == Status.loading
                ? const AppCircularProgressIndicator(size: 28)
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( state.paidLeaveCount==0?state.usedLeaves.fixedAt(2).toString():"${state.usedLeaves.fixedAt(2)}/${state.paidLeaveCount}",
                        style: AppFontStyle.titleDark),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context).user_leave_used_leaves_tag,
                      style: AppFontStyle.bodyMedium
                          .copyWith(color: AppColors.primaryBlue),
                    )
                  ],
                ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(duration, style: AppFontStyle.titleDark),
                const SizedBox(height:8),
                Text(
                  totalDays,
                  style: AppFontStyle.bodyMedium
                      .copyWith(color: AppColors.primaryBlue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
