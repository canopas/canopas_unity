import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import '../../data/model/leave/leave.dart';

class LeaveStatusView extends StatelessWidget {
  final double verticalPadding;
  final double horizontalPadding;
  final LeaveStatus status;
  final LeaveType? leaveType;

  const LeaveStatusView({
    super.key,
    required this.status,
    this.leaveType,
    this.verticalPadding = 4,
    this.horizontalPadding = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LeaveStatusIcon(status: status),
        const SizedBox(width: 5),
        Text(
          context.l10n.leave_status_placeholder_text(status.value.toString()),
          style: AppTextStyle.style16.copyWith(
            color: leaveStatusColor(status, context),
          ),
        ),
        if (leaveType != null) const SizedBox(width: 8),
        if (leaveType != null)
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: context.colorScheme.containerLow,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              context.l10n
                  .leave_type_placeholder_text(leaveType!.value.toString())
                  .split(" ")[0],
              style: AppTextStyle.style12,
            ),
          ),
      ],
    );
  }
}

Color leaveStatusColor(LeaveStatus leaveStatus, BuildContext context) {
  if (leaveStatus == LeaveStatus.approved) {
    return context.colorScheme.approveColor;
  } else if (leaveStatus == LeaveStatus.pending) {
    return context.colorScheme.textSecondary;
  }
  return context.colorScheme.rejectColor;
}

class LeaveStatusIcon extends StatelessWidget {
  final LeaveStatus status;

  const LeaveStatusIcon({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == LeaveStatus.approved) {
      return Icon(
        Icons.done_all_rounded,
        color: context.colorScheme.approveColor,
        size: 20,
      );
    } else if (status == LeaveStatus.rejected) {
      return Icon(
        Icons.clear_rounded,
        color: context.colorScheme.rejectColor,
        size: 20,
      );
    } else if (status == LeaveStatus.cancelled) {
      return Icon(
        Icons.do_disturb_rounded,
        color: context.colorScheme.rejectColor,
        size: 20,
      );
    }
    return Icon(
      Icons.query_builder,
      color: context.colorScheme.textSecondary,
      size: 20,
    );
  }
}
