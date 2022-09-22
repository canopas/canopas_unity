import 'package:flutter/material.dart';
import '../../../../../bloc/user/user_leave_bloc.dart';
import '../../../../../configs/colors.dart';
import '../../../../../configs/text_style.dart';
import '../../../../../di/service_locator.dart';
import '../../../../../model/leave/leave.dart';
import '../../../../../navigation/navigation_stack_manager.dart';
import '../../../../../widget/error_snackbar.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class LeaveActionButton extends StatelessWidget {
  LeaveActionButton({Key? key, required this.leave}) : super(key: key);
  final Leave leave;
  final UserLeavesBloc _userLeavesBLoc = getIt<UserLeavesBloc>();
  final NavigationStackManager _stackManager = getIt<NavigationStackManager>();

  @override
  Widget build(BuildContext context) {
    var _localization = AppLocalizations.of(context);
    return ElevatedButton(
      onPressed: () {
        _userLeavesBLoc.cancelLeave(leave: leave);
        showSnackBar(context,
            (leave.leaveStatus == pendingLeaveStatus)
                ? _localization.user_leave_detail_cancel_leave_message
                : _localization.user_leave_detail_delete_leave_message);
        _stackManager.pop();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: (leave.leaveStatus == pendingLeaveStatus)
            ? AppColors.greyColor
            : AppColors.redColor,
        fixedSize: Size(MediaQuery.of(context).size.width * 0.918518, 45),
      ),
      child: Text(
          (leave.leaveStatus == pendingLeaveStatus)
              ? _localization.user_leave_detail_button_cancel
              : _localization.user_leave_detail_button_delete,
          style: AppTextStyle.subtitleText),
    );
  }
}
