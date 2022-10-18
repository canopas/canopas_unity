import 'package:flutter/material.dart';

Future<DateTime?> pickDate(
    {required BuildContext context,
    required DateTime initialDate,
    bool onlyFutureDateSelection = false}) async {
  DateTime? pickDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2022),
    lastDate: DateTime(2025),
    selectableDayPredicate: (day) => onlyFutureDateSelection
        ? day.isAfter(DateTime.now().subtract(const Duration(days: 1)))
        : true,
  );
  return pickDate;
}

Future<TimeOfDay?> pickTime(
    {required BuildContext context, required TimeOfDay initialTime}) async {
  TimeOfDay? time =
      await showTimePicker(context: context, initialTime: initialTime);
  return time;
}