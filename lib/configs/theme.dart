import 'package:flutter/material.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/text_style.dart';

class AppTheme{
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryBlue,
    fontFamily: 'inter',
    appBarTheme:  AppBarTheme(
      titleTextStyle: AppTextStyle.appBarTitle,
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: AppColors.whiteColor,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: AppColors.primaryBlue,
      )
    )
  );
}