import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../core/utils/date_formatter.dart';
import '../../../../../model/leave/leave.dart';
import '../../../../../router/app_router.dart';

class UserLeaveCard extends StatelessWidget {
  final Leave leave;

  const UserLeaveCard({
    required this.leave,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    final String leaveDuration = DateFormatter(localization)
        .getLeaveDurationPresentation(leave.totalLeaves);
    final String leaveType =
        localization.leave_type_placeholder_leave_status(leave.leaveType);
    final String leavePeriod = DateFormatter(localization).dateInLine(
        startTimeStamp: leave.startDate, endTimeStamp: leave.endDate);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(leaveDuration, style: AppTextStyle.bodyTextDark),
                  Text(leavePeriod,
                      style: const TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  Text(
                    leaveType,
                    style: const TextStyle(
                        color: AppColors.primaryPink, fontSize: 15),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GoRouter.of(context).location == Routes.userHome
                      ? Container()
                      : LeaveStatusIcon(leaveStatus: leave.leaveStatus),
                  IconButton(
                      onPressed: () {
                        GoRouter.of(context).location == Routes.userHome
                            ? context.goNamed(Routes.userRequestDetail,
                                params: {
                                    RoutesParamsConst.leaveId: leave.leaveId
                                  })
                            : context.goNamed(Routes.userLeaveDetail, params: {
                                RoutesParamsConst.leaveId: leave.leaveId
                              });
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 12,
                      ))
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
