import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import 'package:projectunity/ui/widget/space_logo_view.dart';
import 'package:projectunity/ui/widget/widget_validation.dart';
import '../../data/configs/colors.dart';
import '../../data/configs/text_style.dart';
import '../../data/configs/theme.dart';

class SpaceCard extends StatelessWidget {
  final String name;
  final String? domain;
  final void Function()? onPressed;
  final String? logo;

  const SpaceCard(
      {Key? key,
      this.onPressed,
      this.logo,
      required this.name,
      required this.domain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: AppTheme.commonBorderRadius,
        boxShadow: AppTheme.commonBoxShadow,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppTheme.commonBorderRadius,
        child: InkWell(
          borderRadius: AppTheme.commonBorderRadius,
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpaceLogoView(spaceLogo: logo),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppFontStyle.bodyLarge
                            .copyWith(fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                      ValidateWidget(
                          isValid: domain.isNotNullOrEmpty,
                          child: Text(domain ?? "",
                              style: AppFontStyle.subTitleGrey,
                            overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.arrow_forward_ios_rounded, size: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
