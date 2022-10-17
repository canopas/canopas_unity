import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/model/leave/leave.dart';

import '../../model/leave_application.dart';

extension ListExtention on List<Leave> {
  void sortedByDate() {
    return sort((a, b) => (b.appliedOn.toDate).compareTo(a.appliedOn.toDate));
  }
}

extension SortedExtension on Map<DateTime, List<LeaveApplication>> {
  Map<DateTime, List<LeaveApplication>> sortedLeaveApplicationMap() {
    return Map.fromEntries(
        entries.toList()..sort((e1, e2) => e2.key.compareTo(e1.key)));
  }
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}
