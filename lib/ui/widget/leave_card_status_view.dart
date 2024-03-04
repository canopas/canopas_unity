import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import '../../data/configs/colors.dart';
import '../../data/configs/text_style.dart';
import '../../data/model/leave/leave.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../style/colors.dart';

class LeaveStatusView extends StatelessWidget {
  final double verticalPadding;
  final double horizontalPadding;
  final LeaveStatus status;

  const LeaveStatusView(
      {Key? key,
      required this.status,
      this.verticalPadding = 4,
      this.horizontalPadding = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LeaveStatusIcon(status: status),
        const SizedBox(width: 5),
        Text(
          context.l10n.leave_status_placeholder_text(
            status.value.toString(),
          ),
          style: AppTextStyle.style16.copyWith(color: leaveStatusColor(status)),
        ),
      ],
    );
  }
}

Color leaveStatusColor(LeaveStatus leaveStatus) {
  if (leaveStatus == LeaveStatus.approved) {
    return approveLeaveColor;
  } else if (leaveStatus == LeaveStatus.pending) {
    return textDisabledColor;
  }
  return rejectLeaveColor;
}

class LeaveStatusIcon extends StatelessWidget {
  final LeaveStatus status;

  const LeaveStatusIcon({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == LeaveStatus.approved) {
      return const Icon(Icons.done_all_rounded,
          color: approveLeaveColor, size: 20);
    } else if (status == LeaveStatus.rejected) {
      return const Icon(Icons.clear_rounded, color: rejectLeaveColor, size: 20);
    } else if (status == LeaveStatus.cancelled) {
      return const Icon(Icons.do_disturb_rounded,
          color: rejectLeaveColor, size: 20);
    }
    return const Icon(Icons.query_builder,
        color: textDisabledColor, size: 20);
  }
}
