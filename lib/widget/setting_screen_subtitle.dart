import 'package:flutter/material.dart';
import 'package:projectunity/core/utils/const/other_constant.dart';

import '../configs/text_style.dart';

Widget buildSettingSubTitle({required String subtitle}) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: primaryHorizontalSpacing),
      child: Text(subtitle, style: AppTextStyle.settingSubTitle));
}