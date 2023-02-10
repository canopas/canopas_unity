import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/core/utils/const/leave_screen_type_map.dart';

import '../../../../../configs/text_style.dart';
import '../../../../../core/utils/const/space_constant.dart';
import '../../../../../core/utils/date_formatter.dart';

class LeaveTypeAgoTitleWithStatus extends StatelessWidget {
  const LeaveTypeAgoTitleWithStatus(
      {Key? key,
      required this.appliedOnInTimeStamp,
      required this.leaveType,
      required this.status})
      : super(key: key);

  final int appliedOnInTimeStamp;
  final int leaveType;
  final int status;

  @override
  Widget build(BuildContext context) {
    String appliedOn = DateFormatter(AppLocalizations.of(context))
        .timeAgoPresentation(appliedOnInTimeStamp);
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
            decoration: BoxDecoration(
                color: getLeaveContainerColor(status).withOpacity(0.50),
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)
                      .leave_status_placeholder_text(status),
                  style: AppTextStyle.bodyTextDark
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
