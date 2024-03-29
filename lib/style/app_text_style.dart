import 'package:flutter/cupertino.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';

class AppTextStyle {
  static const String poppinsFontFamily = "Poppins";

  static TextStyle headerStyle(BuildContext context) => TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 22,
      color: context.colorScheme.textPrimary);

  static const TextStyle style24 =
      TextStyle(fontWeight: FontWeight.w600, fontSize: 24);

  static const TextStyle style20 =
      TextStyle(fontWeight: FontWeight.w600, fontSize: 20);

  static const TextStyle style18 =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 18);

  static const TextStyle style16 =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 16);

  static const TextStyle style14 =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 14);

  static const TextStyle style12 =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.50);
}
