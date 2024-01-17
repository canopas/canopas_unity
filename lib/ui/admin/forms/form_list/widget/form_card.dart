import 'package:flutter/material.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../../data/model/org_forms/org_form_info/org_form_info.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class AdminListFormCard extends StatelessWidget {
  final OrgFormInfo formInfo;

  const AdminListFormCard({super.key, required this.formInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: AppTheme.commonBorderRadius,
          boxShadow: AppTheme.commonBoxShadow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(formInfo.title, style: AppFontStyle.titleDark),
          const SizedBox(height: 16),
          FilledButton.tonal(
            style: FilledButton.styleFrom(
                backgroundColor: AppColors.backgroundGrey,
                fixedSize: Size(MediaQuery.of(context).size.width, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
            onPressed: () {
              ///TODO: Add navigation for form response screen
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context).responses_tag,
                    style: AppFontStyle.bodyLarge),
                const Icon(Icons.arrow_forward, size: 20)
              ],
            ),
          )
        ],
      ),
    );
  }
}
