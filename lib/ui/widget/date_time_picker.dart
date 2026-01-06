import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';

Future<DateTime?> pickDate({
  required BuildContext context,
  required DateTime initialDate,
}) async {
  DateTime? pickDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(1990),
    lastDate: DateTime(DateTime.now().futureDateSelectionYear),
  );
  return pickDate;
}

Future<TimeOfDay?> pickTime({
  required BuildContext context,
  required TimeOfDay initialTime,
}) async {
  TimeOfDay? time = await showTimePicker(
    context: context,
    initialTime: initialTime,
  );
  return time;
}
