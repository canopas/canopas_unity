import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/style/colors.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../../data/core/utils/date_formatter.dart';
import '../../../../../data/model/leave/leave.dart';

class AdminLeaveRequestDetailsDateContent extends StatelessWidget {
  final Leave leave;

  const AdminLeaveRequestDetailsDateContent({Key? key, required this.leave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String totalDays = DateFormatter(AppLocalizations.of(context))
        .getLeaveDurationPresentationLong(leave.total);
    String duration = DateFormatter(AppLocalizations.of(context))
        .dateInLine(startDate: leave.startDate, endDate: leave.endDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(duration, style:AppTextStyle.style16),
        const SizedBox(height: 8),
        Text(
          totalDays,
          style:
          AppTextStyle.style16.copyWith(color: primaryLightColor),
        ),
      ],
    );
  }
}
