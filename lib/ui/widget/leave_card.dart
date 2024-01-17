import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/configs/text_style.dart';
import 'package:projectunity/data/configs/theme.dart';
import '../../data/configs/colors.dart';
import '../../data/core/utils/date_formatter.dart';
import '../../data/model/leave/leave.dart';
import 'leave_card_status_view.dart';

class LeaveCard extends StatelessWidget {
  final Leave leave;
  final void Function()? onTap;

  const LeaveCard({
    Key? key,
    required this.onTap,
    required this.leave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: AppTheme.commonBorderRadius,
        boxShadow: AppTheme.commonBoxShadow,
      ),
      child: Material(
        borderRadius: AppTheme.commonBorderRadius,
        color: AppColors.whiteColor,
        child: InkWell(
          borderRadius: AppTheme.commonBorderRadius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LeaveStatusView(status: leave.status),
                    Text(
                        DateFormatter(AppLocalizations.of(context))
                            .getDatePeriodPresentation(
                                startDate: leave.startDate,
                                endDate: leave.endDate),
                        style: AppFontStyle.bodyMedium,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
                const Divider(height: 32),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            DateFormatter(AppLocalizations.of(context))
                                .dateInLine(
                                    startDate: leave.startDate,
                                    endDate: leave.endDate),
                            style: AppFontStyle.bodyMedium,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 8),
                        Text(
                          DateFormatter(AppLocalizations.of(context))
                              .getLeaveDurationPresentation(
                                  totalLeaves: leave.total,
                                  firstDayDuration: leave.perDayDuration.first)
                              .toString(),
                          style: AppFontStyle.bodySmallRegular,
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
