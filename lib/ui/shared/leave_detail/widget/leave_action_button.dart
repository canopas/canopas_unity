import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/configs/theme.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../model/leave/leave.dart';

class EmployeeLeaveDetailActionButton extends StatelessWidget {
  const EmployeeLeaveDetailActionButton({Key? key, required this.leaveStatus, required this.onPressed}) : super(key: key);
  final int leaveStatus;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: (leaveStatus == pendingLeaveStatus)
            ? AppColors.greyColor
            : AppColors.redColor,
        fixedSize: Size(MediaQuery.of(context).size.width * 0.918518, 45),
      ),
      child: Text(
          (leaveStatus == pendingLeaveStatus)
              ? localization.user_leave_detail_button_cancel
              : localization.user_leave_detail_button_delete,
          style: AppTextStyle.subtitleText),
    );
  }
}

class AdminLeaveDetailsActionButton extends StatelessWidget {
  final void Function()? onApproveButtonPressed;
  final void Function()? onRejectButtonPressed;
  const AdminLeaveDetailsActionButton({Key? key,required this.onApproveButtonPressed,required this.onRejectButtonPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width*0.75,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(50),
        boxShadow: AppTheme.commonBoxShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width * 0.3, 45),
              backgroundColor: AppColors.redColor,
            ),
            onPressed: onRejectButtonPressed,
            child: Text(
              localization.admin_leave_detail_button_reject,
              style: AppTextStyle.subtitleText,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width * 0.3, 45),
              backgroundColor: AppColors.greenColor,
            ),
            onPressed: onApproveButtonPressed,
            child: Text(
              localization.admin_leave_detail_button_approve,
              style: AppTextStyle.subtitleText,
            ),
          ),
        ],
      ),
    );
  }
}