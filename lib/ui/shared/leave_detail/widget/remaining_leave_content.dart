import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/theme.dart';
import 'package:projectunity/core/extensions/double_extension.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave_count.dart';
import '../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';
import '../../../../core/utils/date_formatter.dart';

class RemainingLeaveContainer extends StatelessWidget {
  final Leave leave;
  final LeaveCounts leaveCounts;
  const RemainingLeaveContainer({Key? key, required this.leave, required this.leaveCounts,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String totalDays = DateFormatter(AppLocalizations.of(context))
        .getLeaveDurationPresentationLong(leave.totalLeaves);
    String duration = DateFormatter(AppLocalizations.of(context))
        .dateInLine(
            startTimeStamp: leave.startDate, endTimeStamp: leave.endDate);

    return Container(
      padding: const EdgeInsets.all(primaryHorizontalSpacing),
      margin: const EdgeInsets.symmetric(vertical: primaryHalfSpacing,horizontal: primaryHorizontalSpacing),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
       borderRadius: AppTheme.commonBorderRadius,
        boxShadow: AppTheme.commonBoxShadow,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${leaveCounts.remainingLeaveCount.fixedAt(2)}/${leaveCounts.paidLeaveCount}",style: AppTextStyle.titleText.copyWith(fontWeight: FontWeight.bold,)),
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
                  Text(
                    duration,
                    style: AppTextStyle.subtitleText.copyWith(fontWeight: FontWeight.w600,color: AppColors.blackColor),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  Text(
                    totalDays,
                    style: AppTextStyle.bodyTextDark.copyWith(fontWeight: FontWeight.w500,color: AppColors.primaryBlue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}