import 'package:flutter/material.dart';

extension DateExtention on int {
  DateTime get toDate => DateTime.fromMillisecondsSinceEpoch(this);
  TimeOfDay get toTime => TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(this));
  DateTime get dateOnly => DateUtils.dateOnly(toDate);
  bool get isFirstHalf => (toTime.period == DayPeriod.am && toTime.hour > 8) ||  (toTime.period == DayPeriod.pm && toTime.hour == 12);
  bool get isSecondHalf => toTime.period == DayPeriod.pm && toTime.hour >= 1 && toTime.hour < 8;
}

extension TimestampExtension on DateTime {
  int get timeStampToInt => millisecondsSinceEpoch;

  DateTime get dateOnly => DateUtils.dateOnly(this);

  bool get isWeekend => weekday == DateTime.sunday || (weekday == DateTime.saturday && isNotForthSaturday());

  bool areSameOrUpcoming(DateTime date) =>
      DateUtils.isSameDay(date, this) || isAfter(date);

  bool isNotForthSaturday(){
    DateTime monthFirstDate = DateTime(year,month);
    List<DateTime> allDatesInMonth = List.generate(DateTime(year,month+1).difference(monthFirstDate).inDays,
            (days) => monthFirstDate.add(Duration(days: days)));
    int saturdayCount = 0;
    DateTime forthSaturdayDate = allDatesInMonth.where((date){
      if(date.weekday == DateTime.saturday){
        saturdayCount++;
        if(saturdayCount == 4){
          return true;
        }
      }
      return false;
    }).first;
    allDatesInMonth.clear();
    return !forthSaturdayDate.dateOnly.isAtSameMomentAs(dateOnly);
  }

  bool areSame(DateTime date) => DateUtils.isSameDay(date, this);
}

