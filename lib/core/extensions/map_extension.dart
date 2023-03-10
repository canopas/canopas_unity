import 'package:projectunity/core/extensions/date_time.dart';

import '../utils/const/leave_time_constants.dart';

extension MapExtensions on Map<DateTime, int> {
  Map<DateTime, int> getSelectedLeaveOfTheDays(
      {required DateTime startDate, required DateTime endDate}) {
    List<DateTime> dates = [];
    if (startDate.isAtSameMomentAs(endDate)) {
      dates = [startDate];
    } else if (startDate.timeStampToInt < endDate.timeStampToInt) {
      dates = List.generate(endDate.difference(startDate).inDays,
          (days) => startDate.add(Duration(days: days)))
        ..add(endDate);
    }
    for (var date in dates) {
      putIfAbsent(date.dateOnly, () => date.isWeekend ? noLeave : fullLeave);
    }
    removeWhere((key, value) => !dates.contains(key));
    return this;
  }

  double getTotalLeaveCount() {
    double totalLeaves = 0.0;
    for (int value in values) {
      if (value == fullLeave) {
        totalLeaves += 1;
      } else if (value == firstHalfLeave || value == secondHalfLeave) {
        totalLeaves += 0.5;
      }
    }
    return totalLeaves;
  }
}
