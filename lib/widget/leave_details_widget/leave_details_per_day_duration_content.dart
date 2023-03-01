import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:intl/intl.dart';

import '../../configs/colors.dart';
import '../../configs/space_constant.dart';
import '../../configs/text_style.dart';
import '../../configs/theme.dart';
import '../../core/utils/const/leave_time_constants.dart';

class PerDayDurationDateRange extends StatelessWidget {
  final Map<DateTime, int> perDayDurationWithDate;
  const PerDayDurationDateRange(
      {Key? key, required this.perDayDurationWithDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return perDayDurationWithDate.length > 2
        ? SingleChildScrollView(
            padding: const EdgeInsets.all(primaryVerticalSpacing),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: perDayDurationWithDate.entries
                  .map((date) => Container(
                        padding: const EdgeInsets.all(primaryHalfSpacing),
                        margin: const EdgeInsets.symmetric(
                            horizontal: primaryVerticalSpacing),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          boxShadow: AppTheme.commonBoxShadow,
                          borderRadius: AppTheme.commonBorderRadius,
                        ),
                        child: Column(
                          children: [
                            Text(
                              DateFormat('EEE', localization.localeName)
                                  .format(date.key),
                            ),
                            Text(
                              DateFormat('d', localization.localeName)
                                  .format(date.key),
                              style: AppFontStyle.titleDark.copyWith(
                                color: AppColors.primaryBlue,
                              ),
                            ),
                            Text(
                              DateFormat('MMM', localization.localeName)
                                  .format(date.key),
                            ),
                            const SizedBox(
                              height: primaryVerticalSpacing,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.width * 0.12,
                              width: MediaQuery.of(context).size.width * 0.26,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: AppColors.primaryGray),
                              ),
                              child: Text(dayLeaveTime[date.value].toString()),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          )
        : Column(
            children: perDayDurationWithDate.entries
                .map((date) => Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(primaryHalfSpacing),
                    margin: const EdgeInsets.symmetric(
                        vertical: primaryHalfSpacing,
                        horizontal: primarySpacing),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      boxShadow: AppTheme.commonBoxShadow,
                      borderRadius: AppTheme.commonBorderRadius,
                    ),
                    child: Row(
                      children: [
                        Text(
                            DateFormat('EEEE, ', localization.localeName)
                                .format(date.key),
                            style: AppFontStyle.bodySmallRegular),
                        Text(
                          DateFormat('d ', localization.localeName)
                              .format(date.key),
                          style: AppFontStyle.bodySmallRegular.copyWith(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('MMMM', localization.localeName)
                              .format(date.key),
                          style: AppFontStyle.bodySmallRegular,
                        ),
                        const Spacer(),
                        Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.width * 0.12,
                          width: MediaQuery.of(context).size.width * 0.26,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.primaryGray),
                          ),
                          child: Text(dayLeaveTime[date.value].toString()),
                        )
                      ],
                    )))
                .toList());
  }
}
