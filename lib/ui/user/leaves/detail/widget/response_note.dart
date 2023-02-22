import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../configs/theme.dart';
import '../../../../../core/utils/const/space_constant.dart';

class ResponseNote extends StatelessWidget {
  final String leaveResponse;
  const ResponseNote({Key? key, required this.leaveResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: primaryHorizontalSpacing, vertical: primaryHalfSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).admin_leave_detail_message_title_text,
            style: AppTextStyle.secondarySubtitle500,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(5).copyWith(bottom: 4),
            decoration: BoxDecoration(
              boxShadow: AppTheme.commonBoxShadow,
              borderRadius: AppTheme.commonBorderRadius,
              color: AppColors.lightPrimaryBlue,
            ),
            child: Text(
              leaveResponse,
              style: AppTextStyle.subtitleTextDark,
            ),
          ),
        ],
      ),
    );
  }
}