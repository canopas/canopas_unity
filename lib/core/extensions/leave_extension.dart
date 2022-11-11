import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/model/leave/leave.dart';
import '../utils/const/leave_time_constants.dart';

extension LeaveExtension on Leave{
  Map<DateTime, int>getDateAndDuration(){
    List<DateTime> dates = List.generate(endDate.dateOnly.difference(startDate.dateOnly).inDays, (days) => startDate.dateOnly.add(Duration(days: days)))..add(endDate.dateOnly);
    return Map<DateTime,int>.fromIterable(dates,value: (element) => perDayDuration[dates.indexOf(element)],);
  }

  bool findUserOnLeaveByDate({required DateTime day}) => (startDate.dateOnly.isBefore(day.dateOnly) || startDate.dateOnly.areSame(day.dateOnly))
      && (endDate.dateOnly.isAfter(day.dateOnly) || endDate.dateOnly.areSame(day.dateOnly)) && getDateAndDuration()[day.dateOnly] != noLeave;
}