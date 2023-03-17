import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/space_constant.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/configs/theme.dart';

class DatePickerCard extends StatelessWidget {
  final Function() onPress;
  final String title;
  final DateTime date;

  const DatePickerCard({
    Key? key,
    required this.onPress,
    required this.title,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(primaryHalfSpacing),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppTheme.commonBorderRadius,
          boxShadow: AppTheme.commonBoxShadow),
      child: Material(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPress,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppFontStyle.labelGrey,
                    ),
                    Text(localization.date_format_yMMMd(date),
                        style: AppFontStyle.bodySmallRegular),
                  ],
                ),
                const Icon(
                  Icons.calendar_today,
                  color: AppColors.secondaryText,
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
