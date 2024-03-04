import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import '../../data/configs/theme.dart';

class SpaceLogoView extends StatelessWidget {
  final double size;
  final String? spaceLogoUrl;
  final String? pickedLogoFile;

  const SpaceLogoView(
      {Key? key, this.spaceLogoUrl, this.pickedLogoFile, this.size = 50})
      : super(key: key);

  ImageProvider? setImage() {
    if (pickedLogoFile != null) {
      if (kIsWeb) {
        return CachedNetworkImageProvider(pickedLogoFile!);
      } else {
        return FileImage(File(pickedLogoFile!));
      }
    } else if (spaceLogoUrl != null) {
      return CachedNetworkImageProvider(spaceLogoUrl!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.outlineColor),
          color: context.colorScheme.surface,
          borderRadius: AppTheme.commonBorderRadius,
          image: setImage() != null
              ? DecorationImage(fit: BoxFit.cover, image: setImage()!)
              : null),
      child: setImage() == null
          ? Icon(
              Icons.business,
              size: (size * 0.5),
              color: context.colorScheme.containerHigh,
            )
          : null,
    );
  }
}
