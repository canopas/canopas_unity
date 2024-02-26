import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String toDate() {
    return DateFormat("dd MMMM, yyyy").format(this);
  }
  String toMonthYear() {
    return DateFormat("MMMM, yyyy").format(this);
  }
}
