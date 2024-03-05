import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';

class ImageProfile extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final Color? backgroundColor;
  final Color? iconColor;
  final String? pickedImage;

  const ImageProfile(
      {Key? key,
      this.imageUrl,
      required this.radius,
      this.backgroundColor ,
      this.pickedImage,
      this.iconColor})
      : super(key: key);

  ImageProvider? setImage() {
    if (imageUrl != null) {
      return CachedNetworkImageProvider(imageUrl!);
    } else if (pickedImage != null) {
      if (kIsWeb) {
        return CachedNetworkImageProvider(pickedImage!);
      } else {
        return FileImage(File(pickedImage!));
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor?? context.colorScheme.containerHigh,
      backgroundImage: setImage(),
      child: (setImage() != null)
          ? null
          : Icon(Icons.person,
              size: radius,
              color: iconColor ?? context.colorScheme.containerHigh),
    );
  }
}
