import 'package:flutter/material.dart';

import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/configs/theme.dart';

class DrawerOption extends StatelessWidget {
  const DrawerOption(
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
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(
              icon,
              size: 26,
              color: iconColor,
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Text(
                title,
                style: AppFontStyle.bodyLarge.copyWith(color: titleColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
