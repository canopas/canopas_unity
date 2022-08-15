import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/font_size.dart';
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
    String _leaveType = AppLocalizations.of(context)
        .leave_type_placeholder_leave_status(leave.leaveStatus);
    String _leaveStatus = AppLocalizations.of(context)
        .leave_status_placeholder_text(leave.leaveStatus);
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
                      _leaveType,
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
                    _buildLeaveStatus(leaveStatus: _leaveStatus),
                    if (leave.rejectionReason != null)
                      _buildRejectionCause(
                          AppLocalizations.of(context).leave_reason_tag),
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

  RichText _buildRejectionCause(String reason) {
    return RichText(
        softWrap: true,
        overflow: TextOverflow.visible,
        text: TextSpan(
            text: reason,
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


