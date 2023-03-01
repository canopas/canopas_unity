import 'package:flutter/material.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/font_family.dart';
import 'package:projectunity/configs/space_constant.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:table_calendar/table_calendar.dart'
    show HeaderStyle, CalendarStyle;

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
        //useMaterial3: true,
        scaffoldBackgroundColor: AppColors.whiteColor,
        dividerTheme: const DividerThemeData(
            color: AppColors.lightGreyColor,
            indent: primaryHorizontalSpacing,
            endIndent: primaryHorizontalSpacing),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.blackColor,
            elevation: 0,
            toolbarHeight: appbarHeight,
            titleTextStyle: AppFontStyle.appbarHeaderDark),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AppColors.lightGreyColor,
            selectedItemColor: AppColors.darkBlue,
            unselectedItemColor: AppColors.primaryBlue),
        scrollbarTheme: const ScrollbarThemeData(
          radius: Radius.circular(12),
          thumbColor: MaterialStatePropertyAll(Color(0xffa0bef1)),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryBlue,
                textStyle: AppFontStyle.buttonTextStyle)),
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
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          side: const BorderSide(color: AppColors.primaryBlue, width: 1),
          fixedSize: const Size.fromHeight(45),
        )),
        textTheme: const TextTheme(
            headlineLarge: AppFontStyle.headerGrey,
            titleLarge: AppFontStyle.labelRegular,
            bodyLarge: AppFontStyle.bodyLarge,
            bodyMedium: AppFontStyle.bodySmallHeavy));
  }

  static ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.primaryBlue,
      fontFamily: FontFamily.fontName,
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
