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
      {super.key,
      this.imageUrl,
      required this.radius,
      this.backgroundColor,
      this.pickedImage,
      this.iconColor});

  Widget setCachedImage(BuildContext context) {
    if (imageUrl != null) {
      return cachedNetworkImage(imageUrl!);
    } else if (pickedImage != null) {
      return showFileImage(pickedImage!);
    } else {
      return Icon(Icons.person,
          size: radius, color: iconColor ?? context.colorScheme.textDisable);
    }
  }

  Widget showFileImage(String url) {
    if (kIsWeb) {
      return cachedNetworkImage(url);
    } else {
      return Image.file(File(url));
    }
  }

  Widget cachedNetworkImage(String imageUrl) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: imageUrl,
      placeholder: (context, string) {
        return Icon(Icons.person,
            size: radius, color: iconColor ?? context.colorScheme.textDisable);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: radius * 2,
        width: radius * 2,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: context.colorScheme.containerHigh),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: setCachedImage(context)));
  }
}
