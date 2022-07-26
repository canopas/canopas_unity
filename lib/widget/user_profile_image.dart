import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../configs/colors.dart';

class ImageProfile extends StatelessWidget {
  String? imageUrl;
  double iconSize;

  ImageProfile({Key? key, this.imageUrl, required this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl == null
        ? Icon(
            Icons.account_circle_rounded,
            size: iconSize,
          )
        : CircleAvatar(
            radius: iconSize / 2 + 1,
            backgroundColor: AppColors.whiteColor,
            child: CircleAvatar(
              radius: iconSize / 2,
              backgroundImage: NetworkImage(imageUrl!),
            ),
          );
  }
}
