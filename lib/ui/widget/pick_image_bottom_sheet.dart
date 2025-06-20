import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';

import '../../data/configs/theme.dart';
import '../../data/l10n/app_localization.dart';

class PickImageBottomSheet extends StatelessWidget {
  final void Function(ImageSource) onButtonTap;

  const PickImageBottomSheet({super.key, required this.onButtonTap});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
          boxShadow: AppTheme.commonBoxShadow(context),
          color: context.colorScheme.surface,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SelectButton(
            onPressed: () => onButtonTap(ImageSource.camera),
            label: locale.user_setting_camera_tag,
            icon: Icons.camera_alt_rounded,
          ),
          SelectButton(
            onPressed: () => onButtonTap(ImageSource.gallery),
            label: locale.user_setting_gallery_tag,
            icon: Icons.perm_media_rounded,
          ),
        ],
      ),
    );
  }
}

class SelectButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final IconData icon;

  const SelectButton(
      {super.key, required this.label, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          fixedSize: const Size(120, 120),
          shape:
              RoundedRectangleBorder(borderRadius: AppTheme.commonBorderRadius),
          side: BorderSide(color: context.colorScheme.outlineColor, width: 1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: context.colorScheme.primary,
            radius: 25,
            child: Icon(icon, color: context.colorScheme.surface),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.style14
                .copyWith(color: context.colorScheme.textSecondary),
          )
        ],
      ),
    );
  }
}
