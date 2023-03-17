import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:intl/intl.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';

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

  String getLeaveDurationPresentation(double totalLeaves) {
    if (totalLeaves < 1) {
      return _localization.dateFormatter_half_day;
    } else if (totalLeaves == 1) {
      return _localization.dateFormatter_one_day;
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
      {required int startTimeStamp,
      required int endTimeStamp,
      bool lastTwoLine = false}) {
    DateTime startDate = startTimeStamp.toDate;
    DateTime endDate = endTimeStamp.toDate;
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

  String timeAgoPresentation(int timeStamp) {
    DateTime dateTime = timeStamp.toDate;
    Duration difference = today.difference(dateTime);
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
