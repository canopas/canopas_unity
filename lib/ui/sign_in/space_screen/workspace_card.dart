import 'package:flutter/material.dart';
import '../../../data/configs/colors.dart';
import '../../../data/configs/text_style.dart';
import '../../../data/configs/theme.dart';

class SpaceCard extends StatelessWidget {
  final void Function()? onPressed;
  final String? imageURL;

  const SpaceCard({Key? key, this.onPressed, this.imageURL}) : super(key: key);

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
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: imageURL == null
                          ? AppColors.textFieldBg
                          : AppColors.whiteColor,
                      borderRadius: AppTheme.commonBorderRadius,
                      image: imageURL == null
                          ? null
                          : DecorationImage(
                        image: NetworkImage(imageURL!),
                        fit: BoxFit.cover,
                      )),
                  child: imageURL != null
                      ? null
                      : const Icon(Icons.business,
                      color: AppColors.secondaryText, size: 40),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Canopas software",
                        style: AppFontStyle.bodyLarge
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const Text("24 Members", style: AppFontStyle.subTitleGrey)
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
