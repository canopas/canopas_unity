import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectunity/core/extensions/date_time.dart';

String dateDoubleLine(
    {required int startDate, required int endDate, required String locale}) {
  DateTime startLeaveDate = startDate.toDate;
  DateTime endLeaveDate = endDate.toDate;

  String startLeaveday = DateFormat.d(locale).format(startLeaveDate);
  String endLeaveDay = DateFormat.d(locale).format(endLeaveDate);

  if (startLeaveDate.month == endLeaveDate.month) {
    String month = DateFormat.MMM(locale).format(endLeaveDate);
    if (startLeaveDate.day == endLeaveDate.day) {
      return '$startLeaveday\n$month';
    }
    return '$startLeaveday-$endLeaveDay\n$month';
  }
  String startMonth = DateFormat.MMM(locale).format(startLeaveDate);
  String endMonth = DateFormat.MMM(locale).format(endLeaveDate);
  return '$startLeaveday  $startMonth\n to \n$endLeaveDay $endMonth ';
}

String dateInSingleLine(
    {required int startTimeStamp,
    required int endTimeStamp,
    required String locale}) {
  DateTime startDate = startTimeStamp.toDate;
  DateTime endDate = endTimeStamp.toDate;

  String startLeaveDay = DateFormat.d(locale).format(startDate);
  String endLeaveDay = DateFormat.d(locale).format(endDate);
  if (startDate.year == endDate.year) {
    if (startDate.month == endDate.month) {
      String month = DateFormat.MMM(locale).format(endDate);
      if (startDate.day == endDate.day) {
        return '$startLeaveDay $month';
      }
      return '$startLeaveDay - $endLeaveDay  $month';
    }
    return '${startDate.day} ${DateFormat.MMM(locale).format(startDate)} - ${endDate.day} ${DateFormat.MMM(locale).format(endDate)}';
  }
  return '${startDate.dateToString(locale)} to ${endDate.dateToString(locale)}';
}

String dateToDayMonth({required DateTime date, required String locale}){
   DateTime todayDate = DateUtils.dateOnly(DateTime.now());
  if(date == todayDate){
    return "Today";
  } else if(date == todayDate.subtract(const Duration(days: 1))){
    return "Yesterday";
  } else {
    return "${date.day} ${DateFormat.MMMM(locale).format(date)}";
  }
}

String totalLeaves(double days) {
  if (days <= 1) {
    return '$days Day';
  }
  return '${days.toInt()} Days';
}

String daysFinder(double days) {
  if (days < 1) {
    int hours = (days*24).toInt();
    return '$hours ${(hours <= 1)?"Hour":"Hours"}';
  } else if(days - days.toInt() != 0.0){
    int hours = ((days - days.toInt())*24).toInt();
      return '${days.toInt()} ${(days.toInt() <= 1)?"Day":"Days"} $hours ${(hours <= 1)?"Hour":"Hours"}';
  }
  return '${days.toInt()} Days';
}

String getLeaveStatus(int status, Map map) {
  String leaveStatus = "";
  for (int key in map.keys) {
    if (key == status) leaveStatus = map[status];
  }
  return leaveStatus;
}
