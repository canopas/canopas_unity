import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../data/configs/colors.dart';

class SpaceLogoView extends StatelessWidget {
  final double size;
  final String? spaceLogo;

  const SpaceLogoView({Key? key, this.spaceLogo, this.size = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.whiteColor,
        border: Border.all(color: AppColors.dividerColor),
        image: spaceLogo.isNotNullOrEmpty
            ? DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(spaceLogo!))
            : null,
      ),
      child: ValidateWidget(
          isValid: !spaceLogo.isNotNullOrEmpty,
          child: Icon(Icons.business,
              size: (size * 0.5), color: AppColors.secondaryText)),
    );
  }
}
