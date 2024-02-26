import 'package:flutter/cupertino.dart';
import 'package:projectunity/data/core/extensions/double_extension.dart';
import 'package:projectunity/data/model/leave_count.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/style/colors.dart';
import '../../data/configs/colors.dart';
import '../../data/configs/text_style.dart';
import '../../data/model/leave/leave.dart';

class UsedLeaveCountsView extends StatelessWidget {
  final LeaveCounts leaveCounts;

  const UsedLeaveCountsView({super.key, required this.leaveCounts});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(leaveCounts.casualLeaves.fixedAt(2).toString(),
                  style: AppFontStyle.titleDark),
              const SizedBox(height: 4),
              Text(
                AppLocalizations.of(context).leave_type_placeholder_text(
                    LeaveType.casualLeave.value.toString()),
                style: AppFontStyle.bodyMedium
                    .copyWith(color: AppColors.primaryBlue),
              )
            ],
          ),
        ),
        Container(
          height: 60,
          width: 1,
          color: containerHighColor,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(leaveCounts.urgentLeaves.fixedAt(2).toString(),
                  style: AppFontStyle.titleDark),
              const SizedBox(height: 4),
              Text(
                AppLocalizations.of(context).leave_type_placeholder_text(
                    LeaveType.urgentLeave.value.toString()),
                style: AppFontStyle.bodyMedium
                    .copyWith(color: AppColors.primaryBlue),
              )
            ],
          ),
        )
      ],
    );
  }
}
