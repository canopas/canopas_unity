import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../configs/colors.dart';

DateTime timeStampToDate(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return dateTime;
}

String getLeaveString(DateTime startDate, DateTime endDate) {
  String formattedStartDate = DateFormat.yMMM().format(startDate);
  String formattedEndDate = DateFormat.yMMM().format(endDate);
  if (startDate.month == endDate.month) {
    String month = DateFormat.MMM().format(endDate);
    return '${startDate.day} - ${endDate.day}\n$month';
  }
  return '$formattedStartDate\n to \n$formattedEndDate';
}

class BuildLeaveDateContainer extends StatelessWidget {
  const BuildLeaveDateContainer(
      {Key? key,
      required this.startDate,
      required this.endDate,
      required this.color})
      : super(key: key);

  final int startDate;
  final int endDate;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10), bottomRight: Radius.circular(10))),
      height: 140,
      width: 50,
      child: Center(
          child: Text(
            getLeaveString(timeStampToDate(startDate), timeStampToDate(endDate)),
        style: TextStyle(
            color: color == AppColors.blackColor
                ? AppColors.whiteColor
                : AppColors.darkText,
            fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      )),
    );
  }
}
