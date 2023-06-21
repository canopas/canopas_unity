import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/ui/widget/leave_card_status_view.dart';
import '../../../data/configs/space_constant.dart';
import '../../../data/configs/text_style.dart';
import '../../../data/core/utils/date_formatter.dart';
import '../../../data/model/leave/leave.dart';

class LeaveTypeAgoTitleWithStatus extends StatelessWidget {
  const LeaveTypeAgoTitleWithStatus(
      {Key? key,
      required this.appliedOn,
      required this.leaveType,
      required this.status})
      : super(key: key);

  final DateTime appliedOn;
  final LeaveType leaveType;
  final LeaveStatus status;

  @override
  Widget build(BuildContext context) {
    String appliedOnPresentation = DateFormatter(AppLocalizations.of(context))
        .timeAgoPresentation(appliedOn);
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
                    .leave_type_placeholder_text(leaveType.value.toString()),
                style: AppFontStyle.titleDark,
              ),
              const SizedBox(height: 2),
              Text(
                appliedOnPresentation,
                style: AppFontStyle.labelGrey,
              ),
            ],
          ),
          LeaveStatusView(status: status, verticalPadding: 8),
        ],
      ),
    );
  }
}
