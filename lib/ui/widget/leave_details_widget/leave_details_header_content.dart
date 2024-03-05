import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/ui/widget/leave_card_status_view.dart';
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: leaveStatusColor(status, context).withOpacity(0.1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n
                    .leave_type_placeholder_text(leaveType.value.toString()),
                style: AppTextStyle.style20
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
              const SizedBox(height: 2),
              Text(
                appliedOnPresentation,
                style: AppTextStyle.style14
                    .copyWith(color: context.colorScheme.textSecondary),
              ),
            ],
          ),
          LeaveStatusView(status: status, verticalPadding: 8),
        ],
      ),
    );
  }
}
