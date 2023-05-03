import 'dart:io';
import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/configs/theme.dart';

class OrgLogoView extends StatelessWidget {
  final void Function()? onButtonTap;

  final String? imageURl;

  const OrgLogoView({Key? key, this.onButtonTap, this.imageURl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: const Alignment(1.5, 1.5),
        children: [
          Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.textFieldBg, width: 3),
                  color: AppColors.textFieldBg,
                  borderRadius: AppTheme.commonBorderRadius,
                  image: imageURl == null
                      ? null
                      : DecorationImage(
                          image: FileImage(File(imageURl!)),
                          fit: BoxFit.cover,
                        )),
              child: ValidateWidget(
                isValid: !imageURl.isNotNullOrEmpty,
                child: const Icon(Icons.business,
                    color: AppColors.secondaryText, size: 45),
              )),
          IconButton(
            style: IconButton.styleFrom(
                fixedSize: const Size(45, 45),
                side: const BorderSide(color: AppColors.textFieldBg, width: 3),
                backgroundColor: AppColors.whiteColor),
            onPressed: onButtonTap,
            icon: const Icon(
              Icons.edit,
              size: 20,
              color: AppColors.greyColor,
            ),
          )
        ],
      ),
    );
  }
}
