import 'package:flutter/material.dart';
import '../../data/configs/colors.dart';
import '../../data/configs/text_style.dart';
import '../../data/core/utils/const/leave_map.dart';
import '../../data/model/leave/leave.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: leaveStatusColor(status),
      ),
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      child: Row(
        children: [
          LeaveStatusIcon(status: status),
          const SizedBox(width: 5),
          Text(
            AppLocalizations.of(context)
                .leave_status_placeholder_text(status.value.toString()),
            style: AppFontStyle.labelRegular,
          ),
        ],
      ),
    );
  }
}

class LeaveStatusIcon extends StatelessWidget {
  final LeaveStatus status;

  const LeaveStatusIcon({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == LeaveStatus.approved) {
      return const Icon(Icons.done_all_rounded,
          color: AppColors.greenColor, size: 20);
    } else if (status == LeaveStatus.rejected) {
      return const Icon(Icons.clear_rounded,
          color: AppColors.redColor, size: 20);
    } else if (status == LeaveStatus.cancelled) {
      return const Icon(Icons.do_disturb_rounded,
          color: AppColors.redColor, size: 20);
    }
    return const Icon(Icons.query_builder,
        color: AppColors.blackColor, size: 20);
  }
}
