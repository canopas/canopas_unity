import 'package:flutter/material.dart';

import '../configs/text_style.dart';

Widget buildSettingSubTitle({required String subtitle}) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(subtitle, style: AppTextStyle.settingSubTitle));
}