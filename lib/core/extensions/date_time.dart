import 'package:intl/intl.dart';

extension DateExtention on int {
  DateTime toDate() {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }
}

extension DateFormation on DateTime {
  String dateToString() => DateFormat.yMMM().format(this);
}
