import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../model/leave/leave.dart';

class LeaveCard extends StatelessWidget {
  final double totalDays;
  final int startDate;
  final int endDate;
  final int type;
  final int status;

  const LeaveCard({
    required this.totalDays,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.status,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    final String leaveDuration =
        DateFormatter(localization).getLeaveDurationPresentation(totalDays);
    final String leaveType =
        localization.leave_type_placeholder_leave_status(type);
    final String leavePeriod = DateFormatter(localization)
        .dateInLine(startTimeStamp: startDate, endTimeStamp: endDate);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: [
                  Text(leaveDuration,
                      style: const TextStyle(
                          color: AppColors.greyColor,
                          fontWeight: FontWeight.w500)),
                  Text(leavePeriod,
                      style: const TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  Text(
                    leaveType,
                    style: const TextStyle(color: AppColors.primaryDarkYellow),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  LeaveStatusIcon(leaveStatus: status),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios_outlined))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LeaveStatusIcon extends StatelessWidget {
  final int leaveStatus;

  const LeaveStatusIcon({Key? key, required this.leaveStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (leaveStatus == pendingLeaveStatus)
          const Icon(
            Icons.error,
            color: AppColors.secondaryText,
          )
        else if (leaveStatus == rejectLeaveStatus)
          const Icon(
            Icons.dangerous,
            color: AppColors.primaryPink,
          )
        else if (leaveStatus == approveLeaveStatus)
          const Icon(
            Icons.check_circle,
            color: AppColors.primaryGreen,
          ),
        const SizedBox(
          width: 5,
        ),
        Text(
          AppLocalizations.of(context)
              .leave_status_placeholder_text(leaveStatus),
          style: AppTextStyle.bodyTextDark,
        )
      ],
    );
  }
}