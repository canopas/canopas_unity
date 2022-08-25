import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/model/leave/leave.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/stateManager/admin/leave_status_manager.dart';
import 'package:projectunity/ui/admin/leave/detail/widget/reason_dialogue.dart';
import 'package:projectunity/configs/text_style.dart';
import '../../../../../configs/colors.dart';

class ButtonContent extends StatelessWidget {
  final _leaveStatusManager = getIt<LeaveStatusManager>();
  final _stackManager = getIt<NavigationStackManager>();
  final String leaveId;

  ButtonContent({Key? key, required this.leaveId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _localization = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              _leaveStatusManager.updateStatus(rejectLeaveStatus);
              if (_leaveStatusManager.reason == null) {
                showDialog(
                    context: context,
                    builder: (_) {
                      return ReasonDialogue();
                    });
              }

              _leaveStatusManager.addLeaveApproval(leaveId)
                  ? _stackManager.pop()
                  : null;
            },
            child: Text(
              _localization.admin_leave_detail_button_reject,
              style: AppTextStyle.subtitleTextDark,
            )),
        const SizedBox(
          width: 20,
        ),
        ElevatedButton(
            onPressed: () {
              _leaveStatusManager.updateStatus(approveLeaveStatus);
              _leaveStatusManager.addLeaveApproval(leaveId)
                  ? _stackManager.pop()
                  : null;
            },
            style: ElevatedButton.styleFrom(primary: AppColors.primaryBlue),
            child: Text(
              _localization.admin_leave_detail_button_approve,
              style: AppTextStyle.subtitleText,
            ))
      ],
    );
  }
}
