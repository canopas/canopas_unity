import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/ui/widget/space_logo_view.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../data/configs/theme.dart';

class SpaceCard extends StatelessWidget {
  final String name;
  final String? domain;
  final void Function()? onPressed;
  final String? logo;

  const SpaceCard({
    super.key,
    this.onPressed,
    this.logo,
    required this.name,
    required this.domain,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        color: context.colorScheme.surface,
        borderRadius: AppTheme.commonBorderRadius,
        child: InkWell(
          borderRadius: AppTheme.commonBorderRadius,
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpaceLogoView(spaceLogoUrl: logo),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTextStyle.style16.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.colorScheme.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      ValidateWidget(
                        isValid: domain.isNotNullOrEmpty,
                        child: Text(
                          domain ?? "",
                          style: AppTextStyle.style14.copyWith(
                            color: context.colorScheme.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
