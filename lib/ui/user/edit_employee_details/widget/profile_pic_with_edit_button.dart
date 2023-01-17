import 'package:flutter/material.dart';
import '../../../../configs/colors.dart';
import '../../../../widget/user_profile_image.dart';

class ProfileImageWithEditButton extends StatelessWidget {
  final String? imageURl;

  const ProfileImageWithEditButton({Key? key, required this.imageURl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
              radius: 70,
              backgroundColor: AppColors.textFieldBg,
              child: ImageProfile(imageUrl: imageURl, radius: 65)),
          FloatingActionButton(
              onPressed: () {},
              shape: const CircleBorder(
                  side: BorderSide(color: AppColors.textFieldBg, width: 2)),
              backgroundColor: AppColors.whiteColor,
              elevation: 2,
              mini: true,
              child: const Icon(
                Icons.edit,
                color: AppColors.darkGrey,
              )),
        ],
      ),
    );
  }
}
