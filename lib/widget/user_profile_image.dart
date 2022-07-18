import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../configs/colors.dart';

class UserProfileImage extends StatelessWidget {
  String? imageUrl;

  UserProfileImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl == null
        ? const Icon(
            Icons.account_circle_rounded,
            size: 50,
          )
        : CircleAvatar(
            radius: 23,
            backgroundColor: AppColors.whiteColor,
            child: CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(imageUrl!),
            ),
          );
  }
}
