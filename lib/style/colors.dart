import 'package:flutter/material.dart';
import 'package:projectunity/style/app_text_style.dart';

const Color primaryColor = Color(0xff5966EA);


const Color secondaryLightColor = Color(0xff3B3561);
const Color tertiaryLightColor = Color(0xffFAC05E);

const Color secondaryDarkColor = Color(0xff5966EA);
const Color tertiaryDarkColor = Color(0xffFFDB9D);

const Color textPrimaryColor = Color(0xDE000000);
const Color textSecondaryColor = Color(0x99000000);
const Color textDisabledColor = Color(0x66000000);

const Color textPrimaryDarkColor = Color(0xffFFFFFF);
const Color textSecondaryDarkColor = Color(0xB3FFFFFF);
const Color textDisabledDarkColor = Color(0x80FFFFFF);

const outlineLightColor = Color(0x1A000000);
const outlineDarkColor = Color(0x1AFFFFFF);

const containerHighLightColor = Color(0x2624295E);
const containerNormalLightColor = Color(0x1A24295E);
const containerLowLightColor = Color(0x0D24295E);

const containerHighDarkColor = Color(0x26BDC2F7);
const containerNormalDarkColor = Color(0x1ABDC2F7);
const containerLowDarkColor = Color(0x1ABDC2F7);

const Color surfaceLightColor = Color(0xFFFFFFFF);
const Color surfaceDarkColor = Color(0xFF121212);

const Color approveLeaveColor = Color(0xff47A96E);
const Color rejectLeaveColor = Color(0xffCA2F27);

final ThemeData _materialLightTheme = ThemeData.light(useMaterial3: true);
final ThemeData _materialDarkTheme = ThemeData.dark(useMaterial3: true);

final ThemeData materialThemeDataLight = _materialLightTheme.copyWith(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  splashColor: containerLowLightColor,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: surfaceLightColor,
  dividerColor: textDisabledColor,
  colorScheme: _materialLightTheme.colorScheme.copyWith(
      onPrimary: primaryColor,
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
  visualDensity: VisualDensity.adaptivePlatformDensity,
  splashColor: containerLowDarkColor,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: surfaceDarkColor,
  dividerColor: outlineDarkColor,
  colorScheme: _materialLightTheme.colorScheme.copyWith(
      onPrimary: primaryColor,
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
  final Color textDisable;

  final Color containerHigh;
  final Color containerNormal;
  final Color containerLow;
  final Color approveColor;
  final Color rejectColor;
  final Color outlineColor;
  final Color onPrimary;

  AppColorScheme(
      {required this.primary,
      required this.secondary,
      required this.tertiary,
      required this.surface,
      required this.textPrimary,
      required this.textSecondary,
        required this.textDisable,
      required this.containerHigh,
      required this.containerNormal,
      required this.containerLow,
      required this.approveColor,
      required this.rejectColor,
      required this.outlineColor,
      required this.onPrimary});
}

final appColorSchemeLight = AppColorScheme(
    primary: primaryColor,
    secondary: secondaryLightColor,
    tertiary: tertiaryLightColor,
    surface: surfaceLightColor,
    textPrimary: textPrimaryColor,
    textSecondary: textSecondaryColor,
    textDisable: textDisabledColor,
    containerHigh: containerHighLightColor,
    containerNormal: containerNormalLightColor,
    containerLow: containerLowLightColor,
    approveColor: approveLeaveColor,
    rejectColor: rejectLeaveColor,
    outlineColor: outlineLightColor,
    onPrimary: Colors.black);

final appColorSchemeDark = AppColorScheme(
    primary: primaryColor,
    secondary: secondaryDarkColor,
    tertiary: tertiaryDarkColor,
    surface: surfaceDarkColor,
    textPrimary: textPrimaryDarkColor,
    textSecondary: textSecondaryDarkColor,
    textDisable: textDisabledDarkColor,
    containerHigh: containerHighDarkColor,
    containerNormal: containerNormalDarkColor,
    containerLow: containerNormalDarkColor,
    approveColor: approveLeaveColor,
    rejectColor: rejectLeaveColor,
    outlineColor: outlineDarkColor,
    onPrimary: Colors.black);
