import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import '../../style/app_text_style.dart';
import 'package:table_calendar/table_calendar.dart'
    show CalendarStyle, DaysOfWeekStyle;

class AppTheme {
  static CalendarStyle calendarStyle(BuildContext context) => CalendarStyle(
        outsideDaysVisible: false,
        defaultTextStyle: AppTextStyle.style16
            .copyWith(color: context.colorScheme.textPrimary),
        weekendTextStyle: AppTextStyle.style14
            .copyWith(color: context.colorScheme.textSecondary),
        selectedDecoration: BoxDecoration(
            color: context.colorScheme.primary, shape: BoxShape.circle),
        markerDecoration: BoxDecoration(
          color: context.colorScheme.tertiary,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.primary),
          shape: BoxShape.circle,
        ),
        todayTextStyle: AppTextStyle.style14
            .copyWith(color: context.colorScheme.textSecondary),
      );

  static DaysOfWeekStyle daysOfWeekStyle(BuildContext context) =>
      DaysOfWeekStyle(
          weekdayStyle: AppTextStyle.style16.copyWith(color: context.colorScheme.textSecondary),
        weekendStyle: AppTextStyle.style16.copyWith(color: context.colorScheme.textDisable),
      );

  static List<BoxShadow> commonBoxShadow(BuildContext context) => [
        BoxShadow(
          color: context.colorScheme.outlineColor,
          blurRadius: 3,
          offset: const Offset(0, 0),
          spreadRadius: 1,
        )
      ];

  static BorderRadius commonBorderRadius = BorderRadius.circular(12);
}
