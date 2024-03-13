import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';

extension DateExtension on DateTime {
  String toDateWithYear() {
    return DateFormat("dd MMMM, yyyy").format(this);
  }

  String toMonthYear() {
    return DateFormat("MMMM, yyyy").format(this);
  }
  String toDateWithoutYear(BuildContext context) {
    final today= DateUtils.dateOnly(DateTime.now());
    if(isAtSameMomentAs(today)){
      return context.l10n.dateFormatter_today;
    }
    return DateFormat("MMMM d, EEE").format(this);
  }
}
