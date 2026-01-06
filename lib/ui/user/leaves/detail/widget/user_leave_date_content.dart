import 'package:flutter/cupertino.dart';
import 'package:projectunity/data/l10n/app_localization.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../../data/core/utils/date_formatter.dart';
import '../../../../../data/model/leave/leave.dart';

class UserLeaveRequestDateContent extends StatelessWidget {
  final Leave leave;

  const UserLeaveRequestDateContent({super.key, required this.leave});

  @override
  Widget build(BuildContext context) {
    String totalDays = DateFormatter(
      AppLocalizations.of(context),
    ).getLeaveDurationPresentationLong(leave.total);
    String duration = DateFormatter(
      AppLocalizations.of(context),
    ).dateInLine(startDate: leave.startDate, endDate: leave.endDate);

    return Container(
      padding: const EdgeInsets.all(primaryHorizontalSpacing),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: AppTheme.commonBorderRadius,
        boxShadow: AppTheme.commonBoxShadow(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(duration, style: AppTextStyle.style18),
          const SizedBox(height: 10),
          Text(
            totalDays,
            style: AppTextStyle.style14.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
