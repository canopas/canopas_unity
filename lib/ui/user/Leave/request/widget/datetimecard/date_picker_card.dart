import 'dart:core';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:projectunity/configs/font_size.dart';

import '../../../../../../configs/colors.dart';

class DatePickerCard extends StatefulWidget {
  final int date;

  const DatePickerCard({Key? key, required this.date}) : super(key: key);

  @override
  State<DatePickerCard> createState() => _DatePickerCardState();
}

class _DatePickerCardState extends State<DatePickerCard> {
  late int selectedDate;
  DateTime currentDate = DateTime.now();

  @override
  initState() {
    selectedDate = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              DateFormat.yMMMd().format(currentDate),
              style: const TextStyle(
                  color: AppColors.darkText, fontSize: bodyTextSize),
            ),
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.calendar,
                color: AppColors.secondaryText,
              ),
              onPressed: () async {
                DateTime? selectedLeaveDate =
                await getDate(context, selectedDate);
                String formattedDate = selectedLeaveDate.toString();
                DateTime date = DateTime.parse(formattedDate);
                int startDateToInt = date.microsecondsSinceEpoch;
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> getDate(BuildContext context, int dateInt) async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2025));
    if (selectedDate != currentDate && selectedDate != null) {
      String formattedDate = selectedDate.toString();
      DateTime date = DateTime.parse(formattedDate);
      int startDateToInt = date.microsecondsSinceEpoch;
      setState(() {
        currentDate = selectedDate;
        dateInt = startDateToInt;
      });
    }
    return selectedDate;
  }
}
