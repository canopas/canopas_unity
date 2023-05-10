import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../data/configs/colors.dart';
import '../../data/configs/theme.dart';

class SpaceLogoView extends StatelessWidget {
  final String? spaceLogo;

  const SpaceLogoView({Key? key, this.spaceLogo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.whiteColor,
        boxShadow: AppTheme.commonBoxShadow,
        image: spaceLogo.isNotNullOrEmpty
            ? DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(spaceLogo!))
            : null,
      ),
      child: ValidateWidget(
          isValid: !spaceLogo.isNotNullOrEmpty,
          child: const Icon(Icons.business_rounded,
              size: 30, color: AppColors.secondaryText)),
    );
  }
}