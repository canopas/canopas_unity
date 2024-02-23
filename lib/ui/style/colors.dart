import 'dart:ui';

import 'package:flutter/material.dart';

Color primaryDarkColor = const Color(0xffE8704A);
Color secondaryDarkColor = const Color(0xff321153);
Color tertiaryDarkColor = const Color(0xff3E9598);

Color textPrimaryColor = const Color(0xD9000000);
Color textSecondaryColor = const Color(0x99000000);
Color textDisabledColor = const Color(0x66000000);

Color containerHighColor = const Color.fromRGBO(44, 20, 68, 0.12);
Color containerNormalColor = const Color.fromRGBO(44, 20, 68, 0.06);
Color containerLowColor = const Color.fromRGBO(44, 20, 68, 0.02);
Color surfaceColor= const Color(0xFFFFFFFF);

Color primaryLightColor = const Color(0xff5966EA);
Color secondaryLightColor = const Color(0xff3B3561);
Color tertiaryLightColor = const Color(0xffFAC05E);



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
