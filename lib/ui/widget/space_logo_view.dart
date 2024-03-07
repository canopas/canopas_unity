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
      {super.key, this.spaceLogoUrl, this.pickedLogoFile, this.size = 50});

  Widget setCachedImage(BuildContext context) {
    if (spaceLogoUrl != null) {
      return cachedNetworkImage(spaceLogoUrl!);
    } else if (pickedLogoFile != null) {
      return showFileImage(pickedLogoFile!);
    } else {
      return Icon(Icons.business,
          size: size * 0.5, color: context.colorScheme.textDisable);
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
        return Icon(Icons.business,
            size: size * 0.5, color: context.colorScheme.textDisable);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.textDisable),
          borderRadius: AppTheme.commonBorderRadius,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: setCachedImage(context)));
  }
}
