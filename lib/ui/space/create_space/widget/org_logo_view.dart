import 'package:flutter/material.dart';
import 'package:projectunity/ui/widget/space_logo_view.dart';
import '../../../../data/configs/colors.dart';

class OrgLogoView extends StatelessWidget {
  final void Function()? onButtonTap;

  final String? pickedLogoFile;

  const OrgLogoView({Key? key, this.onButtonTap, this.pickedLogoFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: const Alignment(1.5, 1.5),
        children: [
          SpaceLogoView(size: 110, pickedLogoFile: pickedLogoFile),
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
