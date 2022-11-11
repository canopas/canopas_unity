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
  static TextStyle headerTextNormal =
      const TextStyle(color: AppColors.darkText, fontSize: headerTextSize);
  static TextStyle leaveRequestDateHeader = const TextStyle(
      fontSize: 18,
      color: AppColors.secondaryText,
      fontWeight: FontWeight.w700);

  static TextStyle bodyTextDark =
      const TextStyle(color: AppColors.darkText, fontSize: bodyTextSize);
  static TextStyle leaveRequestFormSubtitle = const TextStyle(
      color: AppColors.secondaryText, fontSize: subTitleTextSize);
  static TextStyle removeTextStyle = const TextStyle(height: 0, fontSize: 0);
  static TextStyle subtitleTextWhite = const TextStyle(
      color: AppColors.whiteColor,
      fontSize: subTitleTextSize,
      fontWeight: FontWeight.w500);

  static TextStyle approvalStatusDark =
      const TextStyle(fontSize: titleTextSize, color: AppColors.darkText);
  static TextStyle leaveDetailSubtitle =
      const TextStyle(fontSize: subTitleTextSize, color: AppColors.blueGrey);

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

  static TextStyle onBoardButton =  const TextStyle(fontWeight: FontWeight.w800, color: Color(0xffffffff), fontSize: subTitleTextSize);
  static TextStyle onBoardTitle =  const TextStyle(color: Colors.black, fontSize: onboardTitleTextSize, fontWeight: FontWeight.w700);

  static TextStyle boldWhiteText = const TextStyle(color: Color(0xffffffff), fontWeight: FontWeight.bold);
  static TextStyle headerDark600 = const TextStyle(color: AppColors.darkText, fontSize: headerTextSize, fontWeight: FontWeight.w600);
  static TextStyle bodyTextGrey = const TextStyle(fontSize: bodyTextSize, color: Colors.grey);
  static TextStyle titleBlack600 = const TextStyle(color: AppColors.blackColor, fontSize: titleTextSize, fontWeight: FontWeight.w600);

  static TextStyle subtitleGreyBold =  const TextStyle(fontSize: subTitleTextSize, fontWeight: FontWeight.bold, color: AppColors.darkGrey );
}