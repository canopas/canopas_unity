import 'package:intl/intl.dart';
import 'package:projectunity/core/extensions/date_time.dart';

String dateInDoubleLine(DateTime startDate, DateTime endDate) {
  if (startDate.month == endDate.month) {
    String month = DateFormat.MMM().format(endDate);
    if (startDate.day == endDate.day) {
      return '${startDate.day}\n$month';
    }
    return '${startDate.day} - ${endDate.day}\n$month';
  }
  return '${startDate.dateToString()}\n to \n${endDate.dateToString()}';
}

String dateInSingleLine(DateTime startDate, DateTime endDate) {
  String year = DateFormat.y().format(endDate);
  if (startDate.month == endDate.month) {
    String month = DateFormat.MMM().format(endDate);

    if (startDate.day == endDate.day) {
      return '${startDate.day} $month, $year';
    }
    return '${startDate.day} - ${endDate.day}  $month, $year';
  }
  return '${startDate.dateToString()} to ${endDate.dateToString()}, $year';
}

String totalLeaves(double days) {
  if (days <= 1) {
    return '$days Day';
  }
  return '$days Days';
}

String? getLeaveStatus(int status, Map map) {
  String? leaveStatus;
  for (int key in map.keys) {
    if (key == status) leaveStatus = map[status];
  }
  return leaveStatus;
}
