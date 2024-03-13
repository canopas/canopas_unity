import 'package:flutter/material.dart';
import '../../model/leave/leave.dart';

extension DateExtention on int {
  DateTime get toDate => DateTime.fromMillisecondsSinceEpoch(this);

  TimeOfDay get toTime =>
      TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(this));

  DateTime get dateOnly => DateUtils.dateOnly(toDate);

  bool get isFirstHalf => toTime.hour >= 8 && toTime.hour < 13;

  bool get isSecondHalf => toTime.hour >= 13 && toTime.hour <= 18;
}

extension TimestampExtension on DateTime {
  int get futureDateSelectionYear => year + 2;

  bool isDateInCurrentWeek(DateTime currentDate) =>
      month == currentDate.month &&
      day >= currentDate.day &&
      day <=
          currentDate
              .add(Duration(days: DateTime.daysPerWeek - currentDate.weekday))
              .day;

  bool isBeforeOrSame(DateTime date) =>
      isBefore(date) || isAtSameMomentAs(date);

  bool isAfterOrSame(DateTime date) => isBefore(date) || isAtSameMomentAs(date);

  int get timeStampToInt => millisecondsSinceEpoch;

  DateTime get dateOnly => DateUtils.dateOnly(this);

  DateTime convertToUpcomingDay() {
    DateTime now = DateUtils.dateOnly(DateTime.now());
    DateTime targetDate = DateUtils.dateOnly(DateTime(now.year, month, day));
    if (targetDate.areSameOrUpcoming(now)) {
      return targetDate;
    } else {
      return DateUtils.dateOnly(DateTime(now.year + 1, month, day));
    }
  }

  bool get isWeekend =>
      weekday == DateTime.sunday || weekday == DateTime.saturday;

  LeaveDayDuration getLeaveDayDuration() => isWeekend
      ? isNotForthSaturday()
          ? LeaveDayDuration.noLeave
          : LeaveDayDuration.firstHalfLeave
      : LeaveDayDuration.fullLeave;

  bool isNotForthSaturday() {
    DateTime monthFirstDate = DateTime(year, month);
    List<DateTime> allDatesInMonth = List.generate(
        DateTime(year, month + 1).difference(monthFirstDate).inDays,
        (days) => monthFirstDate.add(Duration(days: days)));
    int saturdayCount = 0;
    DateTime forthSaturdayDate = allDatesInMonth.where((date) {
      if (date.weekday == DateTime.saturday) {
        saturdayCount++;
        if (saturdayCount == 4) {
          return true;
        }
      }
      return false;
    }).first;
    allDatesInMonth.clear();
    return !forthSaturdayDate.dateOnly.isAtSameMomentAs(dateOnly);
  }

  bool areSameOrUpcoming(DateTime date) =>
      DateUtils.isSameDay(date, this) || isAfter(date);

  bool areSame(DateTime date) => DateUtils.isSameDay(date, this);
}
