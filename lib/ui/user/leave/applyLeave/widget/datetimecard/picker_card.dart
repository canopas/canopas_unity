import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:projectunity/configs/text_style.dart';
import '../../../../../../configs/colors.dart';

class DatePickerCard extends StatelessWidget {
  final Function() onPress;
  final DateTime currentDate;

  const DatePickerCard(
      {Key? key, required this.onPress, required this.currentDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _localeName = AppLocalizations.of(context).localeName;
    return Expanded(
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: onPress,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(DateFormat.yMMMd(_localeName).format(currentDate), style: AppTextStyle.bodyTextDark),
                const FaIcon(
                  FontAwesomeIcons.calendar,
                  color: AppColors.secondaryText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TimePickerCard extends StatelessWidget {
  final TimeOfDay time;
  final VoidCallback onPress;

  const TimePickerCard({Key? key, required this.time, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: onPress,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(time.format(context), style: AppTextStyle.bodyTextDark),
                const FaIcon(
                  FontAwesomeIcons.clock,
                  color: AppColors.secondaryText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
