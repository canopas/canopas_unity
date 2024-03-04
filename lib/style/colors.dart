import 'package:flutter/material.dart';
import 'package:projectunity/style/app_text_style.dart';

const Color primaryDarkColor = Color(0xffE8704A);
const Color secondaryDarkColor = Color(0xff321153);
const Color tertiaryDarkColor = Color(0xff3E9598);

const Color textPrimaryColor = Color(0xD9000000);
const Color textSecondaryColor = Color(0x99000000);
const Color textDisabledColor = Color(0x66000000);

const Color textPrimaryDarkColor = Color(0xFFFFFFFF);
const Color textSecondaryDarkColor = containerLowColor;

const Color containerHighColor = Color.fromRGBO(44, 20, 68, 0.12);
const Color containerNormalColor = Color.fromRGBO(44, 20, 68, 0.06);
const Color containerLowColor = Color.fromRGBO(44, 20, 68, 0.02);

const Color surfaceLightColor = Color(0xFFFFFFFF);
const Color surfaceDarkColor = Color(0xFF121212);

const Color primaryLightColor = Color(0xff5966EA);
const Color primaryLightColorOpacity = Color(0x805966EA);

const Color secondaryLightColor = Color(0xff3B3561);
const Color tertiaryLightColor = Color(0xffFAC05E);
const Color awarenessColor = Color(0xffD39800);

const Color approveLeaveColor = Color(0xff47A96E);
const Color rejectLeaveColor = Color(0xffCA2F27);
const Color pendingLeaveColor = Color(0xffF5F5F5);

const Color outlineColor = Color(0xFFd7dee9);

final ThemeData _materialLightTheme = ThemeData.light(useMaterial3: true);
final ThemeData _materialDarkTheme = ThemeData.dark(useMaterial3: true);

final ThemeData materialThemeDataLight = _materialLightTheme.copyWith(
  primaryColor: primaryLightColor,
  scaffoldBackgroundColor: surfaceLightColor,
  dividerColor: textDisabledColor,
  colorScheme: _materialLightTheme.colorScheme.copyWith(
      onPrimary: primaryLightColor,
      onSecondary: textSecondaryColor,
      surface: surfaceLightColor,
      onSurface: textPrimaryColor),
  appBarTheme: _materialLightTheme.appBarTheme.copyWith(
      backgroundColor: surfaceLightColor,
      titleTextStyle: AppTextStyle.style20,
      foregroundColor: textPrimaryColor,
      centerTitle: true),
  popupMenuTheme: _materialLightTheme.popupMenuTheme.copyWith(
    surfaceTintColor: surfaceLightColor,
    color: surfaceLightColor,
  ),
);

final ThemeData materialThemeDataDark = _materialDarkTheme.copyWith(
  primaryColor: primaryDarkColor,
  scaffoldBackgroundColor: surfaceDarkColor,
  dividerColor: containerLowColor,
  colorScheme: _materialLightTheme.colorScheme.copyWith(
      onPrimary: primaryDarkColor,
      onSecondary: textSecondaryDarkColor,
      surface: surfaceDarkColor,
      onSurface: textPrimaryDarkColor),
  appBarTheme: _materialLightTheme.appBarTheme.copyWith(
      backgroundColor: surfaceDarkColor,
      titleTextStyle: AppTextStyle.style20,
      foregroundColor: textPrimaryDarkColor,
      centerTitle: true),
  popupMenuTheme: _materialLightTheme.popupMenuTheme.copyWith(
    surfaceTintColor: surfaceDarkColor,
    color: surfaceDarkColor,
  ),
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
  final Color approveColor;
  final Color rejectColor;
  final Color awarenessColor;
  final Color outlineColor;
  final Color primaryInverseColor;

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
      required this.containerLow,
      required this.approveColor,
      required this.rejectColor,
      required this.awarenessColor,
      required this.outlineColor,
      required this.primaryInverseColor});
}

final appColorSchemeLight = AppColorScheme(
    primary: primaryLightColor,
    secondary: secondaryLightColor,
    tertiary: tertiaryLightColor,
    surface: surfaceLightColor,
    textPrimary: textPrimaryColor,
    textSecondary: textSecondaryColor,
    textDisabled: textDisabledColor,
    containerHigh: containerHighColor,
    containerNormal: containerNormalColor,
    containerLow: containerLowColor,
    approveColor: approveLeaveColor,
    rejectColor: rejectLeaveColor,
    awarenessColor: awarenessColor,
    outlineColor: outlineColor,
    primaryInverseColor: primaryDarkColor);

final appColorSchemeDark = AppColorScheme(
    primary: primaryDarkColor,
    secondary: secondaryDarkColor,
    tertiary: tertiaryDarkColor,
    surface: surfaceDarkColor,
    textPrimary: textPrimaryDarkColor,
    textSecondary: textSecondaryDarkColor,
    textDisabled: textDisabledColor,
    containerHigh: containerHighColor,
    containerNormal: containerNormalColor,
    containerLow: containerLowColor,
    approveColor: approveLeaveColor,
    rejectColor: rejectLeaveColor,
    awarenessColor: awarenessColor,
    outlineColor: outlineColor,
    primaryInverseColor: tertiaryLightColor);
