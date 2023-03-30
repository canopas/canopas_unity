import 'package:flutter/material.dart';
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
                  image: NetworkImage(imageURl!),
                  fit: BoxFit.cover,
                )),
            child: imageURl != null
                ? null
                : const Icon(Icons.business,
                color: AppColors.secondaryText, size: 45),
          ),
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
