import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../configs/colors.dart';

class ImageProfile extends StatelessWidget {
  String? imageUrl;
  double radius;

  ImageProfile({Key? key, this.imageUrl, required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primaryGray,
      backgroundImage: (imageUrl != null) ? NetworkImage(imageUrl!) : null,
      child: (imageUrl != null)
          ? null
          : Icon(Icons.person, size: radius, color: Colors.black54),
    );
  }
}
