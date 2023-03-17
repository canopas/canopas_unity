import 'package:flutter/material.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/space_constant.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:table_calendar/table_calendar.dart'
    show HeaderStyle, CalendarStyle;

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
        fontFamily: 'inter',
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.whiteColor,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.blackColor,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: AppFontStyle.appbarHeaderDark),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.whiteColor,
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryBlue,
          unselectedItemColor: AppColors.secondaryText,
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.dividerColor,
          indent: primaryHorizontalSpacing,
          endIndent: primaryHorizontalSpacing,
          thickness: 1,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromHeight(45),
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 0,
        )),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: AppColors.whiteColor,
          backgroundColor: AppColors.primaryBlue,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          side: const BorderSide(color: AppColors.primaryBlue, width: 1),
          fixedSize: const Size.fromHeight(45),
        )),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.lightPrimaryBlue,
        ),
        scrollbarTheme: const ScrollbarThemeData(
          radius: Radius.circular(12),
          thumbColor: MaterialStatePropertyAll(Color(0xffa0bef1)),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryBlue,
                textStyle: AppFontStyle.buttonTextStyle)),
        textTheme: const TextTheme(
            headlineLarge: AppFontStyle.headerGrey,
            titleLarge: AppFontStyle.labelRegular,
            bodyLarge: AppFontStyle.bodyLarge,
            bodyMedium: AppFontStyle.bodySmallHeavy));
  }

  static CalendarStyle calendarStyle = CalendarStyle(
    outsideDaysVisible: false,
    weekendTextStyle: AppFontStyle.bodySmallHeavy,
    selectedDecoration: const BoxDecoration(
        color: AppColors.primaryBlue, shape: BoxShape.circle),
    markerDecoration: const BoxDecoration(
      color: AppColors.orangeColor,
      shape: BoxShape.circle,
    ),
    todayDecoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryBlue),
        shape: BoxShape.circle),
    todayTextStyle: AppFontStyle.bodySmallRegular,
  );

  static HeaderStyle calendarHeaderStyle = HeaderStyle(
      formatButtonVisible: false,
      titleCentered: true,
      titleTextStyle:
          AppFontStyle.labelRegular.copyWith(fontWeight: FontWeight.w500));

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
