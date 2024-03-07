import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../widget/space_logo_view.dart';

class DrawerSpaceCard extends StatelessWidget {
  final String name;
  final bool isSelected;
  final String? logo;
  final Function()? onTap;

  const DrawerSpaceCard(
      {super.key,
      required this.name,
      this.logo,
      this.onTap,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isSelected ? null : onTap,
      borderRadius: AppTheme.commonBorderRadius,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: AppTheme.commonBorderRadius,
          color: isSelected ? context.colorScheme.containerNormal : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              SpaceLogoView(size: 45, spaceLogoUrl: logo),
              const SizedBox(width: 10),
              Flexible(
                  child: Text(name,
                      style: AppTextStyle.style16
                          .copyWith(color: context.colorScheme.textPrimary),
                      overflow: TextOverflow.ellipsis)),
            ],
          ),
        ),
      ),
    );
  }
}
