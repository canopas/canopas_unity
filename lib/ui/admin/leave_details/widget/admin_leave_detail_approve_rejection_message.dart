import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';
import '../../../../configs/theme.dart';
import '../../../../core/utils/const/space_constant.dart';
import '../../../../model/leave/leave.dart';
import '../bloc/admin_leave_details_bloc.dart';
import '../bloc/admin_leave_details_event.dart';


class ApproveRejectionMessage extends StatelessWidget {
  final int leaveStatus;
  const ApproveRejectionMessage({Key? key,required this.leaveStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return leaveStatus == pendingLeaveStatus?Padding(
      padding: const EdgeInsets.symmetric(horizontal: primaryHorizontalSpacing,vertical: primaryHalfSpacing),
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
            padding: const EdgeInsets.symmetric(horizontal: primaryHorizontalSpacing).copyWith(bottom: 4),
            decoration: BoxDecoration(
              boxShadow: AppTheme.commonBoxShadow,
              borderRadius: AppTheme.commonBorderRadius,
              color: AppColors.whiteColor,
            ),
            child: TextField(
              style: AppTextStyle.bodyTextDark,
              onChanged: (value) {
                context.read<AdminLeaveDetailsBloc>().add(AdminLeaveDetailsChangeAdminReplyValue(value));
              },
              maxLines: 5,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText:
                AppLocalizations.of(context).admin_leave_detail_error_reason,
              ),
            ),
          ),
        ],
      ),
    ):const SizedBox();
  }
}
