import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../data/configs/space_constant.dart';
import '../../../data/configs/text_style.dart';
import '../../../data/core/utils/const/leave_map.dart';
import '../../../data/core/utils/date_formatter.dart';

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
                    .leave_type_placeholder_text(leaveType.toString()),
                style: AppFontStyle.titleDark,
              ),
              const SizedBox(height: 2),
              Text(
                appliedOn,
                style: AppFontStyle.labelGrey,
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: leaveStatusColor(status),
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                    AppLocalizations.of(context)
                        .leave_status_placeholder_text(status.toString()),
                    style: AppFontStyle.bodySmallHeavy),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
