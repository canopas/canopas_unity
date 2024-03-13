import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:intl/intl.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/model/leave/leave.dart';

class DateFormatter {
  final AppLocalizations _localization;

  DateFormatter(this._localization);

  final today = DateTime.now();
  Duration oneDay = const Duration(days: 1);
  Duration twoDay = const Duration(days: 2);

  String getDateRepresentation(DateTime dt) {
    if (today.dateOnly.isAtSameMomentAs(dt.dateOnly)) {
      return _localization.dateFormatter_today;
    } else if (today.subtract(oneDay).dateOnly.isAtSameMomentAs(dt.dateOnly)) {
      return _localization.dateFormatter_yesterday;
    } else if (today.add(oneDay).dateOnly.isAtSameMomentAs(dt.dateOnly)) {
      return _localization.dateFormatter_tomorrow;
    }
    return _localization.date_format_yMMMd(dt);
  }

  String getLeaveDurationPresentation(
      {required double totalLeaves,
      required LeaveDayDuration firstDayDuration}) {
    if (totalLeaves < 1 &&
        firstDayDuration == LeaveDayDuration.firstHalfLeave) {
      return _localization.dateFormatter_first_half_day;
    } else if (totalLeaves < 1 &&
        firstDayDuration == LeaveDayDuration.secondHalfLeave) {
      return _localization.dateFormatter_second_half_day;
    } else if (totalLeaves == 1) {
      return _localization.dateFormatter_full_day;
    }
    return _localization.dateFormatter_placeholder_other_days(totalLeaves);
  }

  String getLeaveDurationPresentationLong(double totalLeaves) {
    if (totalLeaves == 0) {
      return _localization.date_formatter_leave_request_total_zero_day_text;
    } else if (totalLeaves < 1) {
      return _localization.date_formatter_leave_request_total_half_day_text;
    } else if (totalLeaves == 1) {
      return _localization.date_formatter_leave_request_total_one_day_text;
    }
    return _localization
        .date_formatter_leave_request_total_days_text(totalLeaves);
  }

  String dateInLine(
      {required DateTime startDate,
      required DateTime endDate,
      bool lastTwoLine = false}) {
    String localeName = _localization.localeName;

    String startLeaveDay = DateFormat.d(localeName).format(startDate);
    String endLeaveDay = DateFormat.d(localeName).format(endDate);
    if (startDate.year == endDate.year) {
      if (startDate.month == endDate.month) {
        String month = DateFormat.MMM(localeName).format(endDate);
        if (startDate.day == endDate.day) {
          return '$startLeaveDay $month';
        }
        return '$startLeaveDay - $endLeaveDay  $month';
      }
      return '${startDate.day} ${DateFormat.MMM(localeName).format(startDate)} - ${endDate.day} ${DateFormat.MMM(localeName).format(endDate)}';
    }
    if (lastTwoLine) {
      return '${_localization.date_format_yMMMd(startDate)} -\n ${_localization.date_format_yMMMd(endDate)}';
    }
    return '${_localization.date_format_yMMMd(startDate)} - ${_localization.date_format_yMMMd(endDate)}';
  }

  String getDatePeriodPresentation(
      {required DateTime startDate, required DateTime endDate}) {
    final currentDate = DateTime.now().dateOnly;
    if (endDate.dateOnly.isBefore(currentDate)) {
      return _localization.past_tag;
    } else if (startDate.dateOnly.isAfter(currentDate)) {
      return _localization.upcoming_tag;
    } else {
      return _localization.recent_tag;
    }
  }

  String showBirthdays({required DateTime dateTime, required String name}) {
    final today = DateTime.now().dateOnly;
    if (dateTime.dateOnly.isAtSameMomentAs(today)) {
      return _localization.present_birthday_text(name);
    } else {
      return "${_localization.upcoming_birthday_text(name)} ${getDateRepresentation(dateTime).toLowerCase()}!🎂🎁";
    }
  }

  String showAnniversaries(
      {required DateTime dateTime, required String name, int? number}) {
    final today = DateTime.now().dateOnly;
    final difference = dateTime.difference(today);
    int yearDifference = (difference.inDays / 365).floor();
    if (dateTime.dateOnly.isAtSameMomentAs(today)) {
      return _localization.present_anniversary_text(name, yearDifference);
    } else {
      return "${_localization.upcoming_anniversary_text(name, yearDifference)} ${getDateRepresentation(dateTime)}!🎉";
    }
  }

  String timeAgoPresentation(DateTime date) {
    Duration difference = today.difference(date);
    if (difference.inDays > 365) {
      return "${(difference.inDays / 365).floor()} ${(difference.inDays / 365).floor() == 1 ? _localization.year_ago_tag : _localization.years_ago_tag} ";
    }
    if (difference.inDays > 30) {
      return "${(difference.inDays / 30).floor()} ${(difference.inDays / 30).floor() == 1 ? _localization.month_ago_tag : _localization.months_ago_tag}";
    }
    if (difference.inDays > 7) {
      return "${(difference.inDays / 7).floor()} ${(difference.inDays / 7).floor() == 1 ? _localization.week_ago_tag : _localization.weeks_ago_tag} ";
    }
    if (difference.inDays > 0) {
      return "${difference.inDays} ${difference.inDays == 1 ? _localization.day_ago_tag : _localization.days_ago_tag}";
    }
    if (difference.inHours > 0) {
      return "${difference.inHours} ${difference.inHours == 1 ? _localization.hour_ago_tag : _localization.hours_ago_tag} ";
    }
    if (difference.inMinutes > 0) {
      return "${difference.inMinutes} ${difference.inMinutes == 1 ? _localization.minute_ago_tag : _localization.minutes_ago_tag} ";
    }
    return _localization.dateFormatter_just_now;
  }
}
