import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../model/leave/leave.dart';

class LeaveDetailActionButton extends StatelessWidget {
  const LeaveDetailActionButton(
      {Key? key, required this.onTap, required this.leaveStatus})
      : super(key: key);
  final VoidCallback onTap;
  final int leaveStatus;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return ElevatedButton(
      onPressed: onTap,
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
