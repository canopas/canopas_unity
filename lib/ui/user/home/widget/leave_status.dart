import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';
import '../../../../model/employee_leave_count/employee_leave_count.dart';

class LeaveStatus extends StatelessWidget {
   const LeaveStatus({Key? key, required this.leaveCounts}) : super(key: key);

  final LeaveCounts leaveCounts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
          color: AppColors.primaryDarkYellow,
          elevation: 8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LeaveInfo(
                    title: AppLocalizations.of(context).user_home_available_tag,
                    counts: leaveCounts.availableLeaveCount,
                  ),
                  Container(
                    width: 1,
                    color: Colors.grey,
                  ),
                  LeaveInfo(title: AppLocalizations.of(context).user_home_all_tag, counts: leaveCounts.allLeaveCount),
                  Container(
                    width: 1,
                    color: AppColors.secondaryText,
                  ),
                  LeaveInfo(title: AppLocalizations.of(context).user_home_used_tag, counts: leaveCounts.usedLeaveCount),
                ],
              ),
            ),
          )),
    );
  }
}

class LeaveInfo extends StatelessWidget {
  final String title;
  final int counts;

  const LeaveInfo({Key? key, required this.title, required this.counts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTextStyle.leaveStatusCardTitle,
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          AppLocalizations.of(context).days_placeholder_leave(counts),
          style: AppTextStyle.subTitleTextStyle,
        )
      ],
    );
  }
}
