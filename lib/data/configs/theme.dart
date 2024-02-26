import 'package:flutter/material.dart';
import '../../style/app_text_style.dart';
import '../../style/colors.dart';
import 'colors.dart';
import 'package:projectunity/data/configs/text_style.dart';
import 'package:table_calendar/table_calendar.dart'
    show HeaderStyle, CalendarStyle;

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
        fontFamily: 'poppins',
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.whiteColor,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.blackColor,
            scrolledUnderElevation: 0.5,
            shadowColor: AppColors.dividerColor,
            surfaceTintColor: AppColors.whiteColor,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: AppFontStyle.appbarHeaderDark),
        bottomNavigationBarTheme:  BottomNavigationBarThemeData(
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          selectedLabelStyle: AppTextStyle.style12.copyWith(color: primaryLightColor),
          unselectedLabelStyle: AppTextStyle.style12,
          selectedItemColor: surfaceColor,
          unselectedItemColor: textDisabledColor,
        ),
        cardTheme: const CardTheme(
          color: AppColors.whiteColor,
          surfaceTintColor: AppColors.whiteColor,
        ),
        popupMenuTheme: const PopupMenuThemeData(
          surfaceTintColor: AppColors.whiteColor,
          color: AppColors.whiteColor,
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.dividerColor,
          thickness: 1,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromHeight(45),
          backgroundColor: AppColors.primaryBlue,
          disabledBackgroundColor: AppColors.greyColor,
          disabledForegroundColor: AppColors.whiteColor,
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

  static CalendarStyle calendarStyle =   CalendarStyle(
    outsideDaysVisible: false,
    weekendTextStyle: AppFontStyle.bodySmallHeavy,
    selectedDecoration:
    BoxDecoration(
      color: primaryLightColor,
      borderRadius: BorderRadius.circular(8)),
    markerDecoration: const BoxDecoration(
      color: AppColors.orangeColor,
      shape: BoxShape.circle,
    ),
    todayDecoration:
        BoxDecoration(
            border: Border.all(color: primaryLightColor), borderRadius: BorderRadius.circular(8)),
    todayTextStyle: AppFontStyle.bodySmallRegular,
  );

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
