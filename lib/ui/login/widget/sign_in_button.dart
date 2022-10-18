import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/text_style.dart';

import '../../../configs/colors.dart';
import '../../../core/utils/const/image_constant.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            foregroundColor: AppColors.peachColor.withOpacity(0.2),
            fixedSize: Size(MediaQuery.of(context).size.width * 0.70, 50),
            side: const BorderSide(color: AppColors.peachColor, width: 2),
            backgroundColor: AppColors.creamColor.withOpacity(0.2),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
        onPressed: onPressed,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Image.asset(
            googleLogoImage,
            height: 40,
          ),
          Expanded(
            child: Text(
              AppLocalizations.of(context).login_button_text,
              textAlign: TextAlign.center,
              style: AppTextStyle.titleText.copyWith(color: AppColors.darkText),
            ),
          )
        ]));
  }
}
