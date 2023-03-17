import 'package:flutter/material.dart';
import 'colors.dart';
import 'font_size.dart';

class AppFontStyle {
  static const buttonTextStyle =
      TextStyle(color: AppColors.primaryBlue, fontSize: AppFontSize.label);

  static TextStyle appTitleText = const TextStyle(
    fontSize: AppFontSize.appTitleTextSize,
    color: AppColors.blackColor,
  );

  static const appbarHeaderDark = TextStyle(
      color: AppColors.blackColor,
      fontSize: AppFontSize.header,
      fontWeight: FontWeight.bold);
  static const headerGrey = TextStyle(
      color: AppColors.greyColor,
      fontSize: AppFontSize.header,
      fontWeight: FontWeight.w500);

  static const titleDark = TextStyle(
      color: AppColors.darkText,
      fontSize: AppFontSize.title,
      fontWeight: FontWeight.w600);
  static const titleRegular =
      TextStyle(fontSize: AppFontSize.title, fontWeight: FontWeight.w500);

  static const labelRegular =
      TextStyle(fontSize: AppFontSize.label, fontWeight: FontWeight.w500);
  static const labelGrey = TextStyle(
      fontSize: AppFontSize.label,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryText);

  static const bodyLarge = TextStyle(
      color: AppColors.darkText,
      fontSize: AppFontSize.bodyLarge,
      fontWeight: FontWeight.w500);
  static const bodyMedium = TextStyle(
      color: AppColors.darkText,
      fontSize: AppFontSize.bodyMedium,
      fontWeight: FontWeight.w500);
  static const bodySmallHeavy = TextStyle(
      color: AppColors.darkText,
      fontSize: AppFontSize.bodySmall,
      fontWeight: FontWeight.w500);
  static const bodySmallRegular =
      TextStyle(color: AppColors.darkText, fontSize: AppFontSize.bodySmall);

  static const subTitleGrey =
      TextStyle(color: AppColors.textDarkGrey, fontSize: AppFontSize.bodySmall);
}
