import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import '../../../../../data/configs/theme.dart';

class DrawerOption extends StatelessWidget {
  const DrawerOption({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    super.key,
  });
  final Color? iconColor;
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
              color: iconColor ?? context.colorScheme.textPrimary,
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Text(
                title,
                style: AppTextStyle.style18.copyWith(
                  color: iconColor ?? context.colorScheme.textPrimary,
                ),
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
