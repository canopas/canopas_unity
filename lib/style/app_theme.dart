import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class AppThemeWidget extends InheritedWidget {
  final AppColorScheme colorScheme;

  const AppThemeWidget({super.key, required this.colorScheme, required super.child});



  @override
  bool updateShouldNotify(covariant AppThemeWidget oldWidget) {
   return colorScheme != oldWidget.colorScheme;
  }
}
AppColorScheme appColorSchemeOf(BuildContext context){
  return context.dependOnInheritedWidgetOfExactType<AppThemeWidget>()!.colorScheme;
}



