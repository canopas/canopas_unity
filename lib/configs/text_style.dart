import 'package:flutter/material.dart';

import 'colors.dart';
import 'font_size.dart';

class AppTextStyle{
  static TextStyle subTitleTextStyle = const TextStyle(
      fontSize: subTitleTextSize,
      color: AppColors.darkText,
      fontWeight: FontWeight.w500);
  static TextStyle leaveStatusCardTitle =
      const TextStyle(color: AppColors.blueGrey, fontSize: bodyTextSize);


  static TextStyle bodyTextDark =
      const TextStyle(color: AppColors.darkText, fontSize: bodyTextSize);
  static TextStyle leaveRequestFormSubtitle = const TextStyle(
      color: AppColors.secondaryText, fontSize: subTitleTextSize);
  static TextStyle subtitleTextWhite = const TextStyle(
      color: AppColors.whiteColor,
      fontSize: subTitleTextSize,
      fontWeight: FontWeight.w500);


  static TextStyle subtitleTextDark =
      const TextStyle(color: AppColors.darkText, fontSize: subTitleTextSize);

  static TextStyle secondaryBodyText = const TextStyle(color: AppColors.secondaryText, fontSize: bodyTextSize);
  static TextStyle darkSubtitle700 = const TextStyle(color: AppColors.darkText, fontSize: subTitleTextSize, fontWeight: FontWeight.w700);
  static TextStyle secondarySubtitle500 = const TextStyle(color: AppColors.secondaryText, fontSize: subTitleTextSize, fontWeight: FontWeight.w500);

  static TextStyle settingSubTitle = const TextStyle(fontSize: headerTextSize, color: AppColors.secondaryText, fontWeight:FontWeight.w600);
  static TextStyle settingOptions = const TextStyle(fontSize: subTitleTextSize, fontWeight: FontWeight.w600,);
  static TextStyle headerTextBold = const TextStyle(fontSize: headerTextSize, fontWeight: FontWeight.bold);
  static TextStyle largeHeaderBold = const TextStyle(fontSize: largeTitleTextSize, fontWeight: FontWeight.bold,color: AppColors.blackColor);
  static TextStyle appBarTitle = const TextStyle(color: AppColors.whiteColor, fontSize: titleTextSize, fontWeight: FontWeight.w600);

  static TextStyle subtitleText = const TextStyle(fontSize: subTitleTextSize, fontWeight: FontWeight.w500);
  static TextStyle titleText = const TextStyle(fontSize: titleTextSize, fontWeight: FontWeight.w500);

  static TextStyle appTitleText  = const TextStyle(fontSize: appTitleTextSize, color: AppColors.blackColor,);

  static TextStyle headerDark600 = const TextStyle(color: AppColors.darkText, fontSize: headerTextSize, fontWeight: FontWeight.w600);
  static TextStyle titleBlack600 = const TextStyle(color: AppColors.blackColor, fontSize: titleTextSize, fontWeight: FontWeight.w600);

  static TextStyle subtitleGreyBold =  const TextStyle(fontSize: subTitleTextSize, fontWeight: FontWeight.bold, color: AppColors.darkGrey );

  //new UI textStyle
  static const TextStyle titleDark =  TextStyle(color: AppColors.textDark,fontSize: AppFontSize.title,fontWeight: FontWeight.w500);
  static const TextStyle mediumDark =  TextStyle(color: AppColors.textDark,fontSize: AppFontSize.medium,fontWeight: FontWeight.w500);
  static const TextStyle bodyDarkGrey = TextStyle(color: AppColors.textDarkGrey,fontSize: AppFontSize.body,fontWeight: FontWeight.w500);
  static const TextStyle bodyDark = TextStyle(color: AppColors.darkText,fontSize: AppFontSize.body,fontWeight: FontWeight.w500);
  static const TextStyle headerDark =  TextStyle(color: AppColors.textDark,fontSize: AppFontSize.header,fontWeight: FontWeight.w600);
}