import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../configs/theme.dart';
import '../../../../../core/utils/const/space_constant.dart';
import '../../../../../core/utils/date_formatter.dart';
import '../../../../../model/leave/leave.dart';

class UserLeaveRequestDateContent extends StatelessWidget {
  final Leave leave;

  const UserLeaveRequestDateContent({Key? key, required this.leave})
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            duration,
            style: AppTextStyle.subtitleText.copyWith(
                fontWeight: FontWeight.w600, color: AppColors.blackColor),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(
            totalDays,
            style: AppTextStyle.bodyTextDark.copyWith(
                fontWeight: FontWeight.w500, color: AppColors.primaryBlue),
          ),
        ],
      ),
    );
  }
}
