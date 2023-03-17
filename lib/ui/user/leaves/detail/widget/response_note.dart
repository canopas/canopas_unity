import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/space_constant.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/configs/theme.dart';

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
            AppLocalizations.of(context).admin_leave_detail_note_tag,
            style: AppFontStyle.labelGrey,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(5).copyWith(bottom: 4),
            decoration: BoxDecoration(
              boxShadow: AppTheme.commonBoxShadow,
              borderRadius: AppTheme.commonBorderRadius,
              color: AppColors.lightPrimaryBlue,
            ),
            child: Text(
              leaveResponse,
              style: AppFontStyle.labelRegular,
            ),
          ),
        ],
      ),
    );
  }
}
