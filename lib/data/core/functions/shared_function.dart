import 'package:injectable/injectable.dart';
import '../../model/leave/leave.dart';

@Injectable()
class AppFunctions {
  bool isUrgentLeave({
    required DateTime startDate,
    required DateTime appliedOn,
    required double totalLeaves,
  }) {
    Duration diff = startDate.difference(appliedOn);
    if (totalLeaves <= 1 && diff.inDays >= 2) {
      return false;
    } else if (totalLeaves <= 3 && diff.inDays >= 7) {
      return false;
    } else if (totalLeaves <= 5 && diff.inDays >= 14) {
      return false;
    } else if (totalLeaves > 5 && diff.inDays >= 21) {
      return false;
    } else {
      return true;
    }
  }

  String getNotificationDuration({
    required double total,
    required LeaveDayDuration firstLeaveDayDuration,
  }) {
    if (total <= 1) {
      if (firstLeaveDayDuration == LeaveDayDuration.firstHalfLeave) {
        return "First Half";
      } else if (firstLeaveDayDuration == LeaveDayDuration.secondHalfLeave) {
        return "Second Half";
      } else if (firstLeaveDayDuration == LeaveDayDuration.fullLeave) {
        return "Full day";
      } else {
        return "$total day";
      }
    } else {
      return "$total days";
    }
  }
}
