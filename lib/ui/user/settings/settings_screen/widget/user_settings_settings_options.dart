import 'package:flutter/material.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../configs/theme.dart';
import '../../../../../core/utils/const/space_constant.dart';

class SettingOption extends StatelessWidget {
  const SettingOption(
      {required this.icon,
      required this.title,
      required this.onTap,
      this.iconColor = AppColors.textDark,
      this.titleColor = AppColors.textDark,
      Key? key})
      : super(key: key);
  final Color titleColor;
  final Color iconColor;
  final IconData icon;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppTheme.commonBorderRadius,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(primaryVerticalSpacing),
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: iconColor,
            ),
            const SizedBox(
              width: primaryHorizontalSpacing,
            ),
            Text(
              title,
              style: AppTextStyle.subTitleDark,
            ),
          ],
        ),
      ),
    );
  }
}
