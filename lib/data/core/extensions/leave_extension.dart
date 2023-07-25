import 'date_time.dart';
import '../../model/leave/leave.dart';

extension LeaveExtension on Leave {
  Map<DateTime, LeaveDayDuration> getDateAndDuration() {
    List<DateTime> dates = List.generate(
        endDate.dateOnly.difference(startDate.dateOnly).inDays,
        (days) => startDate.dateOnly.add(Duration(days: days)))
      ..add(endDate.dateOnly);
    return Map<DateTime, LeaveDayDuration>.fromIterable(dates,
        value: (date) => perDayDuration[dates.indexOf(date)]);
  }

  bool findUserOnLeaveByDate({required DateTime day}) =>
      (startDate.dateOnly.isBefore(day.dateOnly) ||
          startDate.dateOnly.areSame(day.dateOnly)) &&
      (endDate.dateOnly.isAfter(day.dateOnly) ||
          endDate.dateOnly.areSame(day.dateOnly)) &&
      getDateAndDuration()[day.dateOnly] != LeaveDayDuration.noLeave;
}
