import 'package:flutter/material.dart';

extension DateExtention on int {
  DateTime get toDate => DateTime.fromMillisecondsSinceEpoch(this);
  TimeOfDay get toTime => TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(this));
  DateTime get dateOnly => DateUtils.dateOnly(toDate);
}

extension TimestampExtension on DateTime {
  int get timeStampToInt => millisecondsSinceEpoch;

  DateTime get dateOnly => DateUtils.dateOnly(this);

  bool areSameOrUpcoming(DateTime date) =>
      DateUtils.isSameDay(date, this) || isAfter(date);
}


