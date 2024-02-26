import 'package:flutter/cupertino.dart';
import '../../../style/app_theme.dart';
import '../../../style/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

extension BuildContextExtension on BuildContext{

  AppColorScheme get colorScheme =>  appColorSchemeOf(this);

  Brightness get brightness => MediaQuery.of(this).platformBrightness;

  AppLocalizations get l10n=>AppLocalizations.of(this);
}