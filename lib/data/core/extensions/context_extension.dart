import 'package:flutter/cupertino.dart';
import 'package:projectunity/ui/style/colors.dart';
import 'package:projectunity/ui/style/app_theme.dart';

extension BuildContextExtension on BuildContext{

  AppColorScheme get colorScheme =>  appColorSchemeOf(this);

  Brightness get brightness => MediaQuery.of(this).platformBrightness;
}