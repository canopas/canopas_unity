import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/model/leave/leave.dart';

extension ListExtention on List<Leave> {
  void sortedByDate() {
    return sort((a, b) => (b.appliedOn.toDate).compareTo(a.appliedOn.toDate));
  }
}
