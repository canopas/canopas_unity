import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/text_style.dart';

class DatePickerCard extends StatelessWidget {
  final Function() onPress;
  Stream<DateTime> stream;

  DatePickerCard({Key? key, required this.onPress, required this.stream})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return StreamBuilder<DateTime>(
        stream: stream,
        builder: (context, snapshot) {
          return Expanded(
            child: Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: onPress,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          snapshot.data == null
                              ? ''
                              : localization.date_format_yMMMd(snapshot.data!),
                          style: AppTextStyle.bodyTextDark),
                      const Icon(
                        Icons.calendar_today,
                        color: AppColors.secondaryText,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class TimePickerCard extends StatelessWidget {
  final VoidCallback onPress;
  Stream<TimeOfDay> stream;

  TimePickerCard({Key? key, required this.stream, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TimeOfDay>(
        initialData: TimeOfDay.now(),
        stream: stream,
        builder: (context, snapshot) {
          return Expanded(
            child: Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: onPress,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          snapshot.hasError
                              ? ''
                              : snapshot.data!.format(context),
                          style: AppTextStyle.bodyTextDark),
                      const Icon(
                        Icons.access_time,
                        color: AppColors.secondaryText,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
