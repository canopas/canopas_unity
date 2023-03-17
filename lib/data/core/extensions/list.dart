import 'package:projectunity/data/core/extensions/date_time.dart';
import '../../model/leave_application.dart';

extension ListExtention on List<LeaveApplication> {
  void sortedByDate() {
    return sort(
        (a, b) => b.leave.appliedOn.toDate.compareTo(a.leave.appliedOn.toDate));
  }
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}
