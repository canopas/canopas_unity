import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:projectunity/style/app_text_style.dart';

const Color primaryDarkColor = Color(0xffE8704A);
const Color secondaryDarkColor =  Color(0xff321153);
const Color tertiaryDarkColor =  Color(0xff3E9598);

const Color textPrimaryColor =  Color(0xD9000000);
const Color textSecondaryColor =  Color(0x99000000);
const Color textDisabledColor =  Color(0x66000000);

const Color containerHighColor =  Color.fromRGBO(44, 20, 68, 0.12);
const Color containerNormalColor =  Color.fromRGBO(44, 20, 68, 0.06);
const Color containerLowColor =  Color.fromRGBO(44, 20, 68, 0.02);
const Color surfaceColor=  Color(0xFFFFFFFF);

 const Color primaryLightColor =  Color(0xff5966EA);
const Color secondaryLightColor =  Color(0xff3B3561);
const Color tertiaryLightColor =  Color(0xffFAC05E);
const Color awarenessColor= Color(0xffD39800);

const Color approveLeaveColor= Color(0xff47A96E);
const Color rejectLeaveColor= Color(0xffCA2F27);
const Color pendingLeaveColor= Color(0xffF5F5F5);

const Color redColor =  Colors.red;
final ThemeData _materialLightTheme = ThemeData.light(useMaterial3: true);


final ThemeData materialThemeDataLight= _materialLightTheme.copyWith(
    primaryColor: primaryLightColor,
  scaffoldBackgroundColor: surfaceColor,
  dividerColor: textDisabledColor,
  colorScheme: _materialLightTheme.colorScheme.copyWith(
    onPrimary: Colors.black,
    onSecondary: textSecondaryColor,
    onSurface: textPrimaryColor
  ),
  appBarTheme: _materialLightTheme.appBarTheme.copyWith(
    backgroundColor: surfaceColor,
    titleTextStyle: AppTextStyle.style20,
  )
);


class AppColorScheme {
  final Color primary;
  final Color secondary;

  final Color tertiary;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;
  final Color containerHigh;
  final Color containerNormal;
  final Color containerLow;

  AppColorScheme(
      {required this.primary,
      required this.secondary,
      required this.tertiary,
        required this.surface,
      required this.textPrimary,
      required this.textSecondary,
      required this.textDisabled,
      required this.containerHigh,
      required this.containerNormal,
      required this.containerLow});
}

final appColorSchemeLight = AppColorScheme(
    primary: primaryLightColor,
    secondary: secondaryLightColor,
    tertiary: tertiaryLightColor,
    surface: surfaceColor,
    textPrimary: textPrimaryColor,
    textSecondary: textSecondaryColor,
    textDisabled: textDisabledColor,
    containerHigh: containerHighColor,
    containerNormal: containerNormalColor,
    containerLow: containerLowColor);

final appColorSchemeDark = AppColorScheme(
    primary: primaryDarkColor,
    secondary: secondaryDarkColor,
    tertiary: tertiaryDarkColor,
    surface: surfaceColor,
    textPrimary: textPrimaryColor,
    textSecondary: textSecondaryColor,
    textDisabled: textDisabledColor,
    containerHigh: containerHighColor,
    containerNormal: containerNormalColor,
    containerLow: containerLowColor);
