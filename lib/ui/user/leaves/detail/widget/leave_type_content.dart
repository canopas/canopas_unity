import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/model/leave/leave.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../configs/theme.dart';
import '../../../../../core/utils/const/space_constant.dart';
import '../../../../../core/utils/date_formatter.dart';

class LeaveTypeContent extends StatelessWidget {
  final int leaveType;
  final int appliedTime;
  final int leaveStatus;

  const LeaveTypeContent(
      {Key? key,
      required this.leaveType,
      required this.appliedTime,
      required this.leaveStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    String appliedOn = DateFormatter(AppLocalizations.of(context))
        .timeAgoPresentation(appliedTime);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: primaryHorizontalSpacing, vertical: primaryHalfSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)
                    .leave_type_placeholder_leave_status(leaveType),
                style: AppTextStyle.titleBlack600,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                appliedOn,
                style: AppTextStyle.secondarySubtitle500,
              ),
            ],
          ),
          Container(
              padding: const EdgeInsets.all(5).copyWith(bottom: 4),
              decoration: BoxDecoration(
                boxShadow: AppTheme.commonBoxShadow,
                borderRadius: AppTheme.commonBorderRadius,
                color: AppColors.lightPrimaryBlue,
              ),
              child: Row(
                children: [
                  statusIcon(leaveStatus),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    localization.leave_status_placeholder_text(leaveStatus),
                    style: AppTextStyle.subtitleTextDark,
                  )
                ],
              )),
        ],
      ),
    );
  }

  Icon statusIcon(int leaveStatus) {
    if (leaveStatus == pendingLeaveStatus) return const Icon(Icons.error_sharp);
    if (leaveStatus == approveLeaveStatus) {
      return const Icon(Icons.check_circle);
    } else {
      return const Icon(Icons.close);
    }
  }
}
