import 'package:flutter/material.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/font_family.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:table_calendar/table_calendar.dart'
    show HeaderStyle, CalendarStyle;

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.primaryBlue,
      fontFamily: FontFamily.fontName,
      appBarTheme: AppBarTheme(
        titleTextStyle: AppTextStyle.appBarTitle,
        backgroundColor: AppColors.whiteColor,
        foregroundColor: AppColors.blackColor,
        elevation: 0,
      ),
      scrollbarTheme: const ScrollbarThemeData(
        radius: Radius.circular(12),
        thumbColor: MaterialStatePropertyAll(Color(0xffa0bef1)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromHeight(45),
        backgroundColor: AppColors.primaryBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        elevation: 0,
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        side: const BorderSide(color: AppColors.primaryBlue, width: 1),
        fixedSize: const Size.fromHeight(45),
      )));

  static CalendarStyle calendarStyle = CalendarStyle(
    outsideDaysVisible: false,
    weekendTextStyle: AppTextStyle.secondarySubtitle500.copyWith(fontSize: 14),
    selectedDecoration: const BoxDecoration(
        color: AppColors.primaryBlue, shape: BoxShape.circle),
    markerDecoration: const BoxDecoration(
      color: AppColors.orangeColor,
      shape: BoxShape.circle,
    ),
    todayDecoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryBlue),
        shape: BoxShape.circle),
    todayTextStyle: AppTextStyle.subtitleText.copyWith(fontSize: 14),
  );

  static HeaderStyle calendarHeaderStyle = HeaderStyle(
      formatButtonVisible: false,
      titleCentered: true,
      titleTextStyle:
          AppTextStyle.subTitleTextStyle.copyWith(fontWeight: FontWeight.w600));

  static List<BoxShadow> commonBoxShadow = [
    BoxShadow(
      color: AppColors.primaryGray.withOpacity(0.60),
      blurRadius: 3,
      offset: const Offset(0, 0),
      spreadRadius: 1,
    )
  ];

  static BorderRadius commonBorderRadius = BorderRadius.circular(12);
}
