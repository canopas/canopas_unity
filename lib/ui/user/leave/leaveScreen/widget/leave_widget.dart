import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';

import '../../../../../configs/colors.dart';
import '../../../../../core/utils/const/leave_screen_type_map.dart';
import '../../../../../model/leave/leave.dart';
import 'leave_date_container.dart';


class LeaveWidget extends StatelessWidget {
  final Leave leave;

  const LeaveWidget({Key? key, required this.leave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String leaveType = AppLocalizations.of(context)
        .leave_type_placeholder_leave_status(leave.leaveStatus);
    String leaveStatus = AppLocalizations.of(context)
        .leave_status_placeholder_text(leave.leaveStatus);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BuildLeaveDateContainer(
              startDate: leave.startDate,
              endDate: leave.endDate,
              color: getLeaveContainerColor(leave.leaveStatus),
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
                      leaveType,
                      style: AppTextStyle.darkSubtitle700,
                    ),
                    Text(leave.reason,
                        overflow: TextOverflow.visible,
                        style: AppTextStyle.secondaryBodyText),
                    const SizedBox(
                      height: 5,
                    ),
                    _buildLeaveStatus(leaveStatus: leaveStatus),
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
            style: AppTextStyle.darkSubtitle700,
            children: [
              TextSpan(
                  text: leave.rejectionReason,
                  style: AppTextStyle.secondaryBodyText)
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
          style: AppTextStyle.bodyTextDark,
        )
      ],
    );
  }
}


