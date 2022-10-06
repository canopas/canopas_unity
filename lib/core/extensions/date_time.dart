import 'package:cloud_firestore/cloud_firestore.dart';

extension DateExtention on int {
  DateTime get toDate => DateTime.fromMillisecondsSinceEpoch(this);
}


extension TimestampExtension on DateTime {
  int get timeStampToInt => millisecondsSinceEpoch;
}


