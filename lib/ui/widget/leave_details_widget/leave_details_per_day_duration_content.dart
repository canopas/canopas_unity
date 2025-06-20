import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/model/leave/leave.dart';
import 'package:projectunity/style/app_text_style.dart';
import '../../../data/configs/space_constant.dart';
import '../../../data/l10n/app_localization.dart';

class PerDayDurationDateRange extends StatelessWidget {
  final Map<DateTime, LeaveDayDuration> perDayDurationWithDate;

  const PerDayDurationDateRange(
      {super.key, required this.perDayDurationWithDate});

  @override
  Widget build(BuildContext context) {
    return perDayDurationWithDate.length > 2
        ? SingleChildScrollView(
            padding: const EdgeInsets.all(primaryVerticalSpacing),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: perDayDurationWithDate.entries
                  .map((date) => Container(
                        padding: const EdgeInsets.all(primaryHalfSpacing),
                        margin: const EdgeInsets.symmetric(
                          horizontal: primaryVerticalSpacing,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: context.colorScheme.containerHigh),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                                DateFormat('EEE', context.l10n.localeName)
                                    .format(date.key),
                                style: AppTextStyle.style14.copyWith(
                                    color: context.colorScheme.textPrimary)),
                            Text(
                                DateFormat('d', context.l10n.localeName)
                                    .format(date.key),
                                style: AppTextStyle.style14.copyWith(
                                    color: context.colorScheme.primary,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              DateFormat('MMM', context.l10n.localeName)
                                  .format(date.key),
                              style: AppTextStyle.style14.copyWith(
                                  color: context.colorScheme.textPrimary),
                            ),
                            const SizedBox(
                              height: primaryVerticalSpacing,
                            ),
                            Container(
                              constraints: const BoxConstraints(
                                maxWidth: 150,
                              ),
                              alignment: Alignment.center,
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.26,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: context.colorScheme.containerHigh),
                              ),
                              child: Text(AppLocalizations.of(context)
                                  .leave_day_duration_tag(date.value.name)),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
                children: perDayDurationWithDate.entries
                    .map((date) => Container(
                        padding: const EdgeInsets.all(primaryHalfSpacing),
                        margin: const EdgeInsets.symmetric(
                          vertical: primaryHalfSpacing,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: context.colorScheme.containerHigh),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(
                                DateFormat('EEEE, ', context.l10n.localeName)
                                    .format(date.key),
                                style: AppTextStyle.style14.copyWith(
                                    color: context.colorScheme.textPrimary)),
                            Text(
                              DateFormat('d ', context.l10n.localeName)
                                  .format(date.key),
                              style: AppTextStyle.style14.copyWith(
                                  color: context.colorScheme.primary,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat('MMMM', context.l10n.localeName)
                                  .format(date.key),
                              style: AppTextStyle.style14.copyWith(
                                  color: context.colorScheme.textPrimary),
                            ),
                            const Spacer(),
                            Container(
                              constraints: const BoxConstraints(
                                maxWidth: 150,
                              ),
                              alignment: Alignment.center,
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.26,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: context.colorScheme.containerHigh),
                              ),
                              child: Text(
                                context.l10n
                                    .leave_day_duration_tag(date.value.name),
                                style: AppTextStyle.style14.copyWith(
                                    color: context.colorScheme.textPrimary),
                              ),
                            )
                          ],
                        )))
                    .toList()),
          );
  }
}
