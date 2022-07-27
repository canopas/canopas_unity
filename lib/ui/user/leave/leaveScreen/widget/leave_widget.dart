import 'package:flutter/material.dart';
import 'package:projectunity/core/utils/const/leave_status.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/font_size.dart';
import '../../../../../core/utils/const/leave_map.dart';
import '../../../../../core/utils/date_string_utils.dart';
import '../../../../../model/leave/leave.dart';
import 'leave_date_container.dart';

Color getContainerColor(int status) {
  if (status == 2) {
    return AppColors.primaryDarkYellow;
  } else if (status == 3) {
    return AppColors.blackColor;
  }
  return AppColors.lightGreyColor;
}

class LeaveWidget extends StatelessWidget {
  final Leave leave;

  const LeaveWidget({Key? key, required this.leave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BuildLeaveDateContainer(
              startDate: leave.startDate,
              endDate: leave.endDate,
              color: getContainerColor(leave.leaveStatus),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: SizedBox(
                height: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getLeaveStatus(leave.leaveType ?? pendingLeaveStatus,
                              leaveTypeMap) ??
                          '',
                      style: const TextStyle(
                          color: AppColors.darkText,
                          fontSize: subTitleTextSize,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      leave.reason,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                          fontSize: bodyTextSize,
                          color: AppColors.secondaryText),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _buildLeaveStatus(
                        leaveStatus:
                            getLeaveStatus(leave.leaveStatus, leaveStatusMap)),
                    if (leave.rejectionReason != null) _buildRejectionCause(),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10)
      ],
    );
  }

  RichText _buildRejectionCause() {
    return RichText(
        softWrap: true,
        overflow: TextOverflow.visible,
        text: TextSpan(
            text: 'Reason: ',
            style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: subTitleTextSize,
                fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                  text: leave.rejectionReason,
                  style: const TextStyle(
                      color: AppColors.secondaryText, fontSize: bodyTextSize))
            ]));
  }

  Widget _buildLeaveStatus({required String? leaveStatus}) {
    return Row(
      children: [
        if (leaveStatus == 'Pending')
          const Icon(
            Icons.error,
            color: AppColors.secondaryText,
          ),
        if (leaveStatus == 'Rejected')
          const Icon(
            Icons.dangerous,
            color: AppColors.primaryPink,
          ),
        if (leaveStatus == 'Approved')
          const Icon(
            Icons.check_circle,
            color: AppColors.primaryGreen,
          ),
        Text(
          leaveStatus ?? '',
          style: const TextStyle(
              color: AppColors.darkText, fontSize: bodyTextSize),
        )
      ],
    );
  }
}


