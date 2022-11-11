import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/theme.dart';
import 'package:projectunity/core/extensions/double_extension.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/model/leave/leave.dart';
import '../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../model/remaining_leave.dart';

class RemainingLeaveContainer extends StatelessWidget {
  final Leave leave;
  final Stream<RemainingLeave> remainingLeaveStream;
  const RemainingLeaveContainer({Key? key, required this.leave, required this.remainingLeaveStream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    String totalDays = DateFormatter(AppLocalizations.of(context))
        .getLeaveDurationPresentation(leave.totalLeaves);
    String duration = DateFormatter(AppLocalizations.of(context))
        .dateInLine(
            startTimeStamp: leave.startDate, endTimeStamp: leave.endDate);

    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      margin: const EdgeInsets.symmetric(vertical: primaryVerticalSpacing,horizontal: primaryHorizontalSpacing),
      decoration: BoxDecoration(
        color: AppColors.primaryBlueLight,
       borderRadius: AppTheme.commonBorderRadius,),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            totalDays,
            style: AppTextStyle.titleBlack600.copyWith(fontWeight: FontWeight.bold)
                .copyWith(color: AppColors.primaryBlue),
          ),
          (leave.totalLeaves < 1)?Padding(
            padding:  EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
            child: Text(
              DateFormatter(localization).halfDayTime(leave.perDayDuration.first),
                    style: AppTextStyle.subtitleText
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
          ):SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          Text(
            duration,
            style: AppTextStyle.titleText,
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.01,),
          StreamBuilder<RemainingLeave>(
            stream: remainingLeaveStream,
            initialData: RemainingLeave(),
            builder: (context, snapshot) => Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 10,
                      width: MediaQuery.of(context).size.width*0.8,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      height: 10,
                      width: (snapshot.data?.remainingLeavePercentage == null)
                          ? (MediaQuery.of(context).size.width * 0.8) * 0
                          : (MediaQuery.of(context).size.width * 0.8) *
                              snapshot.data!.remainingLeavePercentage,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  localization.leave_remaining_days_placeholder(
                      snapshot.data?.remainingLeave.fixedAt(1)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}