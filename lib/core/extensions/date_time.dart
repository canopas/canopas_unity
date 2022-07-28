import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

extension DateExtention on int {
  DateTime get toDate => DateTime.fromMillisecondsSinceEpoch(this);
}

extension DateFormation on DateTime {
  String get dateToString => DateFormat.yMMMd().format(this);
}

extension TimestampExtension on DateTime {
  int get timeStampToInt => Timestamp.fromDate(this).millisecondsSinceEpoch;
}
