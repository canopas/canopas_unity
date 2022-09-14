import 'package:flutter/material.dart';

import '../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';

class SettingOption extends StatelessWidget {
  const SettingOption({required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor = AppColors.blackColor,
    this.titleColor = AppColors.blackColor,
    Key? key})
      : super(key: key);
  final Color titleColor;
  final Color iconColor;
  final IconData icon;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        leading: Icon(
          icon,
          size: 32,
          color: iconColor,
        ),
        onTap: onTap,
        title: Text(
          title,
          style: AppTextStyle.settingOptions.copyWith(color: titleColor),
        )
    );
  }
}
