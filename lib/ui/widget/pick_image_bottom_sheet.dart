import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/configs/colors.dart';
import '../../data/configs/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../data/configs/theme.dart';

class PickImageBottomSheet extends StatelessWidget {
  final void Function(ImageSource) onButtonTap;

  const PickImageBottomSheet({Key? key, required this.onButtonTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Container(
      decoration:  BoxDecoration(
          boxShadow: AppTheme.commonBoxShadow,
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SelectButton(
            onPressed: () => onButtonTap(ImageSource.camera),
            label: locale.user_setting_take_photo_tag,
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
      {Key? key, required this.label, required this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          fixedSize: const Size(120, 120),
          shape:
              RoundedRectangleBorder(borderRadius: AppTheme.commonBorderRadius),
          side: const BorderSide(color: AppColors.dividerColor, width: 1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primaryBlue,
            radius: 25,
            child: Icon(icon, color: AppColors.whiteColor),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: AppFontStyle.subTitleGrey,
          )
        ],
      ),
    );
  }
}
