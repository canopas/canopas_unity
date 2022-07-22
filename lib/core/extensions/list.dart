import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/model/leave/leave_request_data.dart';

extension ListExtention on List<LeaveRequestData> {
  void sortedByDate() {
    return sort((a, b) => (b.appliedOn.toDate).compareTo(a.appliedOn.toDate));
  }
}
