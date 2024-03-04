import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import '../../style/app_text_style.dart';
import '../../style/colors.dart';
import 'package:table_calendar/table_calendar.dart'
    show  CalendarStyle;

class AppTheme {
  static CalendarStyle calendarStyle(BuildContext context) => CalendarStyle(
        outsideDaysVisible: false,
        weekendTextStyle: AppTextStyle.style14,
        selectedDecoration: BoxDecoration(
            color: context.colorScheme.primary, shape: BoxShape.circle),
        markerDecoration: BoxDecoration(
          color: context.colorScheme.primaryInverseColor,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.primary),
          shape: BoxShape.circle,
        ),
        todayTextStyle: AppTextStyle.style14,
      );

  static List<BoxShadow> commonBoxShadow = [
    BoxShadow(
      color: outlineColor.withOpacity(0.60),
      blurRadius: 3,
      offset: const Offset(0, 0),
      spreadRadius: 1,
    )
  ];

  static BorderRadius commonBorderRadius = BorderRadius.circular(12);
}
