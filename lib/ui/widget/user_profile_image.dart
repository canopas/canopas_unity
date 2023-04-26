import 'dart:io';
import 'package:flutter/material.dart';
import '../../data/configs/colors.dart';

class ImageProfile extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final double borderSize;
  final Color borderColor;
  final Color backgroundColor;
  final Color iconColor;
  final String? pickedImage;

  const ImageProfile(
      {Key? key,
      this.imageUrl,
      required this.radius,
      this.borderSize = 2,
      this.borderColor = AppColors.textFieldBg,
      this.backgroundColor = AppColors.primaryGray,
      this.pickedImage,
      this.iconColor = Colors.black54})
      : super(key: key);

  ImageProvider? setImage() {
    if (imageUrl != null) {
      return NetworkImage(imageUrl!);
    } else if (pickedImage != null) {
      return FileImage(File(pickedImage!));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: borderColor,
        radius: radius + borderSize,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: backgroundColor,
          backgroundImage: setImage(),
          child: (setImage() != null)
              ? null
              : Icon(Icons.person, size: radius, color: iconColor),
        ));
  }
}
