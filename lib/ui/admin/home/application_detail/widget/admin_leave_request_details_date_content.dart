import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/core/extensions/double_extension.dart';
import '../../../../../configs/colors.dart';
import '../../../../../configs/space_constant.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../configs/theme.dart';
import '../../../../../data/core/utils/date_formatter.dart';
import '../../../../../data/model/leave/leave.dart';
import '../../../../widget/circular_progress_indicator.dart';
import '../bloc/admin_leave_application_detail_bloc.dart';
import '../bloc/admin_leave_application_detail_state.dart';

class AdminLeaveRequestDetailsDateContent extends StatelessWidget {
  final Leave leave;

  const AdminLeaveRequestDetailsDateContent({Key? key, required this.leave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String totalDays = DateFormatter(AppLocalizations.of(context))
        .getLeaveDurationPresentationLong(leave.totalLeaves);
    String duration = DateFormatter(AppLocalizations.of(context)).dateInLine(
        startTimeStamp: leave.startDate, endTimeStamp: leave.endDate);

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
          BlocBuilder<AdminLeaveApplicationDetailsBloc,
              AdminLeaveApplicationDetailsState>(
            builder: (context, state) => state.adminLeaveCountStatus ==
                    AdminLeaveCountStatus.loading
                ? const AppCircularProgressIndicator(size: 28)
                : Text("${state.usedLeaves.fixedAt(2)}/${state.paidLeaveCount}",
                    style: AppFontStyle.titleRegular
                        .copyWith(fontWeight: FontWeight.bold)),
          ),
          const VerticalDivider(
            color: AppColors.primaryBlue,
            thickness: 0.5,
            width: 32,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(duration, style: AppFontStyle.labelRegular),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  totalDays,
                  style: AppFontStyle.bodySmallHeavy
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
