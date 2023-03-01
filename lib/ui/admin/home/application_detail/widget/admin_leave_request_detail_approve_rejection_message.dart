import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/space_constant.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../configs/theme.dart';
import '../bloc/admin_leave_application_detail_bloc.dart';
import '../bloc/admin_leave_application_detail_event.dart';

class ApproveRejectionMessage extends StatelessWidget {
  const ApproveRejectionMessage({Key? key}) : super(key: key);

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
            style: AppFontStyle.labelGrey,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: primaryHorizontalSpacing)
                    .copyWith(bottom: 4),
            decoration: BoxDecoration(
              boxShadow: AppTheme.commonBoxShadow,
              borderRadius: AppTheme.commonBorderRadius,
              color: AppColors.whiteColor,
            ),
            child: TextField(
              style: AppFontStyle.bodySmallRegular,
              onChanged: (value) {
                context
                    .read<AdminLeaveApplicationDetailsBloc>()
                    .add(AdminLeaveApplicationReasonChangedEvent(value));
              },
              maxLines: 5,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: AppLocalizations.of(context)
                    .admin_leave_detail_error_reason,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
