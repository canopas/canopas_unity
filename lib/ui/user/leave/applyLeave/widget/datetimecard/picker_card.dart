import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:projectunity/configs/font_size.dart';

import '../../../../../../configs/colors.dart';

class DatePickerCard extends StatelessWidget {
  Function() onPress;
  final DateTime currentDate;

  DatePickerCard({Key? key, required this.onPress, required this.currentDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _localeName = AppLocalizations.of(context).localeName;
    return Expanded(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              DateFormat.yMMMd(_localeName).format(currentDate),
              style: const TextStyle(
                  color: AppColors.darkText, fontSize: bodyTextSize),
            ),
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.calendar,
                color: AppColors.secondaryText,
              ),
              onPressed: onPress,
            ),
          ],
        ),
      ),
    );
  }
}

class TimePickerCard extends StatelessWidget {
  final TimeOfDay time;
  VoidCallback onPress;

  TimePickerCard({Key? key, required this.time, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              time.format(context),
              style: const TextStyle(
                  color: AppColors.darkText, fontSize: bodyTextSize),
            ),
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.clock,
                color: AppColors.secondaryText,
              ),
              onPressed: onPress,
            ),
          ],
        ),
      ),
    );
  }
}
