import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/theme.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/model/leave_application.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../core/utils/const/leave_map.dart';
import '../../../../../core/utils/const/space_constant.dart';
import '../../../../../core/utils/date_formatter.dart';
import '../../../../../model/leave_count.dart';
import '../../../../../router/app_router.dart';
import 'employee_content.dart';

class LeaveRequestCard extends StatelessWidget {
  final LeaveApplication leaveApplication;

  const LeaveRequestCard({Key? key, required this.leaveApplication})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: primaryHorizontalSpacing, vertical: primaryHalfSpacing),
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.whiteColor,
            boxShadow: AppTheme.commonBoxShadow),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () =>
              context.goNamed(Routes.adminLeaveDetail, extra: leaveApplication),
          child: Padding(
            padding: const EdgeInsets.all(primaryHorizontalSpacing),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _LeaveTypeContent(
                              leaveType: leaveApplication.leave.leaveType),
                          const SizedBox(
                            height: 10,
                          ),
                          _LeaveDateContent(
                            totalDays: leaveApplication.leave.totalLeaves,
                            startTimeStamp: leaveApplication.leave.startDate,
                            endTimeStamp: leaveApplication.leave.endDate,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: AppColors.greyColor,
                    )
                  ],
                ),
                const Divider(
                    thickness: 1, height: 30, color: AppColors.dividerColor),
                EmployeeContent(
                  employee: leaveApplication.employee,
                  leaveCounts:
                      leaveApplication.leaveCounts ?? const LeaveCounts(),
                ),

                // const ButtonContent()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LeaveTypeContent extends StatelessWidget {
  final int leaveType;

  const _LeaveTypeContent({Key? key, required this.leaveType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: leaveRequestCardColor[leaveType],
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 5, horizontal: primaryVerticalSpacing),
      child: Text(
        AppLocalizations.of(context)
            .leave_type_placeholder_leave_status(leaveType),
        style: AppTextStyle.subtitleText
            .copyWith(fontWeight: FontWeight.w500, color: AppColors.whiteColor),
      ),
    );
  }
}

class _LeaveDateContent extends StatelessWidget {
  final double totalDays;
  final int startTimeStamp;
  final int endTimeStamp;

  const _LeaveDateContent(
      {Key? key,
      required this.totalDays,
      required this.startTimeStamp,
      required this.endTimeStamp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String duration = DateFormatter(AppLocalizations.of(context))
        .dateInLine(startTimeStamp: startTimeStamp, endTimeStamp: endTimeStamp);
    String days = DateFormatter(AppLocalizations.of(context))
        .getLeaveDurationPresentation(totalDays);

    return Text(
      '$days, $duration ',
      style: AppTextStyle.bodyDarkGrey,
      overflow: TextOverflow.ellipsis,
    );
  }
}
