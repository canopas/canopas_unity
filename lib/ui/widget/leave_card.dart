import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/data/configs/theme.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
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
      decoration: BoxDecoration(
        color: context.colorScheme.containerLow,
        borderRadius: AppTheme.commonBorderRadius,
      ),
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
                      style: AppTextStyle.style16
                          .copyWith(color: context.colorScheme.textPrimary),
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
                          style: AppTextStyle.style16
                              .copyWith(color: context.colorScheme.textPrimary),
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 8),
                      Text(
                        DateFormatter(AppLocalizations.of(context))
                            .getLeaveDurationPresentation(
                                totalLeaves: leave.total,
                                firstDayDuration: leave.perDayDuration.first)
                            .toString(),
                        style: AppTextStyle.style14
                            .copyWith(color: context.colorScheme.textPrimary),
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
    );
  }
}
