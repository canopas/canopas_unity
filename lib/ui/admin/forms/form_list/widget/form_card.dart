import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/colors.dart';
import '../../../../../data/configs/theme.dart';
import '../../../../../data/model/org_forms/org_form_info/org_form_info.dart';

import '../../../../../style/app_text_style.dart';

class AdminListFormCard extends StatelessWidget {
  final OrgFormInfo formInfo;

  const AdminListFormCard({super.key, required this.formInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: AppTheme.commonBorderRadius,
          boxShadow: AppTheme.commonBoxShadow(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(formInfo.title,
              style: AppTextStyle.style20.copyWith(
                  color: context.colorScheme.textPrimary,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          FilledButton.tonal(
            style: FilledButton.styleFrom(
                backgroundColor: context.colorScheme.containerHigh,
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
                Text(context.l10n.responses_tag,
                    style: AppTextStyle.style16
                        .copyWith(color: context.colorScheme.textPrimary)),
                const Icon(Icons.arrow_forward, size: 20)
              ],
            ),
          )
        ],
      ),
    );
  }
}
