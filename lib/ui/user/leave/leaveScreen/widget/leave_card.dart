import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/configs/theme.dart';
import 'package:projectunity/core/utils/date_formatter.dart';
import 'package:projectunity/model/leave_application.dart';
import '../../../../../configs/colors.dart';
import '../../../../../core/utils/const/leave_screen_type_map.dart';
import '../../../../../model/leave/leave.dart';

class LeaveCard extends StatelessWidget {
  final void Function()? onTap;
  final LeaveApplication leaveApplication;

  const LeaveCard({Key? key, required this.leaveApplication, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context);
    var duration = DateFormatter(localize).dateInLine(lastTwoLine: true,startTimeStamp: leaveApplication.leave.startDate, endTimeStamp: leaveApplication.leave.endDate);
    final color = getLeaveContainerColor(leaveApplication.leave.leaveStatus);
    return Container(
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: AppTheme.commonBoxShadow,
          borderRadius: AppTheme.commonBorderRadius
      ),
      child: ClipRRect(
        borderRadius: AppTheme.commonBorderRadius,
        child: Material(
          color: AppColors.whiteColor,
          borderRadius: AppTheme.commonBorderRadius,
          child: InkWell(
            borderRadius: AppTheme.commonBorderRadius,
            onTap: onTap,
            child: Container(
              decoration:   BoxDecoration(
                  border: Border(left: BorderSide(color: color, width: 5,))
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.50),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          localize.leave_type_placeholder_leave_status(leaveApplication.leave.leaveType),
                          style: AppTextStyle.bodyTextDark.copyWith(fontWeight: FontWeight.bold,),
                        ),
                      ),
                      Flexible(child: Text(duration,textAlign: TextAlign.right, overflow: TextOverflow.visible, maxLines: 2,)),
                    ],
                  ),
                  const SizedBox(height: 10,),
              Text(
                leaveApplication.leave.reason,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: AppTextStyle.secondaryBodyText,
              ),
                  const SizedBox(height: 10,),
                  _leaveStatusIcon(leaveStatusText: localize.leave_status_placeholder_text(leaveApplication.leave.leaveStatus)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }




  Widget _leaveStatusIcon({required String leaveStatusText}) {
    return Row(
      children: [
        if (leaveApplication.leave.leaveStatus == pendingLeaveStatus)
          const Icon(
            Icons.error,
            color: AppColors.secondaryText,
          )
        else if (leaveApplication.leave.leaveStatus == rejectLeaveStatus)
          const Icon(
            Icons.dangerous,
            color: AppColors.primaryPink,
          )
        else if (leaveApplication.leave.leaveStatus == approveLeaveStatus)
          const Icon(
            Icons.check_circle,
            color: AppColors.primaryGreen,
          ),
        const SizedBox(width: 5,),
        Text(
          leaveStatusText,
          style: AppTextStyle.bodyTextDark,
        )
      ],
    );
  }
}
