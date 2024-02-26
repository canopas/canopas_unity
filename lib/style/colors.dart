import 'dart:ui';

import 'package:flutter/material.dart';

const Color primaryDarkColor = const Color(0xffE8704A);
const Color secondaryDarkColor = const Color(0xff321153);
const Color tertiaryDarkColor = const Color(0xff3E9598);

const Color textPrimaryColor = const Color(0xD9000000);
const Color textSecondaryColor = const Color(0x99000000);
const Color textDisabledColor = const Color(0x66000000);

const Color containerHighColor = const Color.fromRGBO(44, 20, 68, 0.12);
const Color containerNormalColor = const Color.fromRGBO(44, 20, 68, 0.06);
const Color containerLowColor = const Color.fromRGBO(44, 20, 68, 0.02);
const Color surfaceColor= const Color(0xFFFFFFFF);

 const Color primaryLightColor = const Color(0xff5966EA);
const Color secondaryLightColor = const Color(0xff3B3561);
const Color tertiaryLightColor = const Color(0xffFAC05E);



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
