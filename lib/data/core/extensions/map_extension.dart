import '../../model/leave/leave.dart';
import 'date_time.dart';

extension MapExtensions on Map<DateTime, LeaveDayDuration> {
  Map<DateTime, LeaveDayDuration> getSelectedLeaveOfTheDays({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    List<DateTime> dates = [];
    if (startDate.isAtSameMomentAs(endDate)) {
      dates = [startDate];
    } else if (startDate.isBefore(endDate)) {
      dates = List.generate(
        endDate.difference(startDate).inDays,
        (days) => startDate.add(Duration(days: days)),
      )..add(endDate);
    }
    for (var date in dates) {
      putIfAbsent(date.dateOnly, () => date.getLeaveDayDuration());
    }
    removeWhere((key, value) => !dates.contains(key));
    return this;
  }

  double getTotalLeaveCount() {
    double totalLeaves = 0.0;
    for (LeaveDayDuration value in values) {
      if (value == LeaveDayDuration.fullLeave) {
        totalLeaves += 1;
      } else if (value == LeaveDayDuration.firstHalfLeave ||
          value == LeaveDayDuration.secondHalfLeave) {
        totalLeaves += 0.5;
      }
    }
    return totalLeaves;
  }
}
