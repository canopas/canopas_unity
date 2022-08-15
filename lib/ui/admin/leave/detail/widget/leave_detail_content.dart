import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/core/utils/date_string_utils.dart';

import '../../../../../model/leave/leave.dart';
import '../../../../../widget/leave_detail.dart';

class LeaveDetailContent extends StatelessWidget {
  Leave leave;
  LeaveDetailContent({Key? key, required this.leave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _localization = AppLocalizations.of(context);
    String totalDays = totalLeaves(leave.totalLeaves);
    String duration = dateInSingleLine(
        startTimeStamp: leave.startDate,
        endTimeStamp: leave.endDate,
        locale: _localization.localeName);
    String reason = leave.reason;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildFieldColumn(
              title: _localization.leave_totalDays_tag, value: totalDays),
          buildDivider(),
          buildFieldColumn(
              title: _localization.leave_duration_text, value: duration),
          buildDivider(),
          buildFieldColumn(
            title: _localization.leave_reason_tag,
            value: reason,
          ),
        ],
      ),
    );
  }
}
